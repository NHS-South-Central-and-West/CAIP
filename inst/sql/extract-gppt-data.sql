/*===============================================================================================================================================================================
Query:				Extraction of GPPT data
Sub Query:			
Author:				Ruth Johnson
Creation Date:		26/04/23

19/05/23 - Added in question 104 for 2021 and 2022 data

=================================================================================================================================================================================*/
	if object_id('[CSU_Sandbox_South].dbo.GPPT_Raw') is not null drop table [CSU_Sandbox_South].dbo.GPPT_Raw
go

Select 
	[Practice_Code] 
    ,[Field_Name] as Source_Question_Number
    ,[Field_Value]
    ,Year([Effective_Snapshot_Date]) AS [Year]

INTO [CSU_Sandbox_South].dbo.GPPT_Raw
FROM [NHSE_UKHF].[GP_Patient_Survey].[vw_Practice_Level_Weighted1] Practice

WHERE 
field_name in ('Q18_1',
'Q18_12',
'Q18_12345base',
'Q18_2',
'Q18_3',
'Q18_4',
'Q18_5',
'Q18base',
'Q28_1',
'Q28_12',
'Q28_12345base',
'Q28_2',
'Q28_3',
'Q28_4',
'Q28_5',
'Q28base',
'q3_1',
'q3_12',
'q3_1234base',
'q3_2',
'q3_3',
'q3_4',
'q3_5',
'q73_1',
'q73_12',
'Q73_1234base',
'q73_2',
'q73_3',
'q73_4',
'q73_5',
'q73base',
'Q80_1',
'Q80_12',
'Q80_2',
'Q80_3',
'Q80base',
'Q104_1',
'Q104_12',
'Q104_123base',
'Q104_2',
'Q104_3',
'Q104_4',
'Q104base'
)

AND Effective_Snapshot_Date >= '2018-03-31'




	if object_id('[CSU_Sandbox_South].dbo.GPPT') is not null drop table [CSU_Sandbox_South].dbo.GPPT
go

Select 
	[Practice_Code] 
	,ODS.GP_Name as Practice_Name
	,ODS.GP_PCN_Code as PCN_Code
	,ODS.GP_PCN_Name as PCN_Name
	,[PCN_STP_Code] as ICB_Code
	,[PCN_STP_Name] as ICB_Name
	,[PCN_Region_Code] as Region_Code
	,[PCN_Region_Name] as Region_Name
    ,Source_Question_Number
	,Case
		when Source_Question_Number like 'Q3_%' then 'Q01'
		when Source_Question_Number like 'Q73_%' then 'Q04'
		when Source_Question_Number like 'Q80_%' then 'Q16'
		when Source_Question_Number like 'Q28_%' then 'Q32'
		when Source_Question_Number like 'Q18_%' then 'Q21'
		when Source_Question_Number like 'Q104_%' then 'Q16'
		End as Question_Number
	,Vari.Description as Question_Description
    ,[Field_Value]
    ,[Year]

INTO [CSU_Sandbox_South].dbo.GPPT
FROM [CSU_Sandbox_South].dbo.GPPT_Raw Practice

LEFT JOIN [NHSE_UKHF].[GP_Patient_Survey].[vw_Reporting_Variables_SCD] Vari on Practice.Source_Question_Number = Vari.Variable collate Latin1_General_CI_AS
LEFT JOIN [NHSE_Reference].[dbo].[tbl_Ref_ODS_GP_Hierarchies_All] ODS on Practice.Practice_Code = ODS.GP_Code and ODS.GP_PCN_Rel_End_Date is NULL
WHERE 
Vari.Is_Latest = 1





