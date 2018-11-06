create procedure searchLocales (@stringBusqueda varchar(50))
as
begin
select * from Sucursales where NombreLocal like '%' + @stringBusqueda + '%'
end
