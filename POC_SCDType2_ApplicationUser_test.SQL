--SCD Type2 Data Validation Testing (ApplicationUser_test (TestedOn 21st Nov, 2022) (Without Delete Scenario)
use EclipseBronze

--Initial Load - 525 records, Delta update records = 3 and Delta New records = 3 ===> Total of 531 records
SELECT
    ApplicationUserId,userInitials,SYS_CHANGE_OPERATION, BronzeStagingSystemLoadID,BronzeSystemLoadID,DP_ValidFromDateUTC,DP_ValidToDateUTC
   ,LEAD(DP_ValidFromDateUTC) over (Partition by ApplicationUserId Order by DP_ValidFromDateUTC) as NXT_DP_ValidFromDateUTC
   ,Case when LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId ORDER by DP_ValidFromDateUTC) is NOT NULL 
	      and LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId ORDER by DP_ValidFromDateUTC) = DP_ValidToDateUTC 
		 then 'Passed'
         when LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId Order by DP_ValidFromDateUTC) is NULL 
		  and ISNULL(CAST(DP_ValidToDateUTC as Date),'9999-12-31') = '9999-12-31' 
		 then 'Passed'
         Else 'Failed'
     End as SCDType2TestResult
	
FROM
    OPENROWSET(
        BULK 'https://dldpdev01.dfs.core.windows.net/bronze/underwriting/Internal/Eclipse/DeltaLake/dbo_ApplicationUser_test/',
        FORMAT = 'DELTA'
    ) AS [result]
Order by ApplicationUserId, DP_ValidFromDateUTC


--SCD Type2 Data Validation Testing (ApplicationUser_test (TestedOn 21st Nov, 2022) (With Soft Delete Scenario)
use EclipseBronze

--Initial Load - 525 records, Delta update records = 3 and Delta New records = 3 ===> Total of 531 records
SELECT
    ApplicationUserId,userInitials,SYS_CHANGE_OPERATION, BronzeStagingSystemLoadID,BronzeSystemLoadID,DP_ValidFromDateUTC,DP_ValidToDateUTC
   ,LEAD(DP_ValidFromDateUTC) over (Partition by ApplicationUserId Order by DP_ValidFromDateUTC) as NXT_DP_ValidFromDateUTC
   ,Case when LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId ORDER by DP_ValidFromDateUTC) is NOT NULL 
	         and LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId ORDER by DP_ValidFromDateUTC) = DP_ValidToDateUTC 
			 and SYS_CHANGE_OPERATION <> 'D' --SCD Type2 Scenario via an Update Record
			 then 'Passed'
         when LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId ORDER by DP_ValidFromDateUTC) is NOT NULL 
	         and LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId ORDER by DP_ValidFromDateUTC) <> DP_ValidToDateUTC 
			 and SYS_CHANGE_OPERATION = 'D' -- SCD Type2 Scenario via Soft Delete Scenario
			 then 'Passed'
         when LEAD(DP_ValidFromDateUTC) over ( Partition By ApplicationUserId Order by DP_ValidFromDateUTC) is NULL 
			 and ISNULL(CAST(DP_ValidToDateUTC as Date),'9999-12-31') = '9999-12-31' 
			then 'Passed'
            Else 'Failed'
        End as SCDType2TestResult
FROM
    OPENROWSET(
        BULK 'https://dldpdev01.dfs.core.windows.net/bronze/underwriting/Internal/Eclipse/DeltaLake/dbo_ApplicationUser_test/',
        FORMAT = 'DELTA'
    ) AS [result]
Order by ApplicationUserId, DP_ValidFromDateUTC


