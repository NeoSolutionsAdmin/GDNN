use Sistema
go

create proc Select_MovimientosTarjetas

	@idCliente bigint

as
begin

	select * from MovimientoClientes where IdCliente = @idCliente and TipoMovimiento = 'T'

end