/*
Prepare CRSP tables after a fresh import.

This script assumes...


Danilo Zocco
2020-02-21
*/
USE [MASTER_THESIS]
GO

IF OBJECT_ID(N'dbo.CRSP_STOCKNAMES',N'U') IS NULL
BEGIN
	DECLARE @msg nvarchar(max) =
		N'You first need to create the main tables.'
		+ NCHAR(13) + NCHAR(10)
		+ N'This can be done by running "create_CRSP_tables.sql".'
	RAISERROR(@msg,16,1) WITH NOWAIT
	RETURN
END

INSERT INTO dbo.CRSP_STOCKNAMES
	([PERMNO]
	,[PERMCO]
	,[NAMEDT]
	,[NAMEENDDT]
	,[CUSIP]
	,[NCUSIP]
	,[TICKER]
	,[COMNAM]
	,[HEXCD]
	,[EXCHCD]
	,[SICCD]
	,[SHRCD]
	,[SHRCLS]
	,[ST_DATE]
	,[END_DATE]
	,[NAMEDUM])
SELECT
	 [PERMNO]
	,[PERMCO]
	,DATEFROMPARTS(LEFT(CONVERT(varchar(8),[NAMEDT]),4),SUBSTRING(CONVERT(varchar(8),[NAMEDT]),5,2),RIGHT(CONVERT(varchar(8),[NAMEDT]),2))
	,DATEFROMPARTS(LEFT(CONVERT(varchar(8),[NAMEENDDT]),4),SUBSTRING(CONVERT(varchar(8),[NAMEENDDT]),5,2),RIGHT(CONVERT(varchar(8),[NAMEENDDT]),2))
	,[CUSIP]
	,[NCUSIP]
	,[TICKER]
	,[COMNAM]
	,[HEXCD]
	,[EXCHCD]
	,[SICCD]
	,[SHRCD]
	,[SHRCLS]
	,DATEFROMPARTS(LEFT(CONVERT(varchar(8),[ST_DATE]),4),SUBSTRING(CONVERT(varchar(8),[ST_DATE]),5,2),RIGHT(CONVERT(varchar(8),[ST_DATE]),2))
	,DATEFROMPARTS(LEFT(CONVERT(varchar(8),[END_DATE]),4),SUBSTRING(CONVERT(varchar(8),[END_DATE]),5,2),RIGHT(CONVERT(varchar(8),[END_DATE]),2))
	,[NAMEDUM]
FROM dbo.CRSP_STOCKNAMES_temp;

DROP TABLE dbo.CRSP_STOCKNAMES_temp;
CHECKPOINT
GO
