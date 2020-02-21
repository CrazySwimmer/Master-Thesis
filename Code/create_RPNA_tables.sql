/*
	Create the main RPNA tables.
	Specifiy the database that you want to use and execute.
	The tables will be created only if they do not already exist.

	Danilo Zocco
	2020-02-20
*/
USE [MASTER_THESIS]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'dbo.RPNA_DJ_EQ',N'U') IS NULL
BEGIN
	CREATE TABLE dbo.RPNA_DJ_EQ (
		[TIMESTAMP_EST] [datetime2](3) NOT NULL,
		[RP_ENTITY_ID] [char](6) NOT NULL,
		[ENTITY_TYPE] [char](4) NOT NULL,
		[ENTITY_NAME] [nvarchar](400) NULL,
		[POSITION_NAME] [nvarchar](400) NULL,
		[RP_POSITION_ID] [char](6) NULL,
		[COUNTRY_CODE] [char](2) NULL,
		[RELEVANCE] [tinyint] NOT NULL,
		[TOPIC] [varchar](50) NULL,
		[GROUP] [varchar](50) NULL,
		[TYPE] [varchar](50) NULL,
		[SUB_TYPE] [varchar](50) NULL,
		[PROPERTY] [varchar](50) NULL,
		[EVALUATION_METHOD] [char](3) NULL,
		[MATURITY] [varchar](5) NULL,
		[CATEGORY] [varchar](100) NULL,
		[ESS] [tinyint] NULL,
		[AES] [tinyint] NOT NULL,
		[AEV] [smallint] NOT NULL,
		[ENS] [tinyint] NULL,
		[ENS_SIMILARITY_GAP] [decimal](18, 10) NULL,
		[ENS_KEY] [varchar](32) NULL,
		[ENS_ELAPSED] [bigint] NULL,
		[G_ENS] [tinyint] NULL,
		[G_ENS_SIMILARITY_GAP] [decimal](18, 10) NULL,
		[G_ENS_KEY] [varchar](32) NULL,
		[G_ENS_ELAPSED] [bigint] NULL,
		[EVENT_SIMILARITY_KEY] [varchar](32) NULL,
		[NEWS_TYPE] [varchar](20) NULL,
		[SOURCE] [char](6) NOT NULL,
		[RP_STORY_ID] [varchar](32) NOT NULL,
		[RP_STORY_EVENT_INDEX] [smallint] NOT NULL,
		[RP_STORY_EVENT_COUNT] [smallint] NOT NULL,
		[PRODUCT_KEY] [char](5) NOT NULL,
		[COMPANY] [nvarchar](50) NULL,
		[ISIN] [char](12) NULL,
		[CSS] [tinyint] NOT NULL,
		[NIP] [tinyint] NOT NULL,
		[PEQ] [tinyint] NOT NULL,
		[BEE] [tinyint] NOT NULL,
		[BMQ] [tinyint] NOT NULL,
		[BAM] [tinyint] NOT NULL,
		[BCA] [tinyint] NOT NULL,
		[BER] [tinyint] NOT NULL,
		[ANL_CHG] [tinyint] NOT NULL,
		[MCQ] [tinyint] NOT NULL
	);

	DECLARE @msg nvarchar(max) = N'The table dbo.RPNA_DJ_EQ was created successfully in the database '+DB_NAME();
	RAISERROR(@msg,10,0) WITH NOWAIT
END
GO


IF OBJECT_ID(N'dbo.RPNA_DJ_GM',N'U') IS NULL
BEGIN
	CREATE TABLE dbo.RPNA_DJ_GM (
		[TIMESTAMP_EST] [datetime2](3) NOT NULL,
		[RP_ENTITY_ID] [char](6) NOT NULL,
		[ENTITY_TYPE] [char](4) NOT NULL,
		[ENTITY_NAME] [nvarchar](400) NULL,
		[POSITION_NAME] [nvarchar](400) NULL,
		[RP_POSITION_ID] [char](6) NULL,
		[COUNTRY_CODE] [char](2) NULL,
		[RELEVANCE] [tinyint] NOT NULL,
		[TOPIC] [varchar](50) NULL,
		[GROUP] [varchar](50) NULL,
		[TYPE] [varchar](50) NULL,
		[SUB_TYPE] [varchar](50) NULL,
		[PROPERTY] [varchar](50) NULL,
		[EVALUATION_METHOD] [char](3) NULL,
		[MATURITY] [varchar](8) NULL,
		[CATEGORY] [varchar](100) NULL,
		[ESS] [tinyint] NULL,
		[AES] [tinyint] NOT NULL,
		[AEV] [smallint] NOT NULL,
		[ENS] [tinyint] NULL,
		[ENS_SIMILARITY_GAP] [decimal](18, 10) NULL,
		[ENS_KEY] [varchar](32) NULL,
		[ENS_ELAPSED] [int] NULL,
		[G_ENS] [tinyint] NULL,
		[G_ENS_SIMILARITY_GAP] [decimal](18, 10) NULL,
		[G_ENS_KEY] [varchar](32) NULL,
		[G_ENS_ELAPSED] [bigint] NULL,
		[EVENT_SIMILARITY_KEY] [varchar](32) NULL,
		[NEWS_TYPE] [varchar](20) NULL,
		[SOURCE] [char](6) NOT NULL,
		[RP_STORY_ID] [varchar](32) NOT NULL,
		[RP_STORY_EVENT_INDEX] [smallint] NOT NULL,
		[RP_STORY_EVENT_COUNT] [smallint] NOT NULL,
		[PRODUCT_KEY] [char](5) NOT NULL
)	;

	DECLARE @msg nvarchar(max) = N'The table dbo.RPNA_DJ_GM was created successfully in the database '+DB_NAME();
	RAISERROR(@msg,10,0) WITH NOWAIT
END
GO
