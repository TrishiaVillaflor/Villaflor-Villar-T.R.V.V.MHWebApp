CREATE PROCEDURE [dbo].[TRVVAdd]
	@Id nvarchar(50),
	@Name nvarchar(50),
	@Address nvarchar (50),
	@Phone nvarchar (50),
	@Department nvarchar(50),
	@Illness nvarchar(50),
	@Medication nvarchar (50),
	@Guardian nvarchar (50)
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO [dbo].[TRVVPatients] ([Id], [Name], [Address], [Phone], [Department], [Illness], [Medication], [Guardian])
		VALUES (@Id, @Name, @Address, @Phone, @Department, @Illness, @Medication, @Guardian)
END
	
