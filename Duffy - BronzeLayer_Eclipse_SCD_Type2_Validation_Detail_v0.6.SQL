/* --------------------------------------------------------------------------------------------------------------------------------------------- 
   Version  |  Date        | Author              | Description                                                                  
--------------------------------------------------------------------------------------------------------------------------------------------- 

   0.1      |  03/11/2022  | Ram Baskar          | Initial version of SCD Type2 script (manual)
   0.2      |  04/11/2022  | Ram Baskar          | Amended the script to validate History view data rather from base view
   0.3      |  07/11/2022  | Ram Baskar          | Amended the script to pass the table name as parameter
   0.4      |  08/11/2022  | Ram Baskar          | Amended the script to display the Summary of records with Pass/Fail status
   0.5      |  09/11/2022  | Ram Baskar          | Amended the script to display the Detail of records with Pass/Fail status
   0.6      |  17/11/2022  | Ram Baskar          | Amended the script to include the History Entity Name

   THIS SCRIPT WILL DISPLAY DETAIL OF RECORDS as Test Result, not with the detail records
   
   Purpose of this script is to test SCD TYpe2 working in HISTORY views under Bronze Layer
----------------------------------------------------------------------------------------------------------------------------------------------------------- 
**********************************************************************************************************************************************************/

use EclipseBronze;

Declare @QRY				NVARCHAR(MAX) = ''
       ,@SchemaName			NVARCHAR(MAX) = 'dbo'
       ,@TableName			NVARCHAR(MAX) = 'ApplicationUser'
	   ,@TableNameHistory	NVARCHAR(MAX) = '' 
	   ,@UniqueColumn		NVARCHAR(MAX) = ''
	   ,@SystemName			NVARCHAR(MAX) = ''
	   ,@SystemLoadId		NVARCHAR(MAX) = ''
	   ,@ObjectRunId		NVARCHAR(MAX) = ''
	   ,@SystemDescription	NVARCHAR(MAX) = ''
	   ,@TestType            VARCHAR(20)  = 'SCD Type2'
;

--select * from EclipseBronze.dbo.ClaimStatus_History
SET @TableNameHistory  = @TableName + '_History'
SET @UniqueColumn      = (SELECT UniqueColumn      FROM QAData.dbo.QAControlData WHERE SourceObjectName = @SchemaName + '.' + @TableName)
SET @SystemName        = (SELECT SystemName        FROM QAData.dbo.QAControlData WHERE SourceObjectName = @SchemaName + '.' + @TableName)
SET @SystemLoadId      = (SELECT SystemLoadId      FROM QAData.dbo.QAControlData WHERE SourceObjectName = @SchemaName + '.' + @TableName)
SET @ObjectRunId       = (SELECT ObjectRunId       FROM QAData.dbo.QAControlData WHERE SourceObjectName = @SchemaName + '.' + @TableName)
SET @SystemDescription = (SELECT SystemDescription FROM QAData.dbo.QAControlData WHERE SourceObjectName = @SchemaName + '.' + @TableName)

SELECT @QRY = 'SELECT '  + '''' + @SystemName       +  '''' + ' as SystemName'    + ',' + '''' + @SystemDescription  +  ''''  + ' as SystemDescription' + 
              ' ,'       + '''' + @SystemLoadId     +  '''' + ' as SystemLoadId'  + ',' + '''' + @ObjectRunId        +  ''''  + ' as ObjectRunId'       + 
			  ' ,'       + '''' + @TableNameHistory +  '''' + ' as TableName '    + ',' + '''' + @TestType           +  ''''  + ' as "Test Type" '      +  
			  ' ,'       + '''' + CONVERT(VARCHAR,GetDate(),20 ) +  ''''  + ' as "SCDType2-ValidatedAsAt" '          +
              ' ,* '                                                                                                                                             + CHAR(10) + 
              '  FROM ('                                                                                                                                         + CHAR(10) +
              'SELECT '  +  STRING_AGG(CONCAT('', column_name, ''),   ',')                                                                                       + CHAR(10) +
              --'      ,LEAD(DP_ValidFromDateUTC) over (Partition by ' + @UniqueColumn + ' ORDER BY DP_ValidFromDateUTC ) as NXT_DP_ValidFromDATEUTC'           + CHAR(10) +
			  '      ,CASE when LEAD(DP_ValidFromDateUTC) over (Partition by '  + @UniqueColumn      + ' ORDER BY DP_ValidFromDateUTC ) is NOT NULL and '        + CHAR(10) +     
			  '                 LEAD(DP_ValidFromDateUTC) over (Partition by '  + @UniqueColumn      + ' ORDER BY DP_ValidFromDateUTC ) = DP_ValidToDateUTC'     + CHAR(10) +     
			  '            then ' + '''Passed'''                                                                                                                 + CHAR(10) + 
			  '            when LEAD(DP_ValidFromDateUTC) over (Partition by '  + @UniqueColumn      + ' ORDER BY DP_ValidFromDateUTC ) is NULL and '            + CHAR(10) +     
			  '                 ISNULL(CAST(DP_ValidToDateUTC as Date), ' + '''9999-12-31''' + ')'   + ' = ' + '''9999-12-31'''                                  + CHAR(10) +
			  '            then ' + '''Passed'''                                                                                                                 + CHAR(10) + 
			  '            else ' + '''Failed'''                                                                                                                 + CHAR(10) + 
			  '        END  as TestResult '                                                                                                                      + CHAR(10) +
              '  FROM EclipseBronze.dbo.' + @TableName + '_History' +')T'                                                                                        --+ CHAR(10) + 
			  --' WHERE TestResult = ' + '''Passed''' -- To Display only Passed Records
			  --' WHERE TestResult = ' + '''Failed'''   -- To display only Failed Records
  FROM INFORMATION_SCHEMA.COLUMNS
 --WHERE table_name = @TableName + '_History'
 WHERE table_name = @TableNameHistory
   --AND Column_Name NOT IN ('RowNumber','EffectiveDateUTC','EndDateUTC','Current','BronzeStagingSystemLoadID','BronzeSystemLoadID')
   

--Print @QRY
EXEC(@QRY)

