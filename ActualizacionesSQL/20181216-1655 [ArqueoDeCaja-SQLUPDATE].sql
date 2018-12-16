CREATE PROCEDURE GET_MovimientosClientesBeTweenDatesByIdLocal(@IdLocal bigint, @Start varchar(50), @End varchar(50))
as
begin
select * from MovimientoClientes where IdLocal=@IdLocal and Fecha between convert(datetime,@Start,120) and convert(datetime,@End,120)
end
