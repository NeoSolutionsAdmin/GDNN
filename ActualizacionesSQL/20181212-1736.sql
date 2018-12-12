USE [Sistema]
GO

/****** Object:  Table [dbo].[StockAlertaProductos]    Script Date: 12/12/2018 5:36:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StockAlertaProductos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NULL,
	[Stock_Minimo] [decimal](18, 0) NULL,
 CONSTRAINT [PK_StockAlertaProductos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


USE [Sistema]
GO

/****** Object:  Table [dbo].[StockAlertaUsuariosANotificar]    Script Date: 12/12/2018 5:36:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StockAlertaUsuariosANotificar](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Usuario] [int] NOT NULL,
 CONSTRAINT [PK_StockAlertaUsuariosANotificar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

