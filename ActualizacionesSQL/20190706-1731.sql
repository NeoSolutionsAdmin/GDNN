
create proc Select_Movimientos_Usuarios

	@FechaStart varchar(50),
	@FechaEnd varchar(50),
	@IdLocal bigint,
	@TipoMove varchar(1)

as
begin
	
	select * from MovimientoClientes where Fecha between @FechaStart and @FechaEnd and @IdLocal = 1 and TipoMovimiento = @TipoMove

end