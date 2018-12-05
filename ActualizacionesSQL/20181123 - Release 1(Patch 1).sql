USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[Insert_DetalleFacturaTratamiento]    Script Date: 11/29/2018 1:54:21 AM ******/
DROP PROCEDURE [dbo].[Insert_DetalleFacturaTratamiento]
GO

/****** Object:  StoredProcedure [dbo].[Insert_DetalleFacturaTratamiento]    Script Date: 11/29/2018 1:54:21 AM ******/
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


