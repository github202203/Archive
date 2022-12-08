--Policy Transformation Rule Test Script 
/*
SELECT 
    name, 
    collation_name 
FROM sys.databases
*/

With 
 CTE_Source as (--Policy Source Data from Eclipse Bronze Staging
 SELECT  
        PolicyRef                                                                                              as PolicyReference 
	   ,Case when ProgramRef is NULL then SUBSTRING(PolicyRef,1,8) else ProgramRef End                         as ProgrammeReference 
	   ,PolicyId                                                                                               as PolicyID
	   ,ISNULL(YOA,0)                                                                                          as YOA
	   ,Case when InceptionDate is NULL then CAST('1900-01-01' as Date) else CAST(InceptionDate as Date) End   as InceptionDate
	   ,Case when ExpiryDate    is NULL then CAST('1900-01-01' as Date) else CAST(ExpiryDate    as Date) End   as ExpiryDate
	   ,Case when DateWritten   is NULL then CAST('1900-01-01' as Date) else CAST(DateWritten   as Date) End   as WrittenDate
	   ,ISNULL(UPPER(PlacingType), '')                                                                         as PlacingBasis 
	   ,cpb.conformedCode                                                                                      as PlacingBasisCode
	   ,cpb.name                                                                                               as PlacingBasisName
	   ,Case when UniqueMarketRef is NULL then '' else UniqueMarketRef End                                     as UniqueMarketRef
   FROM EclipseBronze.dbo.Policy
   Left Join ProfiseeBronze.dbo.Ref_PlacingBasis pb            on CONCAT('ECL_',PlacingType) = pb.code COLLATE SQL_Latin1_General_CP1_CI_AS
   Left Join ProfiseeBronze.dbo.Ref_Conformed_PlacingBasis cpb on pb.conformedPlacingBasis   = cpb.code
  --WHERE PolicyId = 28
)

,CTE_Target as (
 SELECT 
       PolicyReference                                                                                         as TGT_PolicyReference 
      ,ProgrammeReference                                                                                      as TGT_ProgrammeReference
      ,PolicyID                                                                                                as TGT_PolicyID
      ,YOA                                                                                                     as TGT_YOA
      ,InceptionDate                                                                                           as TGT_InceptionDate
      ,ExpiryDate                                                                                              as TGT_ExpiryDate
      ,WrittenDate                                                                                             as TGT_WrittenDate
      ,PlacingBasis                                                                                            as TGT_PlacingBasis 
      ,PlacingBasisCode                                                                                        as TGT_PlacingBasisCode
      ,PlacingBasisName                                                                                        as TGT_PlacingBasisName
      ,UniqueMarketRef                                                                                         as TGT_UniqueMarketRef
   FROM Silver.dbo.Policy 
  --WHERE PolicyID = 28
)

,ExpectedResult as (

SELECT  SRC.PolicyReference ,SRC.ProgrammeReference,SRC.PolicyID,SRC.YOA,SRC.InceptionDate,SRC.ExpiryDate,SRC.WrittenDate,SRC.PlacingBasis ,SRC.PlacingBasisCode,SRC.PlacingBasisName,SRC.UniqueMarketRef
--Hash Bytes with all Policy & Profisee derived columns
       --,HASHBYTES('SHA1',CONCAT(SRC.PolicyReference ,'%',SRC.ProgrammeReference,'%',SRC.PolicyID,'%',SRC.YOA,'%',SRC.InceptionDate,'%',SRC.ExpiryDate,'%',SRC.WrittenDate,'%',SRC.PlacingBasis,'%',SRC.PlacingBasisCode,'%',SRC.PlacingBasisName,'%',SRC.UniqueMarketRef)) as SRCHB
--Hash Bytes with only Policy & no Profisee derived columns due to COLLATION conflict
	   ,HASHBYTES('SHA1',CONCAT(SRC.PolicyReference ,'%',SRC.ProgrammeReference,'%',SRC.PolicyID,'%',SRC.YOA,'%',SRC.InceptionDate,'%',SRC.ExpiryDate,'%',SRC.WrittenDate,'%',SRC.PlacingBasis,'%',SRC.UniqueMarketRef)) as SRCHB
       ,TGT_PolicyReference ,TGT_ProgrammeReference,TGT_PolicyID,TGT_YOA,TGT_InceptionDate,TGT_ExpiryDate,TGT_WrittenDate,TGT_PlacingBasis ,TGT_PlacingBasisCode,TGT_PlacingBasisName,TGT_UniqueMarketRef
--Hash Bytes with all Policy & Profisee derived columns
	   --,HASHBYTES('SHA1',CONCAT(TGT_PolicyReference,'%',TGT_ProgrammeReference,'%',TGT_PolicyID,'%',TGT_YOA,'%',TGT_InceptionDate,'%',TGT_ExpiryDate,'%',TGT_WrittenDate,'%',TGT_PlacingBasis,'%',TGT_PlacingBasisCode,'%',TGT_PlacingBasisName,'%',TGT_UniqueMarketRef))  as TGTHB
--Hash Bytes with only Policy & no Profisee derived columns due to COLLATION conflict
	   ,HASHBYTES('SHA1',CONCAT(TGT_PolicyReference,'%',TGT_ProgrammeReference,'%',TGT_PolicyID,'%',TGT_YOA,'%',TGT_InceptionDate,'%',TGT_ExpiryDate,'%',TGT_WrittenDate,'%',TGT_PlacingBasis,'%',TGT_UniqueMarketRef))  as TGTHB
 FROM (

SELECT 
      PolicyReference 
     ,ProgrammeReference
     ,PolicyID
     ,YOA
     ,InceptionDate
     ,ExpiryDate
     ,WrittenDate
     ,PlacingBasis 
     ,PlacingBasisCode
     ,PlacingBasisName
     ,UniqueMarketRef
     
  FROM CTE_Source
  ) SRC

  Left Join 
(
SELECT 
      TGT_PolicyReference 
     ,TGT_ProgrammeReference
     ,TGT_PolicyID
     ,TGT_YOA
     ,TGT_InceptionDate
     ,TGT_ExpiryDate
     ,TGT_WrittenDate
     ,TGT_PlacingBasis 
     ,TGT_PlacingBasisCode
     ,TGT_PlacingBasisName
     ,TGT_UniqueMarketRef
     
  FROM CTE_Target
  )TGT 

  on SRC.PolicyID = TGT_PolicyID
  ) 
  
SELECT *
      ,Case when SRCHB = TGTHB then 'Passed' else 'Failed' End as TestResult 
  FROM ExpectedResult

