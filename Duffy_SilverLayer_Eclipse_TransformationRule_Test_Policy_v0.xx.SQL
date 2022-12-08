
/**********************************************************************************************************************************************************
   Version  |  Date        | Author              | Description                                                                  
--------------------------------------------------------------------------------------------------------------------------------------------- 


   0.1      |  19/11/2022  | Ram Baskar          | Script to validate Transformation Rule between Bronze Staging - Silver Staging
   0.2      |  21/11/2022  | Ram Baskar          | Amended the script with Hash Bytes for validation
   0.3      |  22/11/2022  | Ram Baskar          | Amended the script to compare the data between Parquet to Parquet
   0.4      |  23/11/2022  | Ram Baskar          | Dynamic SQL to pass the FileName as a parameter

	 Layer:Silver 
	Entity:Policy

**********************************************************************************************************************************************************/


DECLARE @SchemaName              VARCHAR(10)   = 'dbo'
	   ,@SystemLoadID			 BIGINT		   = 1022022111502
	   ,@TableName				 VARCHAR(100)  = 'Policy'
       ,@OBjectName				 VARCHAR(100)  = 'dbo_Policy'
       ,@QRY				     VARCHAR(MAX)  = ''
       ,@StageFileName			 VARCHAR(MAX)  = '' 
	   ,@DeltaFileName			 VARCHAR(MAX)  = '' 
	   ,@Environment			 VARCHAR(MAX)  = ''
	   ,@DataSource				 VARCHAR(MAX)  = ''
	   ,@StagePath				 VARCHAR(MAX)  = ''
	   ,@DeltaPath				 VARCHAR(MAX)  = ''
	   ,@QADBName				 VARCHAR(MAX)  = 'QAData'
	   ,@Parquet			    NVARCHAR(MAX)  = 'parquet'
	   ,@QRY1	        		NVARCHAR(MAX)  = ''
       ,@QADatabaseName			NVARCHAR(MAX)  = 'QAData'
	   ,@SystemDescription      NVARCHAR(MAX)  = ''
	   ,@EXISTING_TABLE 		NVARCHAR(MAX)  = ''
	   ,@QAFileFormat           NVARCHAR(MAX)  = '[SynapseParquetFormat]'
	   ,@TRFile                 NVARCHAR(MAX)  = ''
	   ,@FileTimeStamp	        NVARCHAR(MAX)  = ''
	   ,@Location               NVARCHAR(MAX)  = ''
       ,@SystemName       	    NVARCHAR(MAX)  = ''
       ,@SourceObjectId   	    NVARCHAR(MAX)  = ''
       ,@SourceObjectName 	    NVARCHAR(MAX)  = ''
       ,@UniqueColumn           NVARCHAR(MAX)  = ''
       ,@ObjectRunId            NVARCHAR(MAX)  = ''
	   ,@TestType                VARCHAR(200)  = 'Data Transformation Rule - Testing' 

IF 
    Substring(@@SERVERNAME,8,3) = 'dev'
    SET @Environment = 'Dev'
ELSE IF 
    Substring(@@SERVERNAME,8,3) = 'tst'
    SET @Environment = 'Tst'
ELSE IF 
    Substring(@@SERVERNAME,8,3) = 'uat'
    SET @Environment = 'Uat'
ELSE IF 
    Substring(@@SERVERNAME,8,3) = 'prd'
    SET @Environment = 'Prd'
ELSE 
    SET @Environment = ''

SET @StagePath     = (SELECT StagePath  from QAData.dbo.ConfigData where Environment =  + @Environment )
SET @DeltaPath     = (SELECT DeltaPath  from QAData.dbo.ConfigData where Environment =  + @Environment )
SET @DataSource    = (SELECT DataSource from QAData.dbo.ConfigData where Environment =  + @Environment )
SET @SystemLoadId  = (SELECT SystemLoadId FROM QAData.dbo.QAControlData WHERE SourceObjectName = @SchemaName + '.' + @TableName and CAST(SystemLoadId as VARCHAR(20)) like '102%')

SET @StageFileName = @StagePath + @SchemaName + '_' + @TableName + '/SystemLoadID='+ CAST(@SystemLoadID AS VARCHAR(20)) + '/' + @SchemaName + '_' + @TableName + '_'+ CAST(@SystemLoadID AS VARCHAR(20)) + '.parquet'
SET @DeltaFileName = @DeltaPath + @SchemaName + '_' + @TableName + '/*.parquet'

SET @QRY = N'
WITH CTE_Source as (
SELECT  
        PolicyRef                                                                                              as SRC_PolicyReference 
	   ,Case when ProgramRef is NULL then SUBSTRING(PolicyRef,1,8) else ProgramRef End                         as SRC_ProgrammeReference 
	   ,PolicyId                                                                                               as SRC_PolicyID
	   ,ISNULL(YOA,0)                                                                                          as SRC_YOA
	   ,Case when InceptionDate is NULL then CAST(''1900-01-01'' as Date) else CAST(InceptionDate as Date) End   as SRC_InceptionDate
	   ,Case when ExpiryDate    is NULL then CAST(''1900-01-01'' as Date) else CAST(ExpiryDate    as Date) End   as SRC_ExpiryDate
	   ,Case when DateWritten   is NULL then CAST(''1900-01-01'' as Date) else CAST(DateWritten   as Date) End   as SRC_WrittenDate
	   ,ISNULL(UPPER(PlacingType), '')                                                                         as SRC_PlacingBasis 
	   ,cpb.conformedCode                                                                                      as SRC_PlacingBasisCode
	   ,cpb.name                                                                                               as SRC_PlacingBasisName
	   ,ISNULL(UniqueMarketRef,'')                                                                             as SRC_UniqueMarketRef
	   ,DelDate                                                                                                as SRC_DelDate
	   ,Class1                                                                                                 as SRC_Class1
	   ,Class2                                                                                                 as SRC_Class2
	   ,Class3                                                                                                 as SRC_Class3
       ,Class4                                                                                                 as SRC_Class4
	   ,EntryType                                                                                              as SRC_EntryType
	   ,ParentPolicyID                                                                                         as SRC_ParentPolicyID
	   --,UW                                                                                                     as SRC_UW
       ,(SELECT mdmCode FROM ProfiseeBronze.dbo.Ref_SourceSystem WHERE name = ''Eclipse'')                       as SRC_SourceSystemCode
   
   FROM OPENROWSET( BULK ''' + @StageFileName + ''', FORMAT = ''PARQUET'') AS SPQ
	
   Left Join ProfiseeBronze.dbo.Ref_PlacingBasis pb            on CONCAT(''ECL_'',PlacingType) = pb.code  COLLATE SQL_Latin1_General_CP1_CI_AS
   Left Join ProfiseeBronze.dbo.Ref_Conformed_PlacingBasis cpb on pb.conformedPlacingBasis     = cpb.code COLLATE SQL_Latin1_General_CP1_CI_AS
 
 )

 SELECT * FROM CTE_SOURCE

 '

 EXEC(@QRY)