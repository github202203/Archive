
/*********************************************************************************************************

Purpose     :- Script to compare Row by Row using Hash
Table Type  :- All the FACT Tables 
Owner       :- Ram Baskar
Date        :- 26/04/2022


--EXEC QA.FactHashCheck 'DWH','FactORIPlacementDataHistory','2022-03-28','C','Scenario-1'
--EXEC QA.FactHashCheck 'DWH','FACTOriTransactionDataHistory','2022-05-03','F','Scenario-5'


******************************************************************************************************** */

CREATE or ALTER Procedure QA.FactHashCheck (@SName VARCHAR(20),@TName VARCHAR(100),@CDATE DATE, @PTYPE VARCHAR(1), @Scenario VARCHAR(250))
AS 
BEGIN

DECLARE	@COLUMNS    VARCHAR(MAX) = '', 
		@COLUMNList VARCHAR(MAX) = '', 
		@PRD		VARCHAR(150),
		@PNAME		VARCHAR(100),
		@QRY        NVARCHAR(MAX) = '';
	    
SELECT @PNAME = DimDataHistoryId
  FROM DWH.DimDataHistory
 WHERE CalendarAsAtDate = @CDATE
   AND DataHistoryCode like @PTYPE+'%'


		--SET @SNAME = 'DWH';
		--SET @TNAME = 'FactRiskCountDataHistory';
		--SET @TNAME = 'FactORITransactionDataHistory';

		SET @PRD   = '[MYMI-PRD].[MyMI_DataWareHouse]'; -- Linked Server created from MyMI-Dev
SELECT @Scenario = Case when @Scenario = 'Scenario-1' then 'FACT - Hash Check - Latest Calendar Open Period'                                + ' - ' + @TNAME
                        when @Scenario = 'Scenario-2' then 'FACT - Hash Check - Latest Calendar Closed Period'                              + ' - ' + @TNAME
						when @Scenario = 'Scenario-3' then 'FACT - Hash Check - Historical Calendar Open/Closed Period'                     + ' - ' + @TNAME
						when @Scenario = 'Scenario-5' then 'FACT - Hash Check - Financial Closed Period'                                    + ' - ' + @TNAME
		            End 


SELECT @COLUMNS    = @COLUMNS    + '[' + ColumnName + ']' + ',' + '''%''' +','
      ,@COLUMNList = @COLUMNList + '[' + ColumnName + ']' + ','

  FROM (

	    SELECT S.schema_id
		      ,S.Name             as SchemName 
	          ,T.Name             as TableName
	          ,C.Column_id
			  ,C.Name             as ColumnName

	      FROM sys.schemas S
	      join sys.tables  T
	        on S.Schema_Id = T.Schema_Id
	
	      join sys.Columns C
	        on T.object_id = C.Object_Id 
	          
	     WHERE S.name = @SNAME 
	       AND T.Name = @TNAME 
		   ) T WHERE ColumnName NOT in ('InsertDateTime','LastUpdateDateTime')
 
	    
		SELECT @COLUMNS    = SUBSTRING (@COLUMNS   ,1 ,LEN(@COLUMNS)-5)
		SELECT @COLUMNList = SUBSTRING (@COLUMNList,1 ,LEN(@COLUMNList)-1)

		--Check the output from the variables @COLUMNS/@COLUMNList/HASHBYTES ....
		--print @COLUMNS
		--print('SELECT ' + @COLUMNList) 
		--print ',HASHBYTES(' + '''SHA1''' + ',' + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as Dev_HashBytes' 

		--Building CTE Query


        SELECT @QRY =  'With CTE_PRD as ('                                                                                                          + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList)                                                                                           + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as PRD_HashBytes'          + CHAR(10) + 
							'       FROM ' + @PRD + '.' + @SNAME        + '.'      + @TNAME    +  ' with (NOLOCK)'                                  + CHAR(10) + 
							'      WHERE DimDataHistoryId = '           + @PNAME                                                                    + CHAR(10) +     
							')'                                                                                                                     + CHAR(10) + 
							

                       ',CTE_DEV as ('                                                                                                              + CHAR(10) + 
		                   ('     SELECT ' + @COLUMNList)                                                                                           + CHAR(10) + 
		                    '           ,HASHBYTES(' + '''SHA1'''       + ','      + 'CONCAT(' + @COLUMNS + ')' + ')' + 'as DEV_HashBytes'          + CHAR(10) + 
							'       FROM '              + @SNAME        + '.'      +  @TNAME   +  ' with (NOLOCK)'                                  + CHAR(10) + 
							'      WHERE DimDataHistoryId = '           + @PNAME                                                                    + CHAR(10) +     
							')' + CHAR(10) + 
							
							
        --Building Comparison Query between Prod & Dev

					        '     SELECT ' + '''' + @TNAME + '''' + ' as EntityName'                                                                + CHAR(10) +
							'           ,' + '''' + @Scenario + '''' + ' as TestType'                                                               + CHAR(10) +
							'           ,DH.WarehouseLoadId,DH.DataHistoryCode,DH.DataHistoryName,P.DimDataHistoryId as PRD_DimDataHistory'         + CHAR(10) +
							'           ,P.PRD_HashBytes, D.DimDataHistoryId as DEV_DimDataHistory,D.Dev_HashBytes'                                 + CHAR(10) +
                            '           ,Case WHEN P.PRD_HashBytes = D.Dev_HashBytes '                                                              + CHAR(10) +
	                        '                 THEN ' + '''Passed'''                                                                                 + CHAR(10) + 
			                '                 ELSE ' + '''Failed'''                                                                                 + CHAR(10) +
		                    '             End as TestResult'                                                                                        + CHAR(10) + 
							'           ,GetDate() ' + 'as TestedOn '                                                                               + CHAR(10) +
							'           ,P.*,D.*   '                                                                                                + CHAR(10) +
                            '       FROM CTE_PRD P '                                                                                                + CHAR(10) + 
							'       Left join DWH.DimDataHistory DH On P.DimDataHistoryId = DH.DimDataHistoryId'                                    + CHAR(10) +
                            '  LEFT Join CTE_DEV D '                                                                                                + CHAR(10) + 
                            '         on P.DimDataHistoryId = D.DimDataHistoryId '                                                                  + CHAR(10) +
	                        '        and P.PRD_HashBytes = D.Dev_HashBytes'
							
print @QRY							
EXECUTE sp_executesql @QRY

END;
GO


