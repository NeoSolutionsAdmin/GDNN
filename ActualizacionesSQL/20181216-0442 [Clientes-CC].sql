USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Insert_MovimientoCliente]    Script Date: 12/16/2018 4:41:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Insert_MovimientoCliente](
@IdCliente bigint,
@TipoMovimiento varchar(3),
@Importe decimal(18,4),
@IdFactura bigint,
@Date varchar(100),
@IdSucursal bigint)
as
begin
insert into MovimientoClientes(
IdCliente,
TipoMovimiento,
Importe,
IdFactura,
Fecha,
IdLocal
) values(@IdCliente,@TipoMovimiento,@Importe,@IdFactura,convert(datetime,@Date,120),@IdSucursal)
end

