USE [master]
GO
/****** Object:  Database [library]    Script Date: 28/8/2023 23:34:29 ******/
CREATE DATABASE [library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [library] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [library] SET ARITHABORT OFF 
GO
ALTER DATABASE [library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [library] SET  ENABLE_BROKER 
GO
ALTER DATABASE [library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [library] SET RECOVERY FULL 
GO
ALTER DATABASE [library] SET  MULTI_USER 
GO
ALTER DATABASE [library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'library', N'ON'
GO
ALTER DATABASE [library] SET QUERY_STORE = ON
GO
ALTER DATABASE [library] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [library]
GO
/****** Object:  User [NelsonAlmendares]    Script Date: 28/8/2023 23:34:29 ******/
CREATE USER [NelsonAlmendares] FOR LOGIN [NelsonAlmendares] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[statusClient]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[statusClient](
	[id_status] [int] IDENTITY(1,1) NOT NULL,
	[status__client] [varchar](50) NOT NULL,
 CONSTRAINT [PK_statusClient] PRIMARY KEY CLUSTERED 
(
	[id_status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[client]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[client](
	[id_client] [int] IDENTITY(1,1) NOT NULL,
	[client_firstName] [varchar](100) NOT NULL,
	[client_lastName] [varchar](100) NOT NULL,
	[password_client] [varchar](200) NOT NULL,
	[client_phone] [varchar](12) NOT NULL,
	[client_document] [varchar](11) NOT NULL,
	[client_address] [text] NOT NULL,
	[client_mail] [varchar](200) NOT NULL,
	[client_photo] [image] NULL,
	[id_statusClient] [int] NULL,
 CONSTRAINT [PK_client] PRIMARY KEY CLUSTERED 
(
	[id_client] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[Clientes]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Clientes] 
	AS SELECT client_firstName AS Nombre, client_lastName AS Apellido, client_phone AS Teléfono, 
		client_document AS Documento, client_address AS Dirección, client_mail AS Correo, 
		client_photo AS Foto, status__client AS Estado
	FROM [dbo].[client]
	INNER JOIN [dbo].[statusClient] ON [client].id_statusClient = [statusClient].id_status;
GO
/****** Object:  Table [dbo].[availability]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[availability](
	[id_availability] [int] IDENTITY(1,1) NOT NULL,
	[book__availability] [varchar](100) NOT NULL,
 CONSTRAINT [PK_availability] PRIMARY KEY CLUSTERED 
(
	[id_availability] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bills]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bills](
	[id_bill] [int] IDENTITY(1,1) NOT NULL,
	[sale__correlative] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[date__issue] [date] NOT NULL,
	[comments] [varchar](200) NULL,
	[id_sale] [int] NOT NULL,
	[id_client] [int] NOT NULL,
 CONSTRAINT [PK_bill] PRIMARY KEY CLUSTERED 
(
	[id_bill] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[brand]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[id_brand] [int] IDENTITY(1,1) NOT NULL,
	[product__brand] [varchar](100) NOT NULL,
 CONSTRAINT [PK_brand] PRIMARY KEY CLUSTERED 
(
	[id_brand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clasification]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clasification](
	[id_clasification] [int] IDENTITY(1,1) NOT NULL,
	[clasification__product] [varchar](100) NOT NULL,
 CONSTRAINT [PK_clasification] PRIMARY KEY CLUSTERED 
(
	[id_clasification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[distributor]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[distributor](
	[id_distributor] [int] IDENTITY(1,1) NOT NULL,
	[name_distributor] [varchar](200) NOT NULL,
	[comments] [text] NULL,
	[register] [date] NULL,
 CONSTRAINT [PK_distributot] PRIMARY KEY CLUSTERED 
(
	[id_distributor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[id_employee] [int] IDENTITY(1,1) NOT NULL,
	[employee_firstName] [varchar](100) NOT NULL,
	[employee_lastName] [varchar](100) NOT NULL,
	[password_employee] [varchar](200) NOT NULL,
	[employee_address] [text] NOT NULL,
	[employee_phone] [int] NOT NULL,
	[employee_document] [int] NOT NULL,
	[employee_mail] [varchar](260) NOT NULL,
	[employee_photo] [image] NULL,
	[id_typeEmployee] [int] NOT NULL,
	[id_statusEmployee] [int] NOT NULL,
 CONSTRAINT [PK_employee] PRIMARY KEY CLUSTERED 
(
	[id_employee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gender]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gender](
	[id_gender] [int] IDENTITY(1,1) NOT NULL,
	[book__gender] [varchar](100) NOT NULL,
 CONSTRAINT [PK_gender] PRIMARY KEY CLUSTERED 
(
	[id_gender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment](
	[id_typePayment] [int] IDENTITY(1,1) NOT NULL,
	[type__payment] [varchar](100) NOT NULL,
 CONSTRAINT [PK_payment] PRIMARY KEY CLUSTERED 
(
	[id_typePayment] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id_product] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [varchar](100) NOT NULL,
	[product_price] [float] NOT NULL,
	[product_photo] [image] NULL,
	[product_description] [text] NOT NULL,
	[date_entry] [date] NULL,
	[product_brand] [int] NOT NULL,
	[id_productStatus] [int] NOT NULL,
	[id_productDistributor] [int] NOT NULL,
	[id_review] [int] NOT NULL,
	[id_availability] [int] NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[id_product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productSpecification]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productSpecification](
	[id_productEspecification] [int] IDENTITY(1,1) NOT NULL,
	[product__quantity] [int] NOT NULL,
	[product__author] [varchar](200) NOT NULL,
	[product__format] [varchar](100) NOT NULL,
	[product__themes] [varchar](100) NOT NULL,
	[id_productGender] [int] NOT NULL,
	[id_clasification] [int] NOT NULL,
	[id_product] [int] NOT NULL,
 CONSTRAINT [PK_productSpecification] PRIMARY KEY CLUSTERED 
(
	[id_productEspecification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productStatus]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productStatus](
	[id_productStatus] [int] IDENTITY(1,1) NOT NULL,
	[product__status] [varchar](90) NOT NULL,
 CONSTRAINT [PK_statusProduct] PRIMARY KEY CLUSTERED 
(
	[id_productStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reviews]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reviews](
	[id_review] [int] IDENTITY(1,1) NOT NULL,
	[name_client] [varchar](100) NULL,
	[register_date] [date] NULL,
 CONSTRAINT [PK_review] PRIMARY KEY CLUSTERED 
(
	[id_review] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales](
	[id_sales] [int] IDENTITY(1,1) NOT NULL,
	[sale_date] [date] NOT NULL,
	[sale_address] [text] NOT NULL,
	[sale_total_due] [float] NOT NULL,
	[sale_type_payment] [int] NOT NULL,
	[id_sale_purchaser] [int] NOT NULL,
	[id_product] [int] NOT NULL,
	[id_employee] [int] NOT NULL,
 CONSTRAINT [PK_sales] PRIMARY KEY CLUSTERED 
(
	[id_sales] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salesReturn]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[salesReturn](
	[id_salesReturn] [int] IDENTITY(1,1) NOT NULL,
	[date_returned] [date] NULL,
	[return_comments] [varchar](300) NOT NULL,
	[id_sale] [int] NOT NULL,
 CONSTRAINT [PK_salesReturn] PRIMARY KEY CLUSTERED 
(
	[id_salesReturn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[statusEmployee]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[statusEmployee](
	[id_statusEmployee] [int] IDENTITY(1,1) NOT NULL,
	[status__employee] [varchar](90) NOT NULL,
 CONSTRAINT [PK_statusEmployee] PRIMARY KEY CLUSTERED 
(
	[id_statusEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[typeEmployee]    Script Date: 28/8/2023 23:34:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[typeEmployee](
	[id_typeEmployee] [int] IDENTITY(1,1) NOT NULL,
	[type__employee] [varchar](100) NOT NULL,
 CONSTRAINT [PK_typeEmployee] PRIMARY KEY CLUSTERED 
(
	[id_typeEmployee] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[availability] ON 
GO
INSERT [dbo].[availability] ([id_availability], [book__availability]) VALUES (1, N'Inmediata')
GO
INSERT [dbo].[availability] ([id_availability], [book__availability]) VALUES (2, N'Agotado')
GO
INSERT [dbo].[availability] ([id_availability], [book__availability]) VALUES (3, N'Pocas existencias')
GO
INSERT [dbo].[availability] ([id_availability], [book__availability]) VALUES (4, N'Ingresos')
GO
SET IDENTITY_INSERT [dbo].[availability] OFF
GO
SET IDENTITY_INSERT [dbo].[brand] ON 
GO
INSERT [dbo].[brand] ([id_brand], [product__brand]) VALUES (1, N'Ibérica')
GO
SET IDENTITY_INSERT [dbo].[brand] OFF
GO
SET IDENTITY_INSERT [dbo].[client] ON 
GO
INSERT [dbo].[client] ([id_client], [client_firstName], [client_lastName], [password_client], [client_phone], [client_document], [client_address], [client_mail], [client_photo], [id_statusClient]) VALUES (3, N'Nelson', N'Almendares', N'123456', N'7823-2312', N'09821309-8', N'Por la casita', N'nelsonjose@gmail.com', 0x, 1)
GO
SET IDENTITY_INSERT [dbo].[client] OFF
GO
SET IDENTITY_INSERT [dbo].[payment] ON 
GO
INSERT [dbo].[payment] ([id_typePayment], [type__payment]) VALUES (1, N'Tarjeta de crédito')
GO
INSERT [dbo].[payment] ([id_typePayment], [type__payment]) VALUES (2, N'Tarjeta de débito')
GO
INSERT [dbo].[payment] ([id_typePayment], [type__payment]) VALUES (3, N'Efectivo')
GO
SET IDENTITY_INSERT [dbo].[payment] OFF
GO
SET IDENTITY_INSERT [dbo].[productStatus] ON 
GO
INSERT [dbo].[productStatus] ([id_productStatus], [product__status]) VALUES (1, N'En Existencias')
GO
SET IDENTITY_INSERT [dbo].[productStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[statusClient] ON 
GO
INSERT [dbo].[statusClient] ([id_status], [status__client]) VALUES (1, N'Activo')
GO
INSERT [dbo].[statusClient] ([id_status], [status__client]) VALUES (2, N'Ináctivo')
GO
SET IDENTITY_INSERT [dbo].[statusClient] OFF
GO
SET IDENTITY_INSERT [dbo].[statusEmployee] ON 
GO
INSERT [dbo].[statusEmployee] ([id_statusEmployee], [status__employee]) VALUES (1, N'Activo')
GO
INSERT [dbo].[statusEmployee] ([id_statusEmployee], [status__employee]) VALUES (2, N'Ináctivo')
GO
INSERT [dbo].[statusEmployee] ([id_statusEmployee], [status__employee]) VALUES (3, N'Pasante')
GO
SET IDENTITY_INSERT [dbo].[statusEmployee] OFF
GO
SET IDENTITY_INSERT [dbo].[typeEmployee] ON 
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (1, N'Administrador')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (2, N'Gerente')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (3, N'Vendedor')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (4, N'Caja')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (5, N'Bodega')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (6, N'Repartidor')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (7, N'Ordenanza')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (8, N'Seguridad')
GO
INSERT [dbo].[typeEmployee] ([id_typeEmployee], [type__employee]) VALUES (9, N'Administración')
GO
SET IDENTITY_INSERT [dbo].[typeEmployee] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [uq_mail]    Script Date: 28/8/2023 23:34:30 ******/
ALTER TABLE [dbo].[client] ADD  CONSTRAINT [uq_mail] UNIQUE NONCLUSTERED 
(
	[client_mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_mail]    Script Date: 28/8/2023 23:34:30 ******/
ALTER TABLE [dbo].[employee] ADD  CONSTRAINT [UK_mail] UNIQUE NONCLUSTERED 
(
	[employee_mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bills] ADD  DEFAULT ('') FOR [comments]
GO
ALTER TABLE [dbo].[client] ADD  DEFAULT ((1)) FOR [id_statusClient]
GO
ALTER TABLE [dbo].[distributor] ADD  DEFAULT ('Sin comentarios') FOR [comments]
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FK_client] FOREIGN KEY([id_client])
REFERENCES [dbo].[client] ([id_client])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FK_client]
GO
ALTER TABLE [dbo].[bills]  WITH CHECK ADD  CONSTRAINT [FK_sales] FOREIGN KEY([id_sale])
REFERENCES [dbo].[sales] ([id_sales])
GO
ALTER TABLE [dbo].[bills] CHECK CONSTRAINT [FK_sales]
GO
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [FK_status] FOREIGN KEY([id_statusClient])
REFERENCES [dbo].[statusClient] ([id_status])
GO
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [FK_status]
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [FK_statusEmployee] FOREIGN KEY([id_statusEmployee])
REFERENCES [dbo].[statusEmployee] ([id_statusEmployee])
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [FK_statusEmployee]
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [FK_typeEmployee] FOREIGN KEY([id_typeEmployee])
REFERENCES [dbo].[typeEmployee] ([id_typeEmployee])
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [FK_typeEmployee]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_availability] FOREIGN KEY([id_availability])
REFERENCES [dbo].[availability] ([id_availability])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_availability]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_brands] FOREIGN KEY([product_brand])
REFERENCES [dbo].[brand] ([id_brand])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_brands]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_distributor] FOREIGN KEY([id_productDistributor])
REFERENCES [dbo].[distributor] ([id_distributor])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_distributor]
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD  CONSTRAINT [FK_productStatus] FOREIGN KEY([id_productStatus])
REFERENCES [dbo].[productStatus] ([id_productStatus])
GO
ALTER TABLE [dbo].[products] CHECK CONSTRAINT [FK_productStatus]
GO
ALTER TABLE [dbo].[productSpecification]  WITH CHECK ADD  CONSTRAINT [FK_clasification] FOREIGN KEY([id_clasification])
REFERENCES [dbo].[clasification] ([id_clasification])
GO
ALTER TABLE [dbo].[productSpecification] CHECK CONSTRAINT [FK_clasification]
GO
ALTER TABLE [dbo].[productSpecification]  WITH CHECK ADD  CONSTRAINT [FK_gender] FOREIGN KEY([id_productGender])
REFERENCES [dbo].[gender] ([id_gender])
GO
ALTER TABLE [dbo].[productSpecification] CHECK CONSTRAINT [FK_gender]
GO
ALTER TABLE [dbo].[productSpecification]  WITH CHECK ADD  CONSTRAINT [FK_productSpecification] FOREIGN KEY([id_product])
REFERENCES [dbo].[products] ([id_product])
GO
ALTER TABLE [dbo].[productSpecification] CHECK CONSTRAINT [FK_productSpecification]
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [FK_clients] FOREIGN KEY([id_sale_purchaser])
REFERENCES [dbo].[client] ([id_client])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [FK_clients]
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [FK_employees] FOREIGN KEY([id_employee])
REFERENCES [dbo].[employee] ([id_employee])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [FK_employees]
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [FK_payment] FOREIGN KEY([sale_type_payment])
REFERENCES [dbo].[payment] ([id_typePayment])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [FK_payment]
GO
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [FK_product] FOREIGN KEY([id_product])
REFERENCES [dbo].[products] ([id_product])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [FK_product]
GO
ALTER TABLE [dbo].[salesReturn]  WITH CHECK ADD  CONSTRAINT [FK_salesReturn] FOREIGN KEY([id_sale])
REFERENCES [dbo].[sales] ([id_sales])
GO
ALTER TABLE [dbo].[salesReturn] CHECK CONSTRAINT [FK_salesReturn]
GO
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [ck_document] CHECK  (([client_document] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'))
GO
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [ck_document]
GO
ALTER TABLE [dbo].[client]  WITH CHECK ADD  CONSTRAINT [ck_phone] CHECK  (([client_phone] like '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[client] CHECK CONSTRAINT [ck_phone]
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [CK_documentEmplyee] CHECK  (([employee_document] like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'))
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [CK_documentEmplyee]
GO
ALTER TABLE [dbo].[employee]  WITH CHECK ADD  CONSTRAINT [CK_phoneEmployee] CHECK  (([employee_phone] like '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[employee] CHECK CONSTRAINT [CK_phoneEmployee]
GO
USE [master]
GO
ALTER DATABASE [library] SET  READ_WRITE 
GO
