CREATE PROCEDURE [dbo].[TRVVSearchById]
	@Id NVARCHAR(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP(1) [a].[Id] AS PatientsId
		,[a].[Name] AS PatientsName
		,[a].[Department] AS PatientsDepartment
		,[a].[Illness] AS PatientsIllness
	FROM [dbo].[TRVVPatients] AS a
	WHERE [a].[Id] = @Id;
END
