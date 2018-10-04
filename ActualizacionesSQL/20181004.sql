
use Sistema
go
alter table DetallesFacturas 
add IdTratamiento bigint not null
default 0
go

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[Insert_DetalleFactura]    Script Date: 10/4/2018 2:38:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Insert_DetalleFacturaTratamiento](@IdFactura bigint, @IdTratamiento bigint, @Precio decimal)
as
begin

insert into DetallesFacturas(
IdFactura, 
IdArticulo, 
PrecioNeto, 
IVA, 
PrecioCompra, 
PorcentajeGanancia, 
PrecioFinal, 
CantidadINT, 
CantidadDEC,
IdTratamiento) values(
@IdFactura,
0,
0,
0,
0,
0,
@Precio,
0,
0,
@IdTratamiento)

return 1


end


GO



