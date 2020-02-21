/*
Prepare main RPNA tables after a fresh import.

This script assumes...


Danilo Zocco
2020-02-20
*/
USE [MASTER_THESIS]
GO

IF OBJECT_ID(N'dbo.RPNA_DJ_EQ',N'U') IS NULL OR OBJECT_ID(N'dbo.RPNA_DJ_GM',N'U') IS NULL
BEGIN
	DECLARE @msg nvarchar(max) =
		N'You first need to create the main tables.'
		+ NCHAR(13) + NCHAR(10)
		+ N'This can be done by running "create_RPNA_tables.sql".'
	RAISERROR(@msg,16,1) WITH NOWAIT
	RETURN
END

DECLARE @qry nvarchar(max);
DECLARE @table_name nvarchar(128);
DECLARE @database_name nvarchar(128) = DB_NAME();

DECLARE current_table CURSOR
LOCAL FAST_FORWARD FOR
	SELECT [name]
	FROM sys.tables
	WHERE [name] LIKE N'DJ_GLOBAL_MACRO_20%'
		OR [name] LIKE N'DJ_EQUITIES_20%';

OPEN current_table;
FETCH NEXT FROM current_table INTO @table_name;

WHILE @@FETCH_STATUS=0
BEGIN
	SET @qry =
	N'INSERT INTO '+QUOTENAME(@database_name)+N'.[dbo].[RPNA_DJ_'+CASE WHEN @table_name LIKE N'DJ_EQUITIES_20%' THEN N'EQ' ELSE N'GM' END+N']
        ([TIMESTAMP_EST]
        ,[RP_ENTITY_ID]
        ,[ENTITY_TYPE]
        ,[ENTITY_NAME]
        ,[POSITION_NAME]
        ,[RP_POSITION_ID]
        ,[COUNTRY_CODE]
        ,[RELEVANCE]
        ,[TOPIC]
        ,[GROUP]
        ,[TYPE]
        ,[SUB_TYPE]
        ,[PROPERTY]
        ,[EVALUATION_METHOD]
        ,[MATURITY]
        ,[CATEGORY]
        ,[ESS]
        ,[AES]
        ,[AEV]
        ,[ENS]
        ,[ENS_SIMILARITY_GAP]
        ,[ENS_KEY]
        ,[ENS_ELAPSED]
        ,[G_ENS]
        ,[G_ENS_SIMILARITY_GAP]
        ,[G_ENS_KEY]
        ,[G_ENS_ELAPSED]
        ,[EVENT_SIMILARITY_KEY]
        ,[NEWS_TYPE]
        ,[SOURCE]
		,[RP_STORY_ID]
        ,[RP_STORY_EVENT_INDEX]
        ,[RP_STORY_EVENT_COUNT]
        ,[PRODUCT_KEY]'
	+ CASE
		WHEN @table_name LIKE N'DJ_EQUITIES_20%' THEN N'
        ,[COMPANY]
        ,[ISIN]
        ,[CSS]
        ,[NIP]
        ,[PEQ]
        ,[BEE]
        ,[BMQ]
        ,[BAM]
        ,[BCA]
        ,[BER]
        ,[ANL_CHG]
        ,[MCQ]'
		ELSE N'' END
		+N')
	SELECT
		CONVERT(datetimeoffset(3),[TIMESTAMP_UTC]) AT TIME ZONE ''Eastern Standard Time''
		,[RP_ENTITY_ID]
		,[ENTITY_TYPE]
		,[ENTITY_NAME]
		,[POSITION_NAME]
		,[RP_POSITION_ID]
		,[COUNTRY_CODE]
		,[RELEVANCE]
		,[TOPIC]
		,[GROUP]
		,[TYPE]
		,[SUB_TYPE]
		,[PROPERTY]
		,[EVALUATION_METHOD]
		,[MATURITY]
		,[CATEGORY]
		,[ESS]
		,[AES]
		,[AEV]
		,[ENS]
		,[ENS_SIMILARITY_GAP]
		,[ENS_KEY]
		,[ENS_ELAPSED]
		,[G_ENS]
		,[G_ENS_SIMILARITY_GAP]
		,[G_ENS_KEY]
		,[G_ENS_ELAPSED]
		,[EVENT_SIMILARITY_KEY]
		,[NEWS_TYPE]
		,[SOURCE]
		,[RP_STORY_ID]
		,[RP_STORY_EVENT_INDEX]
		,[RP_STORY_EVENT_COUNT]
		,[PRODUCT_KEY]'
	+ CASE
		WHEN @table_name LIKE N'DJ_EQUITIES_20%' THEN N'
        ,[COMPANY]
        ,[ISIN]
        ,[CSS]
        ,[NIP]
        ,[PEQ]
        ,[BEE]
        ,[BMQ]
        ,[BAM]
        ,[BCA]
        ,[BER]
        ,[ANL_CHG]
        ,[MCQ]'
		ELSE N'' END +N'
	FROM '+QUOTENAME(@database_name)+N'.[dbo].'+QUOTENAME(@table_name)+N';
	
	DROP TABLE dbo.'+QUOTENAME(@table_name)+N';';

	SET @msg = N'Starting table dbo.'+QUOTENAME(@table_name)+N'...';
	RAISERROR (@msg,10,0) WITH NOWAIT;
	EXECUTE sp_executesql @qry;
	CHECKPOINT;

	FETCH NEXT FROM current_table INTO @table_name;
END

CLOSE current_table;
DEALLOCATE current_table;
GO

DELETE FROM dbo.RPNA_DJ_EQ WHERE TIMESTAMP_EST < '2000-01-01' AND TIMESTAMP_EST>='2020-01-01';
ALTER TABLE dbo.RPNA_DJ_EQ ADD CONSTRAINT [PK_RPNA_DJ_EQ] PRIMARY KEY CLUSTERED ([RP_ENTITY_ID] ASC, [RP_STORY_ID] ASC);
CHECKPOINT
CREATE NONCLUSTERED INDEX [IX_RPNA_DJ_EQ] ON dbo.RPNA_DJ_EQ ([TIMESTAMP_EST] ASC);
CHECKPOINT
GO

DELETE FROM dbo.RPNA_DJ_GM WHERE TIMESTAMP_EST<'2000-01-01' AND TIMESTAMP_EST>='2020-01-01';
ALTER TABLE dbo.RPNA_DJ_GM ADD CONSTRAINT [PK_RPNA_DJ_GM] PRIMARY KEY CLUSTERED ([RP_ENTITY_ID] ASC, [RP_STORY_ID] ASC);
CHECKPOINT
CREATE NONCLUSTERED INDEX [IX_RPNA_DJ_GM] ON dbo.RPNA_DJ_GM ([TIMESTAMP_EST] ASC);
CHECKPOINT
GO
