USE [Sistema]
GO

/****** Object:  Table [dbo].[AgendaTurnos]    Script Date: 06/12/2018 2:00:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AgendaTurnos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DateReservacion] [datetime] NOT NULL,
	[IdCliente] [bigint] NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_AgendaTurnos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


