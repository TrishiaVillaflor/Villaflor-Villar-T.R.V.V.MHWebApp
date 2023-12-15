CREATE PROCEDURE [dbo].[TRVVSearh]
	AS
BEGIN
	SET NOCOUNT ON;
	 SELECT [a].[Id] AS PatientsId
		   ,[a].[Name] AS PatientsName
		   ,[a].[Department] AS PatientsDepartment
		   ,[a].[Illness] AS PatientsIllness
	FROM [dbo].[TRVVPatients] AS a;

	END