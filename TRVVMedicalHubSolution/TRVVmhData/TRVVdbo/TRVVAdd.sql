CREATE PROCEDURE [dbo].[TRVVAdd]
	@Id nvarchar(50),
	@Name nvarchar(50),
	@Department nvarchar(50),
	@Illness nvarchar(50)
AS
BEGIN
SET NOCOUNT ON;
		INSERT INTO [dbo].[TRVVPatients] ([Id], [Name], [Department], [Illness])
		VALUES (@Id, @Name, @Department, @Illness)
END
	
