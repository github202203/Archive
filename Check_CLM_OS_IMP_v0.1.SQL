With CTE_IMP as (
SELECT [EVENT]
      ,[SUB_EVENT]
      ,[AC_STAT1]
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
      ,[CLM_REF]
      ,[CLM_DOL]
      ,[LAST_ADV]
      ,[TRAN_CD]
      ,[TRANS_DATE]
      ,[ACCOUNT_DATE]
      ,[S_LINE]
      ,[S_ORDER]
      ,[MOVE_REF]
      ,[MKT_CAT_CD]
      ,[CCY_ORG]
      ,[AMT_CCY_ORG]
      ,[CCY_SETT]
      ,[AMT_CCY_SETT]
      ,[CLM_TYPE]
      ,[RISK_ID]
      ,[unique_key]
	  --,HashBytes('SHA1',CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT7],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[LAST_ADV],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[ACCOUNT_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[MOVE_REF],'%',[MKT_CAT_CD],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID])) as IMP_Hash
	  ,HashBytes('SHA1',CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[LAST_ADV],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[MOVE_REF],'%',[MKT_CAT_CD],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID])) as IMP_Hash
  FROM [XLPRO_TEST_210].[dbo].[CLM_OS_IMP] --155210
  --WHERE POL_REF = '1401276'
  )

,CTE_DEV as (
SELECT [EVENT]
      ,[SUB_EVENT]
      ,[AC_STAT1]
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
      ,[CLM_REF]
      ,[CLM_DOL]
      ,[LAST_ADV]
      ,[TRAN_CD]
      ,[TRANS_DATE]
      ,[ACCOUNT_DATE]
      ,[S_LINE]
      ,[S_ORDER]
      ,[MOVE_REF]
      ,[MKT_CAT_CD]
      ,[CCY_ORG]
      ,[AMT_CCY_ORG]
      ,[CCY_SETT]
      ,[AMT_CCY_SETT]
      ,[CLM_TYPE]
      ,[RISK_ID]
      ,[unique_key]
	  --,HashBytes('SHA1',CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],'%',[AC_STAT7],'%',[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[LAST_ADV],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[ACCOUNT_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[MOVE_REF],'%',[MKT_CAT_CD],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID])) as IMP_Hash
	  ,HashBytes('SHA1',CONCAT([EVENT],'%',[SUB_EVENT],'%',[AC_STAT1],'%',[AC_STAT2],'%',[AC_STAT3],'%',[AC_STAT4],'%',[AC_STAT5],'%',[AC_STAT6],[AC_STAT8],'%',[AC_STAT9],'%',[AC_STAT10],'%',[ENTITY_CD],'%',[TRUST_FUND],'%',[RISK_CODE],'%',[FIL_CODE],'%',[AC_YEAR],'%',[POL_REF],'%',[INC_DATE],'%',[ATT_DATE],'%',[CLM_REF],'%',[CLM_DOL],'%',[LAST_ADV],'%',[TRAN_CD],'%',[TRANS_DATE],'%',[S_LINE],'%',[S_ORDER],'%',[MOVE_REF],'%',[MKT_CAT_CD],'%',[CCY_ORG],'%',[AMT_CCY_ORG],'%',[CCY_SETT],'%',[AMT_CCY_SETT],'%',[CLM_TYPE],'%',[RISK_ID])) as DEV_Hash
  FROM [XLPRO_TEST_210].[dbo].[CLM_OS_IMP_DEV] D
  --WHERE EXISTS ( SELECT 1 FROM [XLPRO_TEST_210].[dbo].[CLM_OS_IMP] I WHERE I.POL_REF = D.POL_REF)
  --WHERE POL_REF = '1401276'
  )

/* -- For Debugging
SELECT 'IMP' as Source, * FROM CTE_IMP 
UNION ALL
SELECT 'DEV' as Source, * FROM CTE_DEV
*/


--- Compare data using Join operator

SELECT TestResult, Count(*) as TotalRecords from (
SELECT IMP_Pol_REF, IMP_Hash, DEV_POL_REF, DEV_Hash
      ,Case when IMP_Hash = Dev_Hash then 'Passed' else 'Failed' End as TestResult
 FROM 
(
SELECT POL_REF as IMP_POL_REF ,IMP_Hash FROM CTE_IMP
) IMP

--left join --To compare all the records from IMP table
join -- to compare only matching records

(
SELECT POL_REF as DEV_POL_REF ,DEV_Hash FROM CTE_DEV
) DEV

on IMP_POL_REF = DEV_POL_REF 
and IMP.IMP_HASH = DEV.DEV_Hash
)T group by TestResult --154104 records Passed



/*
SELECT POL_REF,IMP_HASH FROM CTE_IMP 
INTERSECT
SELECT POL_REF,DEV_HASH FROM CTE_DEV 
*/
