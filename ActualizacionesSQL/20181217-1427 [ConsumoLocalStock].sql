USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[updateStockTratamientoCantidad]    Script Date: 17/12/2018 14:27:02 ******/
DROP PROCEDURE [dbo].[updateStockTratamientoCantidad]
GO

/****** Object:  StoredProcedure [dbo].[updateStockTratamientoCantidad]    Script Date: 17/12/2018 14:27:02 ******/
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


