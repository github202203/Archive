-- BNB flag Configuration Check for a single table testing
SELECT T.*,
        
		Case WHEN BureauNonBureauSwitch = 
		--Legatum Rules as per specification
                  Case WHEN (GroupClass = 'AVIATION BY'   and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR
	                        (GroupClass = 'DISC 2400'	  and MIN_YOA >= 1993  and MAX_YOA <= 2014) OR
		          	        (GroupClass = 'DISC 800'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
		          	        (GroupClass = 'DISC UK'	      and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR 
		          	        (GroupClass = 'PI NON-US'	  and MIN_YOA >= 2002  and MAX_YOA <= 2017) OR 
		          	        (GroupClass = 'EL UK'		  and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR 
		          	        (GroupClass = 'PL INT'	      and MIN_YOA >= 2004  and MAX_YOA <= 2004) OR 
		          	        (GroupClass = 'PL UK'		  and MIN_YOA >= 2002  and MAX_YOA <= 2014) OR 
		          	        (GroupClass = 'DISC 735'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
		          	        (GroupClass = 'DISC 250'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
		          	        (GroupClass = 'DISC 1202'	  and MIN_YOA >= 1993  and MAX_YOA <= 2001) OR 
		          	        (GroupClass = 'DISC 2040'	  and MIN_YOA >= 1993  and MAX_YOA <= 2014) 
		          	   THEN 'RITC Legatum'
	               End 
		     THEN 'Passed' 
			 ELSE 'Failed' 
		 End as  TestResult
		
  FROM (
        SELECT 'LatestFactSignedTransaction' as TableName
		      ,'Legatum - ConfigCheck'       as ConfigCheck
              ,BS.BureauNonBureauSwitch      as BureauNonBureauSwitch
        	  ,DG.GroupClass                 as GroupClass
        	  ,MIN(DimYOAID)                 as Min_YOA
        	  ,MAX(DImYOAID)                 as Max_YOA
			  ,DimProcessPeriodID            as DimProcessPeriodId
          FROM DWH_MI.LatestFactSignedTransaction F
          JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
          JOIN DWH_MI.DimBureauNonBureauSwitch BS            ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
          JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
          JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
         --WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
		 WHERE BS.BureauNonBureauSwitch = 'RITC Legatum' 
		   AND DimProcessPeriodID >= '201811'
         GROUP BY BS.BureauNonBureauSwitch , DG.GroupClass, DimProcessPeriodID
		)T
 --WHERE BureauNonBureauSwitch = 'RITC Legatum' and DimProcessPeriodID >= '201811'
 --WHERE DimProcessPeriodID >= '201811'