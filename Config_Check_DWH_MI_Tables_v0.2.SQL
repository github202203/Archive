SELECT T.*,
        --Legatum Rules 
        Case WHEN (GroupClass = 'AVIATION BY' and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR
	              (GroupClass = 'DISC 2400'	  and MIN_YOA >= 1993  and MAX_YOA <= 2014) OR
			      (GroupClass = 'DISC 800'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
			      (GroupClass = 'DISC UK'	  and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR 
			      (GroupClass = 'PI NON-US'	  and MIN_YOA >= 2002  and MAX_YOA <= 2017) OR 
			      (GroupClass = 'EL UK'		  and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR 
			      (GroupClass = 'PL INT'	  and MIN_YOA >= 2004  and MAX_YOA <= 2004) OR 
			      (GroupClass = 'PL UK'		  and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR 
			      (GroupClass = 'DISC 735'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
			      (GroupClass = 'DISC 250'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
			      (GroupClass = 'DISC 1202'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
			      (GroupClass = 'DISC 2040'	  and MIN_YOA >= 1993  and MAX_YOA <= 2014) 
        --Robin Rules 				  
			 THEN 'RITC Legatum'
	    End as ExpectedFlag
  FROM (
SELECT 'LatestFactSignedTransaction' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM  DWH_MI.LatestFactSignedTransaction F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

 SELECT 'LatestFactAssuredCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactAssuredCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactClaimCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactClaimCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactClaimTransaction' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactClaimTransaction F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactClaimTransactionCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactClaimTransactionCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactEarnedPremium' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactEarnedPremium F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

  UNION ALL

  SELECT 'LatestFactLimit' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactLimit F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

  UNION ALL

  SELECT 'LatestFactORIContractCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactORIContractCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

  UNION ALL

  SELECT 'LatestFactPolicyCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactPolicyCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

  UNION ALL

  SELECT 'LatestFactPolicyProgrammeCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactPolicyProgrammeCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

  UNION ALL

  SELECT 'LatestFactPricing' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactPricing F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactQuoteCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactQuoteCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactSettlementSchedule' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactSettlementSchedule F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactSignedTransactionUnadjusted' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactSignedTransactionUnadjusted F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactSubmissionCount' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactSubmissionCount F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 UNION ALL

  SELECT 'LatestFactWrittenPremium' AS TABLENAME
       ,BS.BureauNonBureauSwitch 
	   ,DG.GroupClass
	   ,MIN(DimYOAID) MIN_YOA
	   ,MAX(DImYOAID) MAX_YOA

  FROM DWH_MI.LatestFactWrittenPremium F
  JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
  JOIN DWH_MI.DimBureauNonBureauSwitch BS ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
  JOIN DWH_MI.DimGroupClass DG ON DG.DimGroupClassID = F.DimGroupClassID
  JOIN DWH_MI.DimPolicy DP ON DP.DimPolicyID = F.DimPolicyID
 WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
 GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass

 )T 