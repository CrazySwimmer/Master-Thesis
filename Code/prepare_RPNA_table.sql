/*
	Generate script to prepare RPNA tables.
	The generated script must be copied to another query window and run from there.

	Inputs:
		@table_name - Name of table to be prepared (i.e. 'DJ_EQ_20XX' or 'DJ_GM_20XX').
		@schema_name - Schema name of the table.
		@database_name - Name of the database containing the table.


	Danilo Zocco
	2020-02-20
*/

-- Inputs
DECLARE @table_name nvarchar(128) = 'DJ_EQ_20XX'; -- Exclude schema, must end with 4-digit year
DECLARE @schema_name nvarchar(128) = 'dbo';
DECLARE @database_name nvarchar(128) = 'MASTER_THESIS';



DECLARE @year int = CONVERT(int,RIGHT(@table_name,4));
DECLARE @qry nvarchar(max) = N'
USE '+QUOTENAME(@database_name)+N';
GO

ALTER TABLE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' DROP COLUMN [RPNA_DATE_UTC], [RPNA_TIME_UTC];
ALTER TABLE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' ADD [TIMESTAMP_EST] datetimeoffset(3) NULL;
GO

UPDATE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' SET [TIMESTAMP_EST] = [TIMESTAMP_UTC] AT TIME ZONE ''Eastern Standard Time'';
CHECKPOINT;
GO

ALTER TABLE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' DROP COLUMN [TIMESTAMP_UTC];
ALTER TABLE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' ALTER COLUMN [TIMESTAMP_EST] datetimeoffset(3) NOT NULL; -- Set column to NOT NULL
GO

ALTER TABLE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' WITH CHECK ADD CONSTRAINT [CK_DJ_EQ_'+CONVERT(nvarchar(max),@year)+N'_DATE] CHECK (([TIMESTAMP_EST] >= '''+CONVERT(nvarchar(max),@year)+N'-01-01'' AND [TIMESTAMP_EST] < '''+CONVERT(nvarchar(max),@year+1)+N'-01-01''));
ALTER TABLE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' CHECK CONSTRAINT [CK_DJ_EQ_'+CONVERT(nvarchar(max),@year)+N'_DATE];
GO

ALTER TABLE '+@schema_name+N'.'+QUOTENAME(@table_name)+N' ADD CONSTRAINT [PK_DJ_EQ_'+CONVERT(nvarchar(max),@year)+N'] PRIMARY KEY CLUSTERED ([RP_ENTITY_ID] ASC, [RP_STORY_ID] ASC);
CHECKPOINT;
GO';

RAISERROR(@qry,10,0) WITH NOWAIT;