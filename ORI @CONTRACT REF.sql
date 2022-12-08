/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 

	  G.GroupClass, 
	  [IsAdjusted]
      ,F.[DimORILegatumFlagID],F.DimYOAID,
	  L.ORILegatumFlag, P.ORIContractReference   
      ,sUM([ORISignedPremiumPaidSettCcy]) AS ORISignedPremiumPaidSettCcy 

  FROM [MyMI_DataWarehouse].[DWH_MI].[FactORITransaction] F
  INNER JOIN MyMI_DataWarehouse.DWH_MI.DimORIPlacement P ON P.DimORIPlacementID=F.DimORIPlacementID
  INNER JOIN MyMI_DataWarehouse.DWH.DimORILegatumFlag L ON L.DimORILegatumFlagID=F.DimORILegatumFlagID
  INNER JOIN MyMI_DataWarehouse.DWH_MI.DimGroupClass G ON G.DimGroupClassID=F.DimGroupClassID
  WHERE F.DimDataHistoryID IN ( 
  SELECT MAX(DimDataHistoryID) FROM MyMI_DataWarehouse.DWH_MI.DimDataHistory )
  AND G.GroupClass='AVIATION BY'
  --AND L.ORILegatumFlag='Legatum'
  AND P.ORIContractReference='LEGATUM2018'

  GROUP BY      
  G.GroupClass, 
	  [IsAdjusted]
      ,F.[DimORILegatumFlagID],F.DimYOAID
	  ,L.ORILegatumFlag
	  ,P.ORIContractReference  