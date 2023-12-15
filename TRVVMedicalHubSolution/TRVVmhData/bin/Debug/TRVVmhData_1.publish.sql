﻿/*
Deployment script for TRVVMHData

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "TRVVMHData"
:setvar DefaultFilePrefix "TRVVMHData"
:setvar DefaultDataPath "C:\Users\LAB-49\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\LAB-49\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Starting rebuilding table [dbo].[TRVVPatients]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_TRVVPatients] (
    [Id]         INT           NOT NULL,
    [Name]       NVARCHAR (50) NOT NULL,
    [Department] NVARCHAR (50) NOT NULL,
    [Illness]    NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[TRVVPatients])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_TRVVPatients] ([Id], [Name], [Department], [Illness])
        SELECT   [Id],
                 [Name],
                 [Department],
                 [Illness]
        FROM     [dbo].[TRVVPatients]
        ORDER BY [Id] ASC;
    END

DROP TABLE [dbo].[TRVVPatients];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_TRVVPatients]', N'TRVVPatients';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating Procedure [dbo].[TRVVAdd]...';


GO
CREATE PROCEDURE [dbo].[TRVVAdd]
	@Id nvarchar(50) NOT NULL,
	@Name nvarchar(50),
	@Department nvarchar(50),
	@Illness nvarchar(50)
AS
BEGIN
SET NOCOUNT ON;
		INSERT INTO [dbo].[TRVVPatients] ([Id], [Name], [Department], [Illness])
		VALUES (@Id, @Name, @Department, @Illness)
END
GO
PRINT N'Creating Procedure [dbo].[TRVVDelete]...';


GO
CREATE PROCEDURE [dbo].[TRVVDelete]
	@Id nvarchar(50)
AS
BEGIN
SET NOCOUNT ON;
	DELETE FROM [dbo].[TRVVPatients] WHERE [Id] = @Id;
END
GO
PRINT N'Creating Procedure [dbo].[TRVVSearchById]...';


GO
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
GO
PRINT N'Creating Procedure [dbo].[TRVVSearchByKeyword]...';


GO
CREATE PROCEDURE [dbo].[TRVVSearchByKeyword]
	@Keyword nvarchar(50)
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
GO
PRINT N'Creating Procedure [dbo].[TRVVSearh]...';


GO
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
GO
PRINT N'Creating Procedure [dbo].[TRVVUpdate]...';


GO
CREATE PROCEDURE [dbo].[TRVVUpdate]
	@Id nvarchar (50),
	@Name nvarchar (50),
	@Department nvarchar (50),
	@Illness nvarchar (50)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[TRVVPatients]
	SET [Name] = @Name, [Department] = @Department, [Illness] = @Illness
	
	WHERE [Id] = @Id
	
	END
GO
PRINT N'Update complete.';


GO
