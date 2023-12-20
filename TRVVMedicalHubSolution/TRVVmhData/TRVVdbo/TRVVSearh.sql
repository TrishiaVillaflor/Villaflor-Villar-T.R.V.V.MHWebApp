CREATE PROCEDURE [dbo].[TRVVSearh]
	AS
BEGIN
	SET NOCOUNT ON;
	 SELECT [a].[Id] AS PatientsId
		   ,[a].[Name] AS PatientsName
		   ,[a].[Address] AS PatientsAddress
		   ,[a].[Phone] AS PatientsPhone
		   ,[a].[Department] AS PatientsDepartment
		   ,[a].[Illness] AS PatientsIllness
		   ,[a].[Medication] AS PatientsMedication
		   ,[a].[Guardian] AS PatientsGuardian
	FROM [dbo].[TRVVPatients] AS a;

	END