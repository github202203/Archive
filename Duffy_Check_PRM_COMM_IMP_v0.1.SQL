with CTE_IMP as (
SELECT [AC_STAT1]
      ,[AC_STAT2]
      ,[AC_STAT3]
      ,[AC_STAT4]
      ,[AC_STAT5]
      ,[AC_STAT6]
      ,[AC_STAT7]
      ,[AC_STAT8]
      ,[AC_STAT9]
      ,[AC_STAT10]
      ,[ENTITY_CD]
      ,[TRUST_FUND]
      ,[RISK_CODE]
      ,[FIL_CODE]
      ,[AC_YEAR]
      ,[POL_REF]
      ,[INC_DATE]
      ,[ATT_DATE]
      ,[SETT_REF]
      ,[SETT_DATE]
      ,[TRAN_CD]
      ,[TRANS_DATE]
      ,[ACCOUNT_DATE]
      ,[PAY_DATE]
      ,[S_LINE]
      ,[S_ORDER]
      ,[PREM_TYPE]
      ,[RISK_ID]
      ,[CCY_ORG]
      ,[AMT_CCY_ORG]
      ,[CCY_SETT]
      ,[AMT_CCY_SETT]
      ,[unique_key]
	  --,HashBytes('SHA1',CONCAT([AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT7],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[ACCOUNT_DATE],'%',[PAY_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[PREM_TYPE],'%',[RISK_ID],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT])) as Imp_Hash
	  --Hashbytes without AC_STAT7 columns & account_date
	  ,HashBytes('SHA1',CONCAT([AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[PAY_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[PREM_TYPE],'%',[RISK_ID],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT])) as Imp_Hash
  FROM [XLPRO_TEST_210].[dbo].[PRM_COMM_IMP] --9846228
  --where pol_ref = '1212920'
  )

  ,CTE_Dev as (
SELECT [AC_STAT1]
      ,[AC_STAT2]
      ,[AC_STAT3]
      ,[AC_STAT4]
      ,[AC_STAT5]
      ,[AC_STAT6]
      ,[AC_STAT7]
      ,[AC_STAT8]
      ,[AC_STAT9]
      ,[AC_STAT10]
      ,[ENTITY_CD]
      ,[TRUST_FUND]
      ,[RISK_CODE]
      ,[FIL_CODE]
      ,[AC_YEAR]
      ,[POL_REF]
      ,[INC_DATE]
      ,[ATT_DATE]
      ,[SETT_REF]
      ,[SETT_DATE]
      ,[TRAN_CD]
      ,[TRANS_DATE]
      ,[ACCOUNT_DATE]
      ,[PAY_DATE]
      ,[S_LINE]
      ,[S_ORDER]
      ,[PREM_TYPE]
      ,[RISK_ID]
      ,[CCY_ORG]
      ,[AMT_CCY_ORG]
      ,[CCY_SETT]
      ,[AMT_CCY_SETT]
      ,[unique_key]
	  --Hashbytes with all the columns
	--  ,HashBytes('SHA1',CONCAT([AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT7],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[ACCOUNT_DATE],'%',[PAY_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[PREM_TYPE],'%',[RISK_ID],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT])) as Dev_Hash
	  --Hashbytes without AC_STAT7 & ACCOUNT_DATE columns
	  ,HashBytes('SHA1',CONCAT([AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[SETT_REF],'%',[SETT_DATE],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[PAY_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[PREM_TYPE],'%',[RISK_ID],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT])) as Dev_Hash
  FROM [XLPRO_TEST_210].[dbo].[PRM_COMM_IMP_Dev] D
  WHERE EXISTS ( SELECT 1 FROM [XLPRO_TEST_210].[dbo].[PRM_COMM_IMP] I WHERE I.POL_REF = D.POL_REF)
  --where pol_ref = '1212920'
  )

/*
       SELECT 'IMP' as Source,* FROM CTE_IMP 
	   UNION ALL
       SELECT 'DEV' as Source,* FROM CTE_DEV 
*/

SELECT TestResult, Count(*) as Total FROM (
--SELECT * FROM (
SELECT IMP_POL_REf, IMP_Hash, Dev_Pol_Ref, Dev_Hash 
      ,Case when IMP_Hash = Dev_Hash then 'Passed' else 'Failed' End as TestResult
  FROM 
      (
       SELECT POL_Ref as IMP_Pol_Ref, IMP_Hash 
         FROM CTE_IMP 
		) I
   Join
      (     
       SELECT POL_Ref as DEV_Pol_Ref, DEV_Hash 
         FROM CTE_DEV 
		) D

  on IMP_Pol_ref = Dev_Pol_Ref
 and IMP_Hash = Dev_Hash
 --)TT WHERE TestResult = 'Passed'
)TT Group by TestResult
