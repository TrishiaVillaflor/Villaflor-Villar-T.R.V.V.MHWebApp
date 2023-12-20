CREATE PROCEDURE [dbo].[TRVVSearchById]
	@Id NVARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(1) [a].[Id] AS PatientsId
		,[a].[Name] AS PatientsName
		,[a].[Address] AS PatientsAddress
		,[a].[Phone] AS PatientsPhone
		,[a].[Department] AS PatientsDepartment
		,[a].[Illness] AS PatientsIllness
		,[a].[Medication] AS PatientsMedication
		,[a].[Guardian] AS PatientsGuardian
	FROM [dbo].[TRVVPatients] AS a
	WHERE [a].[Id] = @Id;
END
