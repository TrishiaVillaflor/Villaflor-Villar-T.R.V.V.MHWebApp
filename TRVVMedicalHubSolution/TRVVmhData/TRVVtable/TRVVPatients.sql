CREATE TABLE [dbo].[TRVVPatients]
(
	[Id] NVARCHAR(50) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL, 
    [Address] NVARCHAR(50) NOT NULL,
    [Phone] NVARCHAR (50) NOT NULL,
    [Department] NVARCHAR(50) NOT NULL, 
    [Illness] NVARCHAR(50) NOT NULL, 
    [Medication] NVARCHAR(50) NOT NULL, 
    [Guardian] NVARCHAR(50) NOT NULL

)
