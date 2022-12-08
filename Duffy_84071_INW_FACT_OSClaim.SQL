
/****************************************************************************************************************

Purpose     :- Script to find any Temporary adjustments are being sent to Riverstone - INW_Fact_OSClaim

Owner       :- Ram Baskar
User Story	:- 84071
Date        :- 20/06/2022		Initial version

Run this Query from MYMI-Dev Server
Expected Result:- Query must return NO Records (Copy from [RITC_EXT].[INW_Fact_OSClaim])

************************************************************************************************************* */

DECLARE @int_DataHistoryId AS INT = (SELECT  MAX(DimDataHistoryID) AS DimDataHistoryID FROM DWH.DimDataHistory WHERE DataHistoryCode LIKE 'C%')

SELECT * 
  FROM (
SELECT 	DA.AdjustmentType
       ,FCC.[DimProcessPeriodID]/100		                        AS REPORTING_YEAR
   	   ,(FCC.DimProcessPeriodID%100-1)/3+1	                        AS REPORTING_QUARTER
	   ,'M'									                        AS PERIOD_TYPE
	   ,FCC.[DimProcessPeriodID]%100		                        AS PERIOD_NUMBER
	   ,CAST(dd.Date as Date)				                        AS TRANSACTION_DATE
	   ,DC.First_DimclaimID						                    AS CLAIM_ID
	   ,DCE.First_DimClaimEventCatastropheID	                    AS LOSS_EVENT_ID
	   ,DPL.First_DimPolicyLineID				                    AS RISK_ID
	   ,dgc.First_DimGroupClassID				                    AS CLASS_ID
	   ,CASE WHEN FCC.DimPolicyYOAID = 0 
	         THEN FCC.DimYOAID 
			 ELSE FCC.DimPolicyYOAID 
		 END									                    AS UW_YEAR
	   ,DSC.MasterDataCurrencyISOCode			                    AS SETT_CCY_CODE
	   ,DOC.MasterDataCurrencyISOCode			                    AS ORIG_CCY_CODE
	   ,DCD.LloydsRiskCode					    	                AS LLOYDS_RISK_CODE
	   ,DCD.TrustFundCode					        	            AS TRUST_FUND_CODE
	   ,CASE WHEN FCC.PaidLossFundSettCcy = 0 
	         THEN 'Cash' 
			 ELSE 'Trust Fund' 
		 END														AS PAYMENT_TYPE
	   ,DCD.FILCode2												AS FIL_CODE_2
	   ,DCD.FILCode4												AS FIL_CODE_4
	   ,DCD.FILCode													AS FIL_CODE
	   ,SUM(FCC.OutstandingClaimOrigCcyMovement)					AS OS_TOTAL_MVT_ORIG_CCY
	   ,SUM(FCC.OutstandingClaimOrigCcyMovement * RateToSettCcy)	AS OS_TOTAL_MVT_SETT_CCY
	   ,RF.BureauNonBureauSwitch									AS REPORTING_FLAG
  FROM Eclipse_MI.FactClaimTransaction FCC with (NOLOCK)
  JOIN DWH.DimAdjustment DA  with (NOLOCK) ON FCC.DimDWHAdjustmentID = DA.DimAdjustmentID 
   AND DA.ISAdjusted = 'Unadjusted' OR (DA.AdjustmentType like '%Permanent%' AND DA.DimEclipseAdjustmentID <> 0)
  JOIN Eclipse_MI.LatestFactExchangeRateOutstanding LFE  with (NOLOCK) 
    ON FCC.DimSettlementCurrencyID = LFE.DimSettlementCurrencyID 
   AND FCC.DimOriginalCurrencyID = LFE.DimOriginalCurrencyID 
   AND LFE.DimCcyConversionTypeId = 10  
   AND LFE.DimYOAID = FCC.DimYOAID   
  JOIN Eclipse_MI.DimClaim DC with (NOLOCK) 		    ON DC.DimclaimID = FCC.DimClaimID
  JOIN Eclipse_MI.DimPolicyLine DPL  with (NOLOCK)     ON FCC.DimPolicyLineID = DPL.DimPolicyLineID
  JOIN Eclipse_MI.DimCode DCD with (NOLOCK) 		    ON DCD.DimCodeID = FCC.DimCodeID
  JOIN ECLIPSE_MI.dimdate dd with (NOLOCK) 		    ON DD.DimDateID=FCC.DimTransactionDateID
  JOIN Eclipse_MI.DimCurrency DOC with (NOLOCK)        ON DOC.DimCurrencyID = FCC.DimOriginalCurrencyID
  JOIN Eclipse_MI.DimCurrency DSC with (NOLOCK)        ON DSC.DimCurrencyID = FCC.DimSettlementCurrencyID
  JOIN Eclipse_MI.DimGroupClass DGC with (NOLOCK)      ON DGC.DimGroupClassID = FCC.DimGroupClassID
  JOIN Eclipse_MI.DimClaimEvent DCE with (NOLOCK) 		ON DCE.DimClaimEventCatastropheID=FCC.DimClaimEventCatastropheID
  JOIN Eclipse_MI.DimPolicyStatus DPS with (NOLOCK) 	ON DPL.DimPolicyStatusID = dps.DimPolicyStatusID
  JOIN (SELECT * FROM Eclipse_EXT.fn_LatestRITCBureauNonBureauSwitch()) RF ON RF.DimBureauNonBureauSwitchCategoryID = FCC.DimBureauNonBureauSwitchCategoryID

--WHERE FCC.DimDataHistoryID = (SELECT Max(DimDataHistoryId) FROM DWH.DimDataHistory) AND FCC.DimYOAID >= 1993 AND dps.PolicyActiveStatus ='Active'
WHERE FCC.DimDataHistoryID = @int_DataHistoryId --(SELECT Max(DimDataHistoryId) FROM DWH.DimDataHistory) 
  AND FCC.DimYOAID >= 1993 
  AND dps.PolicyActiveStatus ='Active'

GROUP BY DA.AdjustmentType
	     ,FCC.DimProcessPeriodID / 100 
	     ,(FCC.DimProcessPeriodID%100-1) / 3+1 
	     ,FCC.DimProcessPeriodID%100
	     ,dd.Date
	     ,DC.First_DimclaimID
	     ,DPL.First_DimPolicyLineID
	     ,DOC.MasterDataCurrencyISOCode
	     ,DSC.MasterDataCurrencyISOCode
	     ,DCD.LloydsRiskCode
	     ,DCD.TrustFundCode
	     ,CASE WHEN FCC.PaidLossFundSettCcy = 0 
		       THEN 'Cash' 
			   ELSE 'Trust Fund' 
		   END
	     ,DCD.FILCode2
	     ,DCD.FILCode4
	     ,DCD.FILCode 
	     ,dgc.First_DimGroupClassID
	     ,DCE.First_DimClaimEventCatastropheID 
	     ,RF.BureauNonBureauSwitch 
	     ,CASE WHEN FCC.DimPolicyYOAID = 0 
		       THEN FCC.DimYOAID 
			   ELSE FCC.DimPolicyYOAID 
		   END 
) T WHERE UPPER(AdjustmentType) like '%TEMPORARY%'