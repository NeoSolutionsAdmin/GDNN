USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[insertStockTratamientoConsumido]    Script Date: 17/12/2018 17:09:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[insertStockTratamientoConsumido] (@IdUser bigint, @IdArticulo bigint,@CantINT bigint,@CantDEC decimal(18,4), @IdTratamiento bigint, @FechaConsumido varchar(50))
as
begin
insert into StockTratamientoConsumido (IdUser,IdArticulo,CantINT,CantDEC,IdTratamiento,FechaConsumido) values (@IdUser,@IdArticulo,@CantINT,@CantDEC,@IdTratamiento,convert (datetime, @FechaConsumido, 120))
end

