USE [Sistema]
GO

/****** Object:  Table [dbo].[StockTratamientoConsumido]    Script Date: 17/12/2018 18:06:44 ******/
DROP TABLE [dbo].[StockTratamientoConsumido]
GO

/****** Object:  Table [dbo].[StockTratamientoConsumido]    Script Date: 17/12/2018 18:06:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StockTratamientoConsumido](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdArticulo] [bigint] NOT NULL,
	[CantINT] [bigint] NOT NULL,
	[CantDEC] [decimal](18, 4) NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
	[FechaConsumido] [date] NOT NULL,
 CONSTRAINT [PK_StockTratamientoConsumido] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[getStockConsumidoByDates]    Script Date: 17/12/2018 18:08:01 ******/
DROP PROCEDURE [dbo].[getStockConsumidoByDates]
GO

/****** Object:  StoredProcedure [dbo].[getStockConsumidoByDates]    Script Date: 17/12/2018 18:08:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getStockConsumidoByDates] (@IdUser bigint,@Fecha1 varchar(50), @Fecha2 varchar(50))
as
begin
select * from StockTratamientoConsumido where IdUser=@IdUser and FechaConsumido between convert (date, @Fecha1, 120) and convert (date, @Fecha2, 120)
end

GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[insertStockTratamientoConsumido]    Script Date: 17/12/2018 18:09:20 ******/
DROP PROCEDURE [dbo].[insertStockTratamientoConsumido]
GO

/****** Object:  StoredProcedure [dbo].[insertStockTratamientoConsumido]    Script Date: 17/12/2018 18:09:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[insertStockTratamientoConsumido] (@IdUser bigint, @IdArticulo bigint,@CantINT bigint,@CantDEC decimal(18,4), @IdTratamiento bigint, @FechaConsumido varchar(50))
as
begin
insert into StockTratamientoConsumido (IdUser,IdArticulo,CantINT,CantDEC,IdTratamiento,FechaConsumido) values (@IdUser,@IdArticulo,@CantINT,@CantDEC,@IdTratamiento,convert (date, @FechaConsumido, 120))
end


GO

