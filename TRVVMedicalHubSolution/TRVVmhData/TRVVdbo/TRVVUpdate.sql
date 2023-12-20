CREATE PROCEDURE [dbo].[TRVVUpdate]
	@Id nvarchar (50),
	@Name nvarchar (50),
	@Address nvarchar (50),
	@Phone nvarchar (50),
	@Department nvarchar (50),
	@Illness nvarchar (50),
	@Medication nvarchar (50),
	@Guardian nvarchar (50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[TRVVPatients]
	SET [Name] = @Name, 
	[Department] = @Department,
	[Address] = @Address,
	[Phone] = @Phone,
	[Illness] = @Illness,
	[Medication] = @Medication,
	[Guardian] = @Guardian
	
	WHERE [Id] = @Id
	
	END
