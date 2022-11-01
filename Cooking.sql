USE [master]
GO
/****** Object:  Database [Cooking]    Script Date: 2019-09-24 9:15:09 PM ******/
CREATE DATABASE [Cooking] 
GO
ALTER DATABASE [Cooking] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cooking].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cooking] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cooking] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cooking] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cooking] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cooking] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cooking] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Cooking] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cooking] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cooking] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cooking] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cooking] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cooking] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cooking] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cooking] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cooking] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Cooking] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cooking] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cooking] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cooking] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cooking] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cooking] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cooking] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cooking] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Cooking] SET  MULTI_USER 
GO
ALTER DATABASE [Cooking] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cooking] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cooking] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cooking] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Cooking] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Cooking]
GO
/****** Object:  Table [dbo].[category]    Script Date: 2019-09-24 9:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[categoryCode] [varchar](10) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[measureCode] [varchar](10) NULL,
 CONSTRAINT [PK_measurementType] PRIMARY KEY CLUSTERED 
(
	[categoryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[measure]    Script Date: 2019-09-24 9:15:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[measure](
	[measureCode] [varchar](10) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[categoryCode] [varchar](10) NOT NULL,
	[ratioToBase] [float] NOT NULL
) ON [PRIMARY]
GO
INSERT [dbo].[category] ([categoryCode], [name], [measureCode]) VALUES (N'E', N'Energy', NULL)
INSERT [dbo].[category] ([categoryCode], [name], [measureCode]) VALUES (N'L', N'length', N'm')
INSERT [dbo].[category] ([categoryCode], [name], [measureCode]) VALUES (N'V', N'volume', N'l')
INSERT [dbo].[category] ([categoryCode], [name], [measureCode]) VALUES (N'W', N'weight', N'g')
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'cm', N'centimetre', N'L', 0.01)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'g', N'grams', N'W', 1)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'kg', N'kilograms', N'W', 1000)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'km', N'kilometres', N'L', 1000)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'l', N'litres', N'V', 1)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'lb', N'pounds', N'W', 453.592)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'm', N'metre', N'L', 1)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'mg', N'milligrams', N'W', 0.001)
INSERT [dbo].[measure] ([measureCode], [name], [categoryCode], [ratioToBase]) VALUES (N'ml', N'millilitre', N'V', 0.001)
SET ANSI_PADDING ON
GO
/****** Object:  Index [aaaaameasure_PK]    Script Date: 2019-09-24 9:15:09 PM ******/
ALTER TABLE [dbo].[measure] ADD  CONSTRAINT [aaaaameasure_PK] PRIMARY KEY NONCLUSTERED 
(
	[measureCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [measureCode]    Script Date: 2019-09-24 9:15:09 PM ******/
CREATE NONCLUSTERED INDEX [measureCode] ON [dbo].[measure]
(
	[measureCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [typemeasure]    Script Date: 2019-09-24 9:15:09 PM ******/
CREATE NONCLUSTERED INDEX [typemeasure] ON [dbo].[measure]
(
	[categoryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[category]  WITH CHECK ADD  CONSTRAINT [FK_category_measure] FOREIGN KEY([measureCode])
REFERENCES [dbo].[measure] ([measureCode])
GO
ALTER TABLE [dbo].[category] CHECK CONSTRAINT [FK_category_measure]
GO
--ALTER TABLE [dbo].[measure]  WITH CHECK ADD  CONSTRAINT [FK_measure_category1] FOREIGN KEY([categoryCode])
--REFERENCES [dbo].[category] ([categoryCode])
--GO
--ALTER TABLE [dbo].[measure] CHECK CONSTRAINT [FK_measure_category1]
--GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'measureCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'measureCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'measure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'measureCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'20' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'name' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'measure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMEMode', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_IMESentMode', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'typeCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'typeCode' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'measure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'UnicodeCompression', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'categoryCode'
GO
EXEC sys.sp_addextendedproperty @name=N'AggregateType', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'AllowZeroLength', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'AppendOnly', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'CollatingOrder', @value=N'1033' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnHidden', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnOrder', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'ColumnWidth', @value=N'-1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'DataUpdatable', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DecimalPlaces', @value=N'255' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DisplayControl', @value=N'109' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'ratioToBase' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'OrdinalPosition', @value=N'3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'Required', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'Size', @value=N'8' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceField', @value=N'ratioToBase' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'SourceTable', @value=N'measure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'TextAlign', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'Type', @value=N'7' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure', @level2type=N'COLUMN',@level2name=N'ratioToBase'
GO
EXEC sys.sp_addextendedproperty @name=N'Attributes', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'DateCreated', @value=N'14/12/2005 5:39:44 PM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'DisplayViewsOnSharePointSite', @value=N'1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'FilterOnLoad', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'HideNewField', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'LastUpdated', @value=N'05/12/2007 11:01:21 AM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DefaultView', @value=N'2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_OrderByOn', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Orientation', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'Name', @value=N'measure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'OrderByOnLoad', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'RecordCount', @value=N'10' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'TotalsRow', @value=N'False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
EXEC sys.sp_addextendedproperty @name=N'Updatable', @value=N'True' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'measure'
GO
USE [master]
GO
ALTER DATABASE [Cooking] SET  READ_WRITE 
GO
