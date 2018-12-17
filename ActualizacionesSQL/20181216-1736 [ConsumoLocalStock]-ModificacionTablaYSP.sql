USE [Sistema]
GO

/****** Object:  Table [dbo].[StockTratamientoConsumido]    Script Date: 16/12/2018 21:17:19 ******/
DROP TABLE [dbo].[StockTratamientoConsumido]
GO

/****** Object:  Table [dbo].[StockTratamientoConsumido]    Script Date: 16/12/2018 21:17:19 ******/
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
	[FechaConsumido] [datetime] NOT NULL,
 CONSTRAINT [PK_StockTratamientoConsumido] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[deleteFromStockTratamientoByIdStockTratameinto]    Script Date: 16/12/2018 21:17:32 ******/
DROP PROCEDURE [dbo].[deleteFromStockTratamientoByIdStockTratameinto]
GO

/****** Object:  StoredProcedure [dbo].[deleteFromStockTratamientoByIdStockTratameinto]    Script Date: 16/12/2018 21:17:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[deleteFromStockTratamientoByIdStockTratameinto] (@IdStockTratamiento bigint)
as
begin
delete from StockTratamiento where Id = @IdStockTratamiento
end
GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[getSpecificStockTratamiento]    Script Date: 16/12/2018 21:17:47 ******/
DROP PROCEDURE [dbo].[getSpecificStockTratamiento]
GO

/****** Object:  StoredProcedure [dbo].[getSpecificStockTratamiento]    Script Date: 16/12/2018 21:17:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getSpecificStockTratamiento] (@IdUser bigint, @IdArticulo bigint, @IdTratamiento bigint)
as
begin
select * from StockTratamiento where IdUser=@IdUser and IdArticulo=@IdArticulo and IDTratamiento=@IdTratamiento
end
GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[getStockTratamientoByIdTratamiento]    Script Date: 16/12/2018 21:17:55 ******/
DROP PROCEDURE [dbo].[getStockTratamientoByIdTratamiento]
GO

/****** Object:  StoredProcedure [dbo].[getStockTratamientoByIdTratamiento]    Script Date: 16/12/2018 21:17:55 ******/
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

/****** Object:  StoredProcedure [dbo].[insertStockATratamiento]    Script Date: 16/12/2018 21:18:12 ******/
DROP PROCEDURE [dbo].[insertStockATratamiento]
GO

/****** Object:  StoredProcedure [dbo].[insertStockATratamiento]    Script Date: 16/12/2018 21:18:12 ******/
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

/****** Object:  StoredProcedure [dbo].[insertStockTratamientoConsumido]    Script Date: 16/12/2018 21:18:17 ******/
DROP PROCEDURE [dbo].[insertStockTratamientoConsumido]
GO

/****** Object:  StoredProcedure [dbo].[insertStockTratamientoConsumido]    Script Date: 16/12/2018 21:18:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[insertStockTratamientoConsumido] (@IdUser bigint, @IdArticulo bigint,@CantINT bigint,@CantDEC decimal(18,4), @IdTratamiento bigint, @FechaConsumido datetime)
as
begin
insert into StockTratamientoConsumido (IdUser,IdArticulo,CantINT,CantDEC,IdTratamiento,FechaConsumido) values (@IdUser,@IdArticulo,@CantINT,@CantDEC,@IdTratamiento,@FechaConsumido)
end


GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[updateStockTratamientoCantidad]    Script Date: 16/12/2018 21:18:31 ******/
DROP PROCEDURE [dbo].[updateStockTratamientoCantidad]
GO

/****** Object:  StoredProcedure [dbo].[updateStockTratamientoCantidad]    Script Date: 16/12/2018 21:18:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[updateStockTratamientoCantidad] (@IdUser bigint,@IdArticulo bigint,@IdTratamiento bigint,@CantINT bigint,@CantDEC decimal(18,4))
as
begin
update StockTratamiento
set CanINT = @CantINT, CantDEC = @CantDEC
where IdUser = @IdUser and IdArticulo = @IdArticulo and IdTratamiento=@IdTratamiento
end

GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[updateStockTratamientoConsumido]    Script Date: 16/12/2018 21:18:36 ******/
DROP PROCEDURE [dbo].[updateStockTratamientoConsumido]
GO

/****** Object:  StoredProcedure [dbo].[updateStockTratamientoConsumido]    Script Date: 16/12/2018 21:18:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[updateStockTratamientoConsumido] (@IdUser bigint,@IdArticulo bigint,@CantINT bigint,@CantDEC decimal(18,4))
as
begin
update StockTratamientoConsumido set CantINT=@CantINT, CantDEC=@CantDEC
where IdUser = @IdUser and IdArticulo = @IdArticulo
end
GO

