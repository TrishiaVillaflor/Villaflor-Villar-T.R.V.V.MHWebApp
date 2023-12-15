CREATE PROCEDURE [dbo].[TRVVDelete]
	@Id nvarchar(50)
AS
BEGIN
SET NOCOUNT ON;
	DELETE FROM [dbo].[TRVVPatients] WHERE [Id] = @Id;
END
	
