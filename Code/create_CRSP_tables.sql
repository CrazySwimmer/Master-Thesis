/*
	Create the CRSP tables.
	Specifiy the database that you want to use and execute.
	The tables will be created only if they do not already exist.

	Danilo Zocco
	2020-02-21
*/
USE [MASTER_THESIS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'dbo.CRSP_STOCKNAMES',N'U') IS NULL
BEGIN
	CREATE TABLE dbo.CRSP_STOCKNAMES (
		[PERMNO] [int] NOT NULL,
		[PERMCO] [int] NOT NULL,
		[NAMEDT] [date] NOT NULL,
		[NAMEENDDT] [date] NOT NULL,
		[CUSIP] [char](8) NOT NULL,
		[NCUSIP] [char](8) NULL,
		[TICKER] [varchar](5) NULL,
		[COMNAM] [nvarchar](32) NOT NULL,
		[HEXCD] [tinyint] NOT NULL,
		[EXCHCD] [smallint] NOT NULL,
		[SICCD] [smallint] NOT NULL,
		[SHRCD] [tinyint] NOT NULL,
		[SHRCLS] [char](1) NULL,
		[ST_DATE] [date] NOT NULL,
		[END_DATE] [date] NOT NULL,
		[NAMEDUM] [tinyint] NOT NULL
	);

	DECLARE @msg nvarchar(max) = N'The table dbo.CRSP_STOCKNAMES was created successfully in the database '+DB_NAME();
	RAISERROR(@msg,10,0) WITH NOWAIT
END
GO


