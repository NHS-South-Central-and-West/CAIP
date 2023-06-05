/*===============================================================================================================================================================================
Query:				Extraction of ODS data
Sub Query:			
Author:				Ruth Johnson
Creation Date:		26/04/23

Source of data is NCDR UKHF.  Joins were very slow to run, so have split into tables and CTE to get it to run quicker.

=================================================================================================================================================================================*/


IF OBJECT_ID('[CSU_Sandbox_South].dbo.PCN') IS NOT NULL
  DROP TABLE [CSU_Sandbox_South].dbo.PCN ;

SELECT a.GP_Code ,a.GP_Name,a.PCN_Code, a.PCN_Name 
INTO [CSU_Sandbox_South].dbo.PCN
		FROM(
			SELECT 
				ODS_Code as GP_Code
				,Organisation_Name as GP_Name
				,Related_ODS_Code as PCN_Code
				,Related_Organisation_Name as PCN_Name
				,RN3 = row_number() over (partition by ODS_Code order by Operational_Relationship_Start_Date desc)
			FROM [NHSE_UKHF].[ODS_API].[vwOrganisation_SCD_IsLatestWithHistoricalRelationships] 
			Where [Role] = 'Prescribing cost centre'
      		and [Related_ODS_Role] = 'PRIMARY CARE NETWORK'
		)a
		Where RN3 =1 
		

IF OBJECT_ID('[CSU_Sandbox_South].dbo.ICB') IS NOT NULL
  DROP TABLE [CSU_Sandbox_South].dbo.ICB ;


		SELECT 
			a1.GP_Code as GP_ICB_Code_Lookup
			,a1.GP_Name as GP_ICB_Name_Lookup
			,b.ICB_Code as ICB_Code_Lookup
			,b.Integrated_Care_Board_Name as Integrated_Care_Board_Name_Lookup
			INTO [CSU_Sandbox_South].dbo.ICB 
		FROM(
			SELECT * FROM(
				SELECT 
					ODS_Code as GP_Code
					,Organisation_Name as GP_Name
					,Related_ODS_Code as CCG_Code
					,Related_Organisation_Name as CCG_Name
					,RN3 = row_number() over (partition by ODS_Code order by Operational_Relationship_Start_Date desc)
				FROM [NHSE_UKHF].[ODS_API].[vwOrganisation_SCD_IsLatestWithHistoricalRelationships] 
				Where [Role] = 'Prescribing cost centre'
      			and [Related_ODS_Role] = 'CLINICAL COMMISSIONING GROUP')a
		Where RN3 =1  
		)a1

		LEFT JOIN
			(SELECT 
				[Sub_ICB_Location_ODS_Code]
				,[ICB_Code]
				,[Integrated_Care_Board_Name]
			FROM [NHSE_Reference].[dbo].[tbl_Ref_Other_Sub_ICBs_2022_23]
		)b
		on a1.CCG_Code COLLATE DATABASE_DEFAULT =b.[Sub_ICB_Location_ODS_Code] COLLATE DATABASE_DEFAULT

;With ODS as (

Select GP_ICB_Code_Lookup as GP_Code
,GP_ICB_Name_Lookup as GP_Name
,PCN_Code
,PCN_Name
,ICB_Code_Lookup as ICB_Code
,Integrated_Care_Board_Name_Lookup as ICB_Name



from[CSU_Sandbox_South].dbo.ICB ICB

left Join [CSU_Sandbox_South].dbo.PCN PCN on ICB.GP_ICB_Code_Lookup = PCN.GP_Code

where PCN_Code is not NULL
)



Select ODS.*, Org.Related_ODS_Code as Region_Code, Org.Related_Organisation_Name as Region_Name 
from ODS

LEFT JOIN [NHSE_UKHF].[ODS].[Organisation_Relationship_SCD] Org on ODS.ICB_code = Org.ODS_Code collate Latin1_General_CI_AS
where Related_ODS_Role = 'NHS ENGLAND (REGION)'
and organisation_name like '%integrated%'