-- BNB flag Configuratiob Check for a single table testing
CREATE or ALTER VIEW [QA].[BNB_Switch_Config_Check] AS
SELECT T.*,
        --Legatum Rules 
		Case WHEN BureauNonBureauSwitch = 
		          --Legatum Rules 
                  Case WHEN (GroupClass = 'AVIATION BY' and MIN_YOA >= 2002  and MAX_YOA <= 2014 /*and DimProcessPeriodID >= 201811*/) OR
	                        (GroupClass = 'DISC 2400'	and MIN_YOA >= 1993  and MAX_YOA <= 2014 /*and DimProcessPeriodID >= 201811*/) OR
		          	        (GroupClass = 'DISC 800'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'DISC UK'	    and MIN_YOA >= 2002  and MAX_YOA <= 2014 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'PI NON-US'	and MIN_YOA >= 2002  and MAX_YOA <= 2017 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'EL UK'		and MIN_YOA >= 2002  and MAX_YOA <= 2014 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'PL INT'	    and MIN_YOA >= 2004  and MAX_YOA <= 2004 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'PL UK'		and MIN_YOA >= 2002  and MAX_YOA <= 2014 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'DISC 735'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'DISC 250'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 /*and DimProcessPeriodID >= 201811*/) OR 
							(GroupClass = 'DISC 1202'	and MIN_YOA >= 1993  and MAX_YOA <= 2001 /*and DimProcessPeriodID >= 201811*/) OR 
		          	        (GroupClass = 'DISC 2040'	and MIN_YOA >= 1993  and MAX_YOA <= 2014 /*and DimProcessPeriodID >= 201811*/) 
		          	   THEN 'RITC Legatum'
					   --ELSE 'RITC Legatum Failed'
	               End 
		     THEN 'Passed' 

			 WHEN BureauNonBureauSwitch = 
			      --Robin Rules 
			      Case WHEN (GroupClass = 'BGSU CASUALTY RI LATAM'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR
		          	        (GroupClass = 'BGSU ENGINEERING FAC LATAM'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGSU INLAND MARINE'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGSU LIABILITY ARP SC'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGSU LIABILITY PACKAGE CJSO'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGSU LIABILITY PACKAGE FD'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGSU PROPERTY FAC LATAM'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGSU PROPERTY PACKAGE CJSO'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGSU PROPERTY PACKAGE FD'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'BGSU PROGRAMS'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
		          	        (GroupClass = 'BGS SINGAPORE'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'CHINA CONSTRUCTION'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'ENGINEERING & CPE'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'AEROSPACE LIABILITY'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'AIRLINES HULL'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'AIRLINES LIABILITY'			and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'AVIATION XL'					and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'GENERAL AVIATION HULL'		and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'GENERAL AVIATION LIABILITY'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'SCION CASUALTY'				and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'BGSU LIABILITY PACKAGE SIR'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) OR 
							(GroupClass = 'BGSU PROPERTY PACKAGE SIR'	and MIN_YOA >= 2002 and MAX_YOA <= 2020 and ExternalSyndicate = '2987' /*and DimProcessPeriodID > 202109*/) 
		          	   THEN 'RITC Robin'
					   --ELSE 'RITC Robin Failed'
	               End
			 THEN 'Passed'
			 ELSE 'Failed - or N/A for Legatum/Robin'
				   
		 End as  TestResult
		
  FROM (
        SELECT 'LatestFactSignedTransaction' as TableName
		      ,'Legatum/Robin - ConfigCheck' as ConfigCheck
			  ,L.ExternalSyndicate
              ,BS.BureauNonBureauSwitch 
        	  ,DG.GroupClass
        	  ,MIN(DimYOAID) Min_YOA
        	  ,MAX(DImYOAID) Max_YOA
			  ,DimProcessPeriodID
        
          FROM DWH_MI.LatestFactSignedTransaction F
          JOIN DWH_MI.LatestBridgeBureauNonBureauSwitch BNBS ON BNBS.DimBureauNonBureauSwitchCategoryID = F.DimBureauNonBureauSwitchCategoryID
		  JOIN Eclipse_MI.DimLegalEntity L                   ON L.DimLegalEntityID = F.DimLegalEntityID
          JOIN DWH_MI.DimBureauNonBureauSwitch BS            ON BS.DimBureauNonBureauSwitchID = BNBS.DimBureauNonBureauSwitchID
          JOIN DWH_MI.DimGroupClass DG                       ON DG.DimGroupClassID = F.DimGroupClassID
          JOIN DWH_MI.DimPolicy DP                           ON DP.DimPolicyID = F.DimPolicyID
         WHERE BS.BureauNonBureauSwitch IN ('RITC Legatum','RITC Robin')
		 --WHERE BS.BureauNonBureauSwitch = 'RITC Robin'
         GROUP BY ExternalSyndicate,BS.BureauNonBureauSwitch , DG.GroupClass, DimProcessPeriodID
		)T


--SELECT * FROM Eclipse_MI.DimLegalEntity