USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[insertStockATratamiento]    Script Date: 14/12/2018 2:54:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[insertStockATratamiento] (@IdUser bigint, @IdArticulo bigint, @CantINT bigint, @CantDEC decimal(18,4), @IdTratamiento bigint)
as
begin
insert into StockTratamiento(IdUser,IdArticulo,CanINT,CantDEC,IdTratamiento) values (@IdUser,@IdArticulo,@CantINT,@CantDEC,@IdTratamiento)
end


GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[insertStockTratamientoConsumido]    Script Date: 14/12/2018 2:54:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[insertStockTratamientoConsumido] (@Iduser bigint, @IdArticulo bigint, @IdTratamiento bigint, @FechaConsumido datetime, @IdStockTratamiento bigint)
as
begin
insert into StockTratamientoConsumido (IdUser,IdArticulo,IdTratamiento,FechaConsumido) values (@IdUser,@IdArticulo,@IdTratamiento,@FechaConsumido)
delete from StockTratamiento where Id = @IdStockTratamiento
end


GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[getStockTratamientoByIdTratamiento]    Script Date: 14/12/2018 2:54:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getStockTratamientoByIdTratamiento] (@IdUser bigint,@IdTratamiento bigint)
as
begin
select * from StockTratamiento where IdTratamiento = @IdTratamiento and IdUser=@IdUser
end
GO

USE [Sistema]
GO

/****** Object:  Table [dbo].[StockTratamiento]    Script Date: 14/12/2018 2:55:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StockTratamiento](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdArticulo] [bigint] NOT NULL,
	[CanINT] [bigint] NOT NULL,
	[CantDEC] [decimal](18, 4) NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
 CONSTRAINT [PK_StockAgregado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

USE [Sistema]
GO

/****** Object:  Table [dbo].[StockTratamientoConsumido]    Script Date: 14/12/2018 2:56:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StockTratamientoConsumido](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdArticulo] [bigint] NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
	[FechaConsumido] [datetime] NOT NULL,
 CONSTRAINT [PK_StockTratamientoConsumido] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

