USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[getLastStockTratamiento]    Script Date: 16/12/2018 16:13:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getLastStockTratamiento]
as
begin
select top 1 * from StockTratamiento order by Id desc
end
GO

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[updateStockTratamientoCantidad]    Script Date: 16/12/2018 16:14:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[updateStockTratamientoCantidad] (@IdUser bigint,@IdArticulo bigint,@CantINT bigint,@CantDEC decimal(18,4))
as
begin
update StockTratamiento
set CanINT = @CantINT, CantDEC = @CantDEC
where IdUser = @IdUser and IdArticulo = @IdArticulo
end

GO

