
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

