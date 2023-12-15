CREATE PROCEDURE [dbo].[TRVVUpdate]
	@Id nvarchar (50),
	@Name nvarchar (50),
	@Department nvarchar (50),
	@Illness nvarchar (50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[TRVVPatients]
	SET [Name] = @Name, 
	[Department] = @Department, 
	[Illness] = @Illness
	WHERE [Id] = @Id
	
	END
