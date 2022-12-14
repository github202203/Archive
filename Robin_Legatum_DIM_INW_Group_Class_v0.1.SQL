
/****************************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash for Dim.INW_GroupClass Table

Owner       :- Ram Baskar
Date        :- 06/06/2022		Initial version

Run this Query from MYMI-Dev Server

************************************************************************************************************* */

Declare @DIMDATAHISTORYID INT
       ,@MAXDALDATE       DATE;

SET @DIMDATAHISTORYID = (SELECT MAX(DimDataHistoryId) FROM DWH.DimDataHistory);
SET @MAXDALDATE       = (SELECT MAX(Date_Of_LOAD)     FROM [AZURE DATALIBLEG SQLDB].[datalibleg-sqldb-01-uks-dev].[Dim].[INW_GroupClass]);


WITH 
CTE_MYMI as 
(

  SELECT DG.FIRST_DIMGROUPCLASSID AS [CLASS_ID]
        ,GROUPCLASS               AS [GROUP_CLASS]
        ,GROUPDIVISION            AS [GROUP_DIVISION]
        ,GROUPPORTFOLIO           AS [GROUP_PORTFOLIO]
        ,SYNDICATE                AS SYNDICATE
        ,ORICLASS                 AS [ORI_CLASS]
        ,RF.BUREAUNONBUREAUSWITCH AS REPORTING_FLAG
    FROM [ECLIPSE_MI].[FACTPOLICYCOUNT] FCT
   INNER JOIN ECLIPSE_MI.DIMGROUPCLASS DG ON FCT.DIMGROUPCLASSID = DG.DIMGROUPCLASSID
   INNER JOIN (SELECT * FROM [ECLIPSE_EXT].[FN_LATESTRITCBUREAUNONBUREAUSWITCH]()) RF ON RF.DIMBUREAUNONBUREAUSWITCHCATEGORYID = FCT.DIMBUREAUNONBUREAUSWITCHCATEGORYID
   WHERE FCT.DIMDATAHISTORYID = @DimDataHistoryId
  
  UNION
  SELECT DG.FIRST_DIMGROUPCLASSID AS [CLASS_ID]
        ,GROUPCLASS               AS [GROUP_CLASS]
        ,GROUPDIVISION            AS [GROUP_DIVISION]
        ,GROUPPORTFOLIO           AS [GROUP_PORTFOLIO]
        ,SYNDICATE                AS SYNDICATE
        ,ORICLASS                 AS [ORI_CLASS]
        ,RF.BUREAUNONBUREAUSWITCH AS REPORTING_FLAG
    FROM [ECLIPSE_MI].FACTSIGNEDTRANSACTION FCT
   INNER JOIN ECLIPSE_MI.DIMGROUPCLASS DG ON FCT.DIMGROUPCLASSID = DG.DIMGROUPCLASSID
   INNER JOIN (SELECT * FROM [ECLIPSE_EXT].[FN_LATESTRITCBUREAUNONBUREAUSWITCH]()) RF ON RF.DIMBUREAUNONBUREAUSWITCHCATEGORYID = FCT.DIMBUREAUNONBUREAUSWITCHCATEGORYID
   WHERE FCT.DIMDATAHISTORYID = @DimDataHistoryId
  
  UNION
  
  SELECT DISTINCT DG.FIRST_DIMGROUPCLASSID AS [CLASS_ID]
        ,GROUPCLASS               AS [GROUP_CLASS]
        ,GROUPDIVISION            AS [GROUP_DIVISION]
        ,GROUPPORTFOLIO           AS [GROUP_PORTFOLIO]
        ,SYNDICATE                AS SYNDICATE
        ,ORICLASS                 AS [ORI_CLASS]
        ,DLF.[ORILEGATUMFLAG]     AS REPORTING_FLAG
    FROM DWH_MI.DIMGROUPCLASS DG
   CROSS JOIN DWH.DIMORILEGATUMFLAG DLF
   WHERE DLF.ORILEGATUMFLAG <> 'RETAINED' 
     AND DG.GROUPCLASS = 'UNKNOWN'
  )

,CTE_DAL as 
(

  SELECT * 
    FROM [AZURE DATALIBLEG SQLDB].[datalibleg-sqldb-01-uks-dev].Dim.INW_GroupClass
   WHERE Date_Of_Load = @MAXDALDATE
  )

SELECT S.Class_ID, D.Class_Id
      ,HashBytes('SHA1',CONCAT(  S.[CLASS_ID],'%',  S.[GROUP_CLASS],'%',  S.[GROUP_DIVISION],'%',  S.[GROUP_PORTFOLIO],'%',  S.SYNDICATE,'%', S.[ORI_CLASS],'%',  S.[REPORTING_FLAG] )) as SRC_Hash
	  ,HashBytes('SHA1',CONCAT(  D.[CLASS_ID],'%',  D.[GROUP_CLASS],'%',  D.[GROUP_DIVISION],'%',  D.[GROUP_PORTFOLIO],'%',  D.SYNDICATE,'%', D.[ORI_CLASS],'%',  D.[REPORTING_FLAG] )) as TGT_Hash
	  ,Case WHEN HashBytes('SHA1',CONCAT(  S.[CLASS_ID],'%',  S.[GROUP_CLASS],'%',  S.[GROUP_DIVISION],'%',  S.[GROUP_PORTFOLIO],'%',  S.SYNDICATE,'%', S.[ORI_CLASS],'%',  S.[REPORTING_FLAG] )) = 
	             HashBytes('SHA1',CONCAT(  D.[CLASS_ID],'%',  D.[GROUP_CLASS],'%',  D.[GROUP_DIVISION],'%',  D.[GROUP_PORTFOLIO],'%',  D.SYNDICATE,'%', D.[ORI_CLASS],'%',  D.[REPORTING_FLAG] )) 
	       THEN  'Passed' 
		   ELSE 'Failed'
	    End as TestResult
	  ,S.*
	  ,D.*
  FROM CTE_MYMI S
  FULL JOIN CTE_DAL D
    ON S.Class_Id = D.Class_Id
   AND S.REPORTING_FLAG = D.REPORTING_FLAG

  
