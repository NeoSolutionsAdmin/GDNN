USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Select_Movimientos_Usuarios]    Script Date: 06/07/2019 17:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [dbo].[Select_Movimientos_Usuarios]

	@FechaStart varchar(50),
	@FechaEnd varchar(50),
	@IdLocal bigint,
	@TipoMove varchar(1)

as
begin
	
	select * from MovimientoClientes where Fecha between convert(datetime,@FechaStart,120) and convert(datetime,@FechaEnd,120) and @IdLocal = 1 and TipoMovimiento = @TipoMove

end