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
    [Id]         NVARCHAR (50) NOT NULL,
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
PRINT N'Refreshing Procedure [dbo].[TRVVAdd]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[TRVVAdd]';


GO
PRINT N'Refreshing Procedure [dbo].[TRVVDelete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[TRVVDelete]';


GO
PRINT N'Refreshing Procedure [dbo].[TRVVSearchById]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[TRVVSearchById]';


GO
PRINT N'Refreshing Procedure [dbo].[TRVVSearchByKeyword]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[TRVVSearchByKeyword]';


GO
PRINT N'Refreshing Procedure [dbo].[TRVVSearh]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[TRVVSearh]';


GO
PRINT N'Refreshing Procedure [dbo].[TRVVUpdate]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[TRVVUpdate]';


GO
PRINT N'Update complete.';


GO
