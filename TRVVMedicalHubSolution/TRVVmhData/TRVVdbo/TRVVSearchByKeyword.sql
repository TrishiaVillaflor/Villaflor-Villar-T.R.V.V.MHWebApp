CREATE PROCEDURE [dbo].[TRVVSearchByKeyword]
	@Keyword nvarchar(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	SET @Keyword = CONCAT(COALESCE(@Keyword, N''), N'%');

	SELECT [a].[Id] AS PatientsId
		  ,[a].[Name] AS PatientsName
		  ,[a].[Department] AS PatientsDepartment
		   ,[a].[Illness] AS PatientsIllness
	FROM [dbo].[TRVVPatients] AS a 
	WHERE [a].[Name] like @Keyword
	ORDER BY [a].[Name];
END

