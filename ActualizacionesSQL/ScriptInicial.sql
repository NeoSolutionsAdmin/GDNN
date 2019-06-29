USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[AgregarProductoConAlertaDeStock]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[AgregarProductoConAlertaDeStock] 
	-- Add the parameters for the stored procedure here
	@Id_Producto int = 0, 
	@Stock_Minimo decimal = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO StockAlertaProductos(Id_Producto,Stock_Minimo)
	VALUES (@Id_Producto,@Stock_Minimo);
	

END


GO
/****** Object:  StoredProcedure [dbo].[AgregarUserParaAlertar]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AgregarUserParaAlertar] 
	-- Add the parameters for the stored procedure here
	@Id_Usuario int
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO StockAlertaUsuariosANotificar (Id_Usuario)
	VALUES (@Id_Usuario)

END

GO
/****** Object:  StoredProcedure [dbo].[Allow_Treatment]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Allow_Treatment] (@Fila bigint)
as
begin
update Treatment
set Allowed=1
where Id=@Fila
end
GO
/****** Object:  StoredProcedure [dbo].[BorrarProductoConAlerta]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[BorrarProductoConAlerta] 
	-- Add the parameters for the stored procedure here
	@Id_Producto int = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM StockAlertaProductos WHERE Id_Producto = @Id_Producto;

END


GO
/****** Object:  StoredProcedure [dbo].[BorrarUserParaAlertar]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[BorrarUserParaAlertar] 
	-- Add the parameters for the stored procedure here
	@Id_Usuario int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM StockAlertaUsuariosANotificar WHERE Id_Usuario = @Id_Usuario;
END


GO
/****** Object:  StoredProcedure [dbo].[CANCEL_DateAgenda]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CANCEL_DateAgenda](@idTurno bigint)
as
begin
delete AgendaTurnos where Id=@idTurno
end

GO
/****** Object:  StoredProcedure [dbo].[delete_article]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_article] (@idArt bigint, @idUser bigint)
as
begin
delete Articulos where Id=@idArt and IdUser=@idUser
end


GO
/****** Object:  StoredProcedure [dbo].[DELETE_FACTURA]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DELETE_FACTURA] (@IdUser bigint, @IdFactura bigint)
as
begin
delete Facturas where Id=@IdFactura and IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[Delete_SesionById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Delete_SesionById] (@Id bigint)
as
begin
delete from Sesiones
where IdTratamiento=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[delete_Supplier]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[delete_Supplier](@IdSupplier bigint, @IdUser bigint)
as
begin
delete Supplier where Id=@IdSupplier and IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[Delete_TreatmentById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Delete_TreatmentById] (@Id bigint)
as
begin
delete from Treatment where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[Delete_TurnosByIdUnico]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Delete_TurnosByIdUnico] (@IdUnico varchar(50))
as
begin
delete from AgendaTurnos where IdUnico=@IdUnico;
end

GO
/****** Object:  StoredProcedure [dbo].[Delete_Vendedor]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Delete_Vendedor] (@IdUser bigint, @IdVendedor bigint)
as
begin
delete Vendedores where IdUser=@IdUser and Id=@IdVendedor
end


GO
/****** Object:  StoredProcedure [dbo].[DeletePrintActionById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePrintActionById](@Iduser bigint, @IdAction bigint)
as
begin
delete PrintAction where IdUser=@IdUser and Id=@IdAction
end


GO
/****** Object:  StoredProcedure [dbo].[DeleteSesionFromTreatment]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteSesionFromTreatment] (@IdTratamiento bigint)
as
begin
delete from Sesiones where IdTratamiento=@IdTratamiento
end
GO
/****** Object:  StoredProcedure [dbo].[Get_BoxById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_BoxById](@Id bigint)
as
begin
select * from Boxes where Id=@Id 
end



GO
/****** Object:  StoredProcedure [dbo].[GET_Cliente_By_ID]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_Cliente_By_ID](@IdClient bigint, @IdUser bigint)
as
begin
select * from Clientes where Id=@IdClient and IdUser = @IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GET_DETALLEdERemitoByIdRemito]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_DETALLEdERemitoByIdRemito](@IdRemito bigint)
as
begin
select * from DetallesRemitos where IdRemito = @IdRemito
end


GO
/****** Object:  StoredProcedure [dbo].[GET_MovimientosClientesBeTweenDatesByIdLocal]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_MovimientosClientesBeTweenDatesByIdLocal](@IdLocal bigint, @Start varchar(50), @End varchar(50))
as
begin
select * from MovimientoClientes where IdLocal=@IdLocal and Fecha between convert(datetime,@Start,120) and convert(datetime,@End,120)
end

GO
/****** Object:  StoredProcedure [dbo].[GET_REMITObyID]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_REMITObyID](@IdRemito bigint, @IdUser bigint)
as
begin
select * from Remitos where IdUser=@IdUser and Id=@IdRemito
end


GO
/****** Object:  StoredProcedure [dbo].[GET_UserConfiguracion]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GET_UserConfiguracion](@IdUser bigint)
as
begin
select * from UserConfiguration where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GetAllPrintActionByIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllPrintActionByIdUser](@IdUser bigint)
as
begin
select PrintAction from PrintAction where IdUser = @IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GetAllTarjetasByIdLocal]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAllTarjetasByIdLocal](@idLocal bigint)
as
begin
select * from Tarjetas where IdLocal=@idLocal
end

GO
/****** Object:  StoredProcedure [dbo].[GetArqueosBetweenDates]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetArqueosBetweenDates](@IdLocal bigint, @DateStart Varchar(50), @DateEnd varchar(50))
as
begin
	Select * from ArqueosDeCaja where IdLocal=@IdLocal and Fecha between Convert(datetime,@DateStart,120) and Convert(datetime,@DateEnd,120)
end

GO
/****** Object:  StoredProcedure [dbo].[GetArticleById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetArticleById](@ID bigint)
as
begin
Select * from Articulos where Id=@ID
end
GO
/****** Object:  StoredProcedure [dbo].[GetAvailableTarjetasByIdLocal]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetAvailableTarjetasByIdLocal](@IdLocal bigint)
as
begin
select * from Tarjetas where IdLocal=@IdLocal and Available=1
end

GO
/****** Object:  StoredProcedure [dbo].[GetBoxesBySucursal]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBoxesBySucursal] (@IdSucursal bigint)
AS
BEGIN
select * from Boxes where IdSucursal = @IdSucursal

END

GO
/****** Object:  StoredProcedure [dbo].[GetDetalleFactura]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetDetalleFactura](@IdFactura bigint, @IdUser bigint)
as

begin
select * from DetallesFacturas where IdFactura=@IdFactura 
end



GO
/****** Object:  StoredProcedure [dbo].[GetFacturaFromId]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFacturaFromId](@IdUser bigint, @IdFactura bigint)
as
begin
select * from Facturas Where IdUser=@IdUser and Id=@IdFactura
end


GO
/****** Object:  StoredProcedure [dbo].[GetFacturasDisponibles]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetFacturasDisponibles](@IdUser bigint)
as
begin
select Id from Facturas Where Printed=0 and IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GetIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetIdUser](@key varchar(50))
as
begin
select IdUser,PrivateKey  from PrintersKeys Where PrivateKey=@key
end


GO
/****** Object:  StoredProcedure [dbo].[GetKeyUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetKeyUser](@IdUser bigint)
as
begin
select IdUser,PrivateKey  from PrintersKeys Where Iduser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GetLastArqueo]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[GetLastArqueo](@IdLocal bigint)
as
begin
	Select TOP 1 * from ArqueosDeCaja where IdLocal=@IdLocal Order By Id Desc
end

GO
/****** Object:  StoredProcedure [dbo].[GetLastSession]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetLastSession]
as
begin
select top 1 * from Sesiones order by Id desc
end

GO
/****** Object:  StoredProcedure [dbo].[getLastStockTratamiento]    Script Date: 29/06/2019 1:48:17 ******/
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
/****** Object:  StoredProcedure [dbo].[GetLastTreatment]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetLastTreatment]
as
begin
select top 1 * from Treatment order by Id desc
end

GO
/****** Object:  StoredProcedure [dbo].[GetPrintActionByIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPrintActionByIdUser](@IdUser bigint)
as
begin
select TOP 1 Id, PrintAction from PrintAction where IdUser = @IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GetPrintConfigurationByIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetPrintConfigurationByIdUser](@IdUser bigint)
as
begin
 select * from PrintConfiguration where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GetSesionesFromTreatmet]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetSesionesFromTreatmet] (@Id bigint)
as
begin
select * from Sesiones where IdTratamiento = @Id
end

GO
/****** Object:  StoredProcedure [dbo].[getStockTratamientoByIdTratamiento]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getStockTratamientoByIdTratamiento] (@IdUser bigint,@IdTratamiento bigint)
as
begin
select * from StockTratamiento where IdTratamiento = @IdTratamiento and IdUser=@IdUser
end

GO
/****** Object:  StoredProcedure [dbo].[GetTarjetaById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[GetTarjetaById](@IdTarjeta bigint)
as
begin
select * from Tarjetas where Id=@IdTarjeta
end

GO
/****** Object:  StoredProcedure [dbo].[GetTreatmentsBySucursal]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTreatmentsBySucursal] (@UserId bigint)
AS
BEGIN
select * from Treatment where UserId = @UserId

END

GO
/****** Object:  StoredProcedure [dbo].[GetVendedorById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetVendedorById] (@IdVendedor bigint)
as
begin
select * from Vendedores where Id = @IdVendedor
end



GO
/****** Object:  StoredProcedure [dbo].[GetVendedoresByIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetVendedoresByIdUser] (@IdUser bigint)
as
begin
select * from Vendedores where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[GuardarValor]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GuardarValor](@valor bigint,@operacion varchar(50), @pvalor bigint, @svalor bigint)
as
insert into Valores(Valor,Operacion,PrimerValor,SegundoValor) values(@valor,@operacion,@pvalor,@svalor)

GO
/****** Object:  StoredProcedure [dbo].[insert_Articulo]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_Articulo](
@Iduser bigint,
@Idproveedor bigint,
@CodigoInterno varchar (50),
@CodigoBarra varchar (50),
@Descripcion varchar (255),
@PrecioNeto decimal(18,4),
@IVA decimal(18,4),
@PrecioCompra decimal(18,4),
@PorcentajeGanancia decimal(18,4),
@PrecioFinal decimal(18,4),
@IdUnidad bigint,
@EsMateriaPrima bit,
@MateriaPrima bigint)
as
begin 
insert into Articulos(
IdUser,
IdProveedor,
CodigoInterno,
CodigoBarra,
Descripcion,
PrecioNeto,
IVA,
PrecioCompra,
PorcentajeGanancia,
PrecioFinal,
IdUnidad,
CantidadINT,
CantidadDEC,
Padre,
ArticuloPadre) values (
@Iduser ,
@Idproveedor ,
@CodigoInterno ,
@CodigoBarra ,
@Descripcion ,
@PrecioNeto ,
@IVA ,
@PrecioCompra ,
@PorcentajeGanancia ,
@PrecioFinal,
@IdUnidad,
0,
0,
@EsMateriaPrima,
@MateriaPrima)

end


GO
/****** Object:  StoredProcedure [dbo].[Insert_Cliente]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Cliente] 
(
@RazonSocial varchar(150),
@DNICUITCUIL varchar(100),
@Pais varchar(100),
@Provincia varchar(100),
@Localidad varchar(100),
@Domicilio varchar(100),
@Observaciones text,
@TipoIva varchar(100),
@Descuento decimal(18,4),
@Email varchar(100),
@Iduser bigint,
@LimiteDeCredito decimal(18,4),
@Suspendida bit
)
as
begin
declare @Registers bigint
declare @LastRegisterID bigint
Insert into Clientes 
	(RazonSocial, DNI_CUIT_CUIL, Pais, Provincia, Localidad,
	Domicilio, Observaciones, TipoIva,Descuento,Email,IdUser,LimiteDeCredito,Suspendida)
	values (@RazonSocial, @DNICUITCUIL, @Pais, @Provincia, @Localidad, @Domicilio,
	@Observaciones,@TipoIva,@Descuento,@Email,@Iduser,@LimiteDeCredito,@Suspendida)
set @Registers=@@ROWCOUNT
set @LastRegisterID = (select top 1 Id from Clientes where IdUser=@Iduser order by Id desc)
select @Registers as cantregister, @LastRegisterID as Id
	
end


GO
/****** Object:  StoredProcedure [dbo].[INSERT_DateAgenda]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Creacion de procesos de almacenado */
CREATE PROCEDURE [dbo].[INSERT_DateAgenda](@dateReservacion datetime, @IdCliente bigint, @IdUsuario bigint, @IdTratamiento bigint, @Estado varchar(20), @IdBox bigint, @IdUnico varchar(50))
as
begin
	insert into AgendaTurnos (DateReservacion,IdCliente,IdUsuario,IdTratamiento,Estado,IdBox,IdUnico) values (@dateReservacion,@IdCliente,@IdUsuario,@IdTratamiento,@Estado,@IdBox,@IdUnico)
end

GO
/****** Object:  StoredProcedure [dbo].[Insert_DetalleFactura]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Insert_DetalleFactura](@IdFactura bigint, @IdArticulo bigint, @PrecioNeto decimal(18,4), @IVA decimal(18,4), @PrecioCompra decimal(18,4), @PorcentajeGanancia decimal (18,4), @PrecioFinal decimal (18,4), @CantidadINT bigint, @CantidadDEC decimal(18,4))
as
begin
declare @NuevaCantidadDEC decimal(18,4)
declare @NuevaCantidadINT int
set @NuevaCantidadINT = (select CantidadINT from Articulos where Id=@IdArticulo)
set @NuevaCantidadINT = @NuevaCantidadINT-@CantidadINT
set @NuevaCantidadDEC = (select CantidadDEC from Articulos where Id=@IdArticulo)
set @NuevaCantidadDEC = @NuevaCantidadDEC-@CantidadDEC


insert into DetallesFacturas(
IdFactura, 
IdArticulo, 
PrecioNeto, 
IVA, 
PrecioCompra, 
PorcentajeGanancia, 
PrecioFinal, 
CantidadINT, 
CantidadDEC) values(
@IdFactura,
@IdArticulo,
@PrecioNeto,
@IVA,
@PrecioCompra,
@PorcentajeGanancia,
@PrecioFinal,
@CantidadINT,
@CantidadDEC)
update Articulos set CantidadINT=@NuevaCantidadINT, CantidadDEC=@NuevaCantidadDEC where Id=@IdArticulo
return 1


end


GO
/****** Object:  StoredProcedure [dbo].[Insert_DetalleFacturaConMateriaPrima]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[Insert_DetalleFacturaConMateriaPrima](@IdFactura bigint, @IdArticulo bigint, @IdMateriaprima bigint, @PrecioNeto decimal(18,4), @IVA decimal(18,4), @PrecioCompra decimal(18,4), @PorcentajeGanancia decimal (18,4), @PrecioFinal decimal (18,4), @CantidadINT bigint, @CantidadDEC decimal(18,4))
as
begin
declare @NuevaCantidadDEC decimal(18,4)
declare @NuevaCantidadINT int
set @NuevaCantidadINT = (select CantidadINT from Articulos where Id=@IdMateriaPrima)
set @NuevaCantidadINT = @NuevaCantidadINT-@CantidadINT
set @NuevaCantidadDEC = (select CantidadDEC from Articulos where Id=@IdMateriaPrima)
set @NuevaCantidadDEC = @NuevaCantidadDEC-@CantidadDEC


insert into DetallesFacturas(
IdFactura, 
IdArticulo, 
PrecioNeto, 
IVA, 
PrecioCompra, 
PorcentajeGanancia, 
PrecioFinal, 
CantidadINT, 
CantidadDEC) values(
@IdFactura,
@IdArticulo,
@PrecioNeto,
@IVA,
@PrecioCompra,
@PorcentajeGanancia,
@PrecioFinal,
@CantidadINT,
@CantidadDEC)
update Articulos set CantidadINT=@NuevaCantidadINT, CantidadDEC=@NuevaCantidadDEC where Id=@IdMateriaprima
return 1


end



GO
/****** Object:  StoredProcedure [dbo].[Insert_DetalleFacturaTratamiento]    Script Date: 29/06/2019 1:48:17 ******/
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
/****** Object:  StoredProcedure [dbo].[Insert_DetallePresupuesto]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[Insert_DetallePresupuesto](@IdFactura bigint, @IdArticulo bigint, @PrecioNeto decimal(18,4), @IVA decimal(18,4), @PrecioCompra decimal(18,4), @PorcentajeGanancia decimal (18,4), @PrecioFinal decimal (18,4), @CantidadINT bigint, @CantidadDEC decimal(18,4))
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
CantidadDEC) values(
@IdFactura,
@IdArticulo,
@PrecioNeto,
@IVA,
@PrecioCompra,
@PorcentajeGanancia,
@PrecioFinal,
@CantidadINT,
@CantidadDEC)
return 1
end


GO
/****** Object:  StoredProcedure [dbo].[Insert_DetalleRemito]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Insert_DetalleRemito](
@IdRemito bigint,
@IdArticulo bigint,
@Costo decimal (18,4),
@CantDEC decimal (18,4),
@CantINT bigint,
@Total decimal (18,4))
as
begin
insert into DetallesRemitos(
IdRemito,
IdArticulo,
Costo,
CantDEC,
CantINT,
Total) values 
(@IdRemito,@IdArticulo,@Costo,@CantDEC,@CantINT,@Total)
end


GO
/****** Object:  StoredProcedure [dbo].[insert_Factura]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[insert_Factura](
@IdUser bigint,
@SerialAFIP varchar(255),
@SerialTICKET varchar(255),
@Printed bit,
@PrintAgain bit,
@Transmitida bit,
@Fecha datetime,
@Tipo varchar(5),
@Nombre varchar(255),
@Domicilio varchar(255),
@Telefono varchar(255),
@Localidad varchar(255),
@Cuit varchar(255),
@RepInsc bit,
@RespNoInsc bit,
@Exento bit,
@ConsumidorFinal bit,
@RespMonotributo bit,
@Contado bit,
@CtaCte bit,
@IdCtaCte bigint,
@Cheque bit,
@Dni varchar(255),
@Tarjeta bit,
@Idtargeta bigint,
@NumeroTarjeta varchar(50),
@Observaciones text,
@SubTotal decimal(18,4),
@Ivas bit,
@Total decimal(18,4))
as
begin
INSERT INTO Facturas
           (IdUser
           ,SerialAFIP
           ,SerialTICKET
           ,Printed
           ,PrintAgain
           ,Transmitida
           ,Fecha
           ,Tipo
           ,Nombre
           ,Domicilio
           ,Telefono
           ,Localidad
           ,Cuit
           ,RepInsc
           ,RespNoInsc
           ,Exento
           ,ConsumidorFinal
           ,RespMonotributo
           ,Contado
           ,CtaCte
           ,IdCtaCte
           ,Cheque
           ,Dni
           ,Tarjeta
           ,Idtargeta
           ,NumeroTarjeta
           ,Observaciones
           ,SubTotal
           ,Ivas
           ,Total)
     VALUES
           (@IdUser,@SerialAFIP,@SerialTICKET,@Printed,@PrintAgain,@Transmitida,@Fecha,@Tipo,
           @Nombre,@Domicilio,@Telefono,@Localidad,@Cuit,@RepInsc,@RespNoInsc,@Exento,
           @ConsumidorFinal,@RespMonotributo,@Contado,@CtaCte,@IdCtaCte,@Cheque,@Dni,@Tarjeta,
           @Idtargeta,@NumeroTarjeta,@Observaciones,@SubTotal,@Ivas,@Total)
           Select TOP 1 Id from Facturas Order by Id DESC
           
end


GO
/****** Object:  StoredProcedure [dbo].[Insert_FacturaEnVendedor]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Insert_FacturaEnVendedor](@IdUser bigint, @IdVendedor bigint, @IdFactura bigint)
as
begin
insert VendedoresYFacturas(IdUser,IdSeller,IdFactura) values (@IdUser,@IdVendedor,@IdFactura)
end


GO
/****** Object:  StoredProcedure [dbo].[Insert_MovimientoCliente]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_MovimientoCliente](
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


GO
/****** Object:  StoredProcedure [dbo].[Insert_Remito]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Insert_Remito](
@IdUser bigint,
@IdProveedor bigint,
@NroRemito varchar(100),
@Fecha varchar(100),
@Total decimal(18,4))
as
begin
insert into Remitos(IdUser,IdProveedor,NroRemito,Fecha,Total) values(
@IdUser, @IdProveedor,@NroRemito, @Fecha,@Total)
select top 1 Id from Remitos order  by Id desc
end


GO
/****** Object:  StoredProcedure [dbo].[Insert_Sesion]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Sesion] (@IdTratamiento bigint, @Nombre varchar(50), @Monto decimal(18,4), @Costo decimal(18,4), @Descripcion varchar(200))
as
begin
insert into Sesiones(IdTratamiento, Nombre, Monto, Costo, Descripcion) values (@IdTratamiento, @Nombre, @Monto, @Costo, @Descripcion)
end
GO
/****** Object:  StoredProcedure [dbo].[insert_Supplier]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[insert_Supplier](
      @p_IdUser bigint,
      @p_Nombre varchar(255),
      @p_NombreFantasía varchar (255),
      @p_País bigint,
      @p_Provincia bigint,      
      @p_Localidad varchar(100),
      @p_Domicilio varchar(100),
      @p_Teléfono1 varchar(100),
      @p_Teléfono2 varchar(100),
      @p_MailContacto varchar(50),
      @p_MailPedidos varchar(50),
      @p_IdCategoriaAfip bigint,
      @p_NroIngresosBrutos varchar(50),
      @p_IdTipoDocumento bigint,
      @p_NroDocumento varchar(50),
	  @p_Detalle varchar(50)
      )
      as
      begin
      insert into Supplier([IdUser]
      ,[Nombre]
      ,[NombreFantasía]
      ,[País]
      ,[Provincia]
      ,[Localidad]
      ,[Domicilio]
      ,[Teléfono1]
      ,[Teléfono2]
      ,[MailContacto]
      ,[MailPedidos]
      ,[IdCategoriaAfip]
      ,[NroIngresosBrutos]
      ,[IdTipoDocumento]
      ,[NroDocumento]
	  ,[Detalle]) values (
      @p_IdUser,
      @p_Nombre,
      @p_NombreFantasía,
      @p_País,
      @p_Provincia,      
      @p_Localidad,
      @p_Domicilio,
      @p_Teléfono1,
      @p_Teléfono2,
      @p_MailContacto,
      @p_MailPedidos,
      @p_IdCategoriaAfip,
      @p_NroIngresosBrutos,
      @p_IdTipoDocumento,
      @p_NroDocumento,
	  @p_Detalle)
      select TOP 1 Id from Supplier order by Id DESC
      end



GO
/****** Object:  StoredProcedure [dbo].[INSERT_TARJETA]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_TARJETA](@Idlocal bigint, @Recargo decimal(18,2), @NombreTarjeta varchar(50))
as
begin
	insert into Tarjetas(IdLocal, Recargo, NombreTarjeta,Available) values (@IdLocal,@Recargo,@NombreTarjeta,1)
end
GO
/****** Object:  StoredProcedure [dbo].[Insert_Treatment]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Insert_Treatment] (@UserId bigint, @Nombre varchar(50),@Precio decimal(18,4), @FechaCreacion date, @FechaCaducidad date, @Descripcion varchar(200), @Allowed bit)
as
begin
insert into Treatment(UserId,Nombre,Precio,FechaCreacion,FechaCaducidad,Descripcion,Allowed) values(@UserId,@Nombre,@Precio,@FechaCreacion,@FechaCaducidad,@Descripcion,@Allowed)
end


GO
/****** Object:  StoredProcedure [dbo].[Insert_Vendedor]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Vendedor] (@IdUser bigint, @NombreVendedor varchar(255), @PorcentajeComision decimal(18,4))
as
begin
	insert into Vendedores(IdUser,NombreVendedor,PorcentajeComision) values (@IdUser,@NombreVendedor,@PorcentajeComision)
end


GO
/****** Object:  StoredProcedure [dbo].[Insertameesta]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[Insertameesta](@parametronombre varchar(50), @pApel varchar(50), @paredad bigint)
as
begin
insert into Clientes (Nombre, Apellido,Edad) values(@parametronombre,@pApel,@paredad)
end
GO
/****** Object:  StoredProcedure [dbo].[InsertArqueo]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertArqueo](@IdLocal bigint, @Total decimal(18,2), @Fecha Varchar(50), @Anotaciones varchar(255))
as
begin
	Insert into ArqueosDeCaja(IdLocal,Total,Fecha,Anotaciones) values (@IdLocal,@Total,Convert(Datetime,@Fecha,120),@Anotaciones)
end


GO
/****** Object:  StoredProcedure [dbo].[InsertPago]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPago] 
(
@IdUser Bigint,
@IdSeller Bigint,
@Fecha varchar(100),
@Monto decimal(18,2),
@Detalle varchar(250)
) as
begin
insert into Pagos(IdUser,IdSeller,Fecha,Monto,Detalle) values (@IdUser,@IdSeller,@Fecha,@Monto,@Detalle)
end


GO
/****** Object:  StoredProcedure [dbo].[InsertPrintAction]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertPrintAction](@IdUser bigint, @PrintAction varchar(50))
as
begin
insert into PrintAction(IdUser,PrintAction) values (@IdUser,@PrintAction)
end


GO
/****** Object:  StoredProcedure [dbo].[InsertPrintConfiguration]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InsertPrintConfiguration](@IdUser bigint, @Puerto varchar(6), @Baudios bigint, @Modelo varchar(50))
as
begin
	insert into PrintConfiguration(IdUser, Puerto, Baudios,Modelo) values (@IdUser, @Puerto, @Baudios, @Modelo)
end


GO
/****** Object:  StoredProcedure [dbo].[InsertRetiro]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertRetiro] 
(
@IdUser Bigint,
@IdSeller Bigint,
@Fecha varchar(100),
@Monto decimal(18,2),
@Detalle varchar(250)
) as
begin
insert into Retiros(IdUser,IdSeller,Fecha,Monto,Detalle) values (@IdUser,@IdSeller,@Fecha,@Monto,@Detalle)
end


GO
/****** Object:  StoredProcedure [dbo].[insertStockATratamiento]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[insertStockATratamiento] (@IdUser bigint, @IdArticulo bigint, @CantINT bigint, @CantDEC decimal(18,4), @IdTratamiento bigint)
as
begin
insert into StockTratamiento(IdUser,IdArticulo,CanINT,CantDEC,IdTratamiento) values (@IdUser,@IdArticulo,@CantINT,@CantDEC,@IdTratamiento)
end



GO
/****** Object:  StoredProcedure [dbo].[insertStockTratamientoConsumido]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[insertStockTratamientoConsumido] (@Iduser bigint, @IdArticulo bigint, @IdTratamiento bigint, @FechaConsumido datetime, @IdStockTratamiento bigint)
as
begin
insert into StockTratamientoConsumido (IdUser,IdArticulo,IdTratamiento,FechaConsumido) values (@IdUser,@IdArticulo,@IdTratamiento,@FechaConsumido)
delete from StockTratamiento where Id = @IdStockTratamiento
end



GO
/****** Object:  StoredProcedure [dbo].[InsertUserConfiguration]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertUserConfiguration](@IdUser bigint, @NombreNegocio varchar(200), @MostrarLogo bit, @FacturaPorDefecto varchar(2), @PIN varchar(5), @Kiosco bit)
as
begin
insert into UserConfiguration(IdUser,NombreNegocio,MostrarLogoNegocio,FacturaPorDefecto,PIN,Kiosco) values (@IdUser,@NombreNegocio,@MostrarLogo,@FacturaPorDefecto,@PIN,@Kiosco)
end


GO
/****** Object:  StoredProcedure [dbo].[Logme]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Logme] (@seller varchar(255), @pass varchar(8), @IdUser bigint)
as
begin
select * from Vendedores where 
NombreVendedor=@seller and 
[Password]=@pass and
[IdUser]=@IdUser
end

GO
/****** Object:  StoredProcedure [dbo].[ModificarProductoConAlertaDeStock]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[ModificarProductoConAlertaDeStock] 
	-- Add the parameters for the stored procedure here
	@Id_Producto int ,
	@Nuevo_Stock_Minimo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE StockAlertaProductos
	SET Stock_Minimo = @Nuevo_Stock_Minimo 
	WHERE Id_Producto = @Id_Producto;
END


GO
/****** Object:  StoredProcedure [dbo].[ObtenerLocal]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ObtenerLocal] (@iduser bigint)
as
begin 
	select * from Empleados_Local where UserID = @iduser
end

GO
/****** Object:  StoredProcedure [dbo].[RecuperarProductosConAlertaDeStock]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[RecuperarProductosConAlertaDeStock] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id_Producto FROM StockAlertaProductos
END


GO
/****** Object:  StoredProcedure [dbo].[RecuperarUsuariosParaAlertar]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[RecuperarUsuariosParaAlertar] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Id_Usuario FROM StockAlertaUsuariosANotificar
END


GO
/****** Object:  StoredProcedure [dbo].[Search_Cliente_Begin]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Search_Cliente_Begin] (@IdUser bigint,@SearchString varchar(50))
	as
	begin

	declare @beginr bigint
	set @beginr = (Select COUNT(*) from Clientes where RazonSocial Like @SearchString+'%' and IdUser=@IdUser)
	declare @middler bigint
	set @middler = (Select COUNT(*) from Clientes where RazonSocial Like '%'+@SearchString+'%' and IdUser=@IdUser)
	declare @finalr bigint
	set @finalr = (Select COUNT(*) from Clientes where RazonSocial Like '%'+@SearchString and IdUser=@IdUser)

	if (@beginr>0)
	begin
		Select * from Clientes where RazonSocial Like @SearchString+'%' and IdUser=@IdUser
	end
	else if (@middler>0)
	begin
		Select * from Clientes where RazonSocial Like '%'+@SearchString+'%' and IdUser=@IdUser
	end
	else if (@finalr>0)
	begin
		Select * from Clientes where RazonSocial Like '%'+@SearchString and IdUser=@IdUser
	end
	
end


GO
/****** Object:  StoredProcedure [dbo].[Search_Sesion]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Search_Sesion](@stringbusqueda varchar(50))
as
begin
select * from Sesiones where Nombre like '%' + @stringbusqueda + '%'
end


GO
/****** Object:  StoredProcedure [dbo].[Search_Tratamiento]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Search_Tratamiento](@LocalId bigint, @cadenadebusqueda varchar(50))
as
begin
select * from Treatment where Nombre like '%' + @cadenadebusqueda + '%' and UserId = @LocalId order by Nombre
end

GO
/****** Object:  StoredProcedure [dbo].[SearchArticle]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*posible options codi, codb, desc*/
CREATE Procedure [dbo].[SearchArticle] (@IdUser bigint, @SearchString varchar(255), @SearchBy varchar(10), @Provider bigint=-1)
as
begin
declare @minprov bigint
declare @maxprov bigint
set @minprov = -1
set @maxprov = 100000000
if (@Provider<>-1)
begin
set @minprov = @Provider
set @maxprov = @Provider
end
if (@SearchBy='codi')
begin
select * from Articulos where IdUser=@IdUser and IdProveedor between @minprov and @maxprov and CodigoInterno like @SearchString + '%' 
end
if (@SearchBy='codb')
begin
select * from Articulos where IdUser=@IdUser and IdProveedor between @minprov and @maxprov and CodigoBarra like @SearchString + '%'
end
if (@SearchBy='desc')
begin
select * from Articulos where IdUser=@IdUser and IdProveedor between @minprov and @maxprov and Descripcion like @SearchString + '%'
end
end


GO
/****** Object:  StoredProcedure [dbo].[searchLocales]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[searchLocales] (@stringBusqueda varchar(50))
as
begin
select * from Sucursales where NombreLocal like '%' + @stringBusqueda + '%'
end

GO
/****** Object:  StoredProcedure [dbo].[select_allArticlesByPaging]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_allArticlesByPaging](@Letter varchar(50),@Page bigint, @Limit bigint, @IdUser bigint, @IdSupplier bigint)
as
begin
declare @cadena varchar(50)
declare @pagecount decimal(10,2)
declare @start bigint
declare @end bigint
set @cadena = @Letter + '%'
set @start = ((@Page*@Limit)-@Limit)+1
set @end = @Page*@Limit

IF @IdSupplier=0



begin
select * from 
(select ROW_NUMBER() over (order by Descripcion) as RowNumber,* from Articulos where IdUser=@IdUser and Descripcion like @cadena) as RCR where RowNumber between @start and @end 
set @pagecount = (select COUNT(*) from Articulos where IdUser=@IdUser)/@Limit
end

IF @IdSupplier<>0
begin
select * from 
(select ROW_NUMBER() over (order by Descripcion) as RowNumber,* from Articulos where IdUser=@IdUser and IdProveedor=@IdSupplier and Descripcion like @cadena) as RCR where RowNumber between @start and @end and Descripcion like @cadena
set @pagecount = (select COUNT(*) from Articulos where IdUser=@IdUser and IdProveedor=@IdSupplier)/@Limit
end


end


GO
/****** Object:  StoredProcedure [dbo].[select_allArticlesByPagingINFO]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_allArticlesByPagingINFO](@Letter varchar(50),@Page bigint, @Limit bigint, @IdUser bigint, @IdSupplier bigint)
as
begin
declare @cadena varchar(50)
declare @pagecount decimal(10,2)
declare @start bigint
declare @end bigint
set @cadena = @Letter + '%'
set @start = ((@Page*@Limit)-@Limit)+1
set @end = @Page*@Limit

IF @IdSupplier=0



begin

set @pagecount = (select COUNT(*) from Articulos where IdUser=@IdUser and Descripcion like @cadena)/@Limit
end

IF @IdSupplier<>0
begin

set @pagecount = (select COUNT(*) from Articulos where IdUser=@IdUser and IdProveedor=@IdSupplier and Descripcion like @cadena)/@Limit
end


select CAST(@pagecount as bigint)+1 as CantidadPaginas

end


GO
/****** Object:  StoredProcedure [dbo].[select_allCategoriaAFIP]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[select_allCategoriaAFIP]
as
begin
select Id,IdCategoriaAFIP,Nombre from CategoriaAFIP
end


GO
/****** Object:  StoredProcedure [dbo].[select_allProvincia]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[select_allProvincia]
as
begin
select Id,Nombre from Provincia
end


GO
/****** Object:  StoredProcedure [dbo].[Select_AllRemitos]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Select_AllRemitos](@IdUser bigint)
as
begin
select * from Remitos where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[select_allSupliersNames]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_allSupliersNames](@IdUser bigint)
as
begin
select Supplier.Id, Supplier.Nombre, Supplier.NombreFantasía, Supplier.Detalle from Supplier where Supplier.IdUser=@IdUser
end



GO
/****** Object:  StoredProcedure [dbo].[select_allSuppliers]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_allSuppliers](@idUser bigint)
as
begin
SELECT Supplier.Id,Supplier.Nombre,Supplier.NombreFantasía, Supplier.Teléfono1 as 'Telefono', Supplier.Detalle as 'Detalle', Supplier.MailContacto as 'Mail'
  FROM Supplier WHERE Supplier.IdUser = @idUser
  end



GO
/****** Object:  StoredProcedure [dbo].[select_allTipoDocumento]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[select_allTipoDocumento]
as
begin
select Id,IdTipoDocumento,Nombre from TipoDocumento
end


GO
/****** Object:  StoredProcedure [dbo].[select_allUnidades]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_allUnidades]
as
begin
select * from UnidadesMedidas
end


GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaBetweenDate]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_DateAgendaBetweenDate](@Start datetime, @End datetime, @IdUsuario bigint, @IdBox bigint)
as
begin
select * from AgendaTurnos where IdUsuario=@IdUsuario and IdBox=@IdBox and DateReservacion between @Start and @End
end

GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_DateAgendaById](@Id bigint)
as
begin
select * from AgendaTurnos Where Id=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaByIdCliente]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_DateAgendaByIdCliente](@IdUser bigint, @IdCliente bigint)
as
begin 
select * from AgendaTurnos where IdCliente=@IdCliente and IdUsuario=@IdUser;
end

GO
/****** Object:  StoredProcedure [dbo].[SELECT_FACTURASBetweenDates]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SELECT_FACTURASBetweenDates] (@IdUser bigint, @FechaDesde varchar(255), @FechaHasta varchar(255), @TipoFactura varchar(5), @Printed bit)
as
begin
	if @TipoFactura='0'
		begin
			select * from Facturas where IdUser=@IdUser and Printed=@Printed and Fecha Between CONVERT(datetime,@FechaDesde,120) and CONVERT(datetime,@FechaHasta,120)
		end
	else
		begin
					select * from Facturas where IdUser=@IdUser and Printed=@Printed and Tipo=@TipoFactura and Fecha Between Convert(datetime,@FechaDesde,120) and CONVERT(datetime,@FechaHasta,120)
		end
end



GO
/****** Object:  StoredProcedure [dbo].[Select_FacturasByIdCliente]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Select_FacturasByIdCliente](@IdCliente bigint)
as
begin
select *  from Facturas where IdCtaCte=@IdCliente
end


GO
/****** Object:  StoredProcedure [dbo].[Select_MateriasPrimas]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_MateriasPrimas] (@IdUser bigint)
as
begin
select * from articulos where Padre = 1 and IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[Select_MovimientoCCByIdClient]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_MovimientoCCByIdClient](@IdClient bigint)
as
begin
select * from MovimientoClientes where IdCliente=@IdClient order by Fecha asc
end


GO
/****** Object:  StoredProcedure [dbo].[select_pagosbetweendates]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[select_pagosbetweendates]
(
@IdUser bigint,
@DateStart varchar(100),
@DateEnd varchar(100)
) as begin 
select * from Pagos where Fecha 
between Convert(Datetime,@DateStart) and Convert(Datetime,@DateEnd) 
and IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[select_pagosbyIdSeller]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_pagosbyIdSeller](@IdUser bigint, @IdSeller bigint)
as
begin
select * from Pagos where IdUser=@IdUser and IdSeller=@IdSeller
end


GO
/****** Object:  StoredProcedure [dbo].[select_PagosByIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_PagosByIdUser](@IdUser bigint)
as
begin
select * from Pagos where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[Select_Password_Vendedor]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[Select_Password_Vendedor](@IdUser bigint, @IdVendedor bigint)
as
begin
select [Password] from Vendedores where Id=@IdVendedor and IdUser=@IdUser
end

GO
/****** Object:  StoredProcedure [dbo].[SELECT_REMITOSBetweenDates]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_REMITOSBetweenDates] (@IdUser bigint, @FechaDesde varchar(255), @FechaHasta varchar(255))
as
begin
	select * from Remitos where IdUser=@IdUser and (Fecha between @FechaDesde and @FechaHasta) 
end


GO
/****** Object:  StoredProcedure [dbo].[select_retirosbetweendates]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_retirosbetweendates]
(
@IdUser bigint,
@DateStart varchar(100),
@DateEnd varchar(100)
) as begin 
select * from Retiros where Fecha 
between Convert(Datetime,@DateStart) and Convert(Datetime,@DateEnd) 
and IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[select_retirosbyIdSeller]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_retirosbyIdSeller](@IdUser bigint, @IdSeller bigint)
as
begin
select * from Retiros where IdUser=@IdUser and IdSeller=@IdSeller
end


GO
/****** Object:  StoredProcedure [dbo].[select_RetirosByIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_RetirosByIdUser](@IdUser bigint)
as
begin
select * from Retiros where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[select_SearchArticleForSTOCK]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[select_SearchArticleForSTOCK](@IdUser bigint, @Code varchar(50), @Name varchar(255), @IdProveedor bigint)
as
begin

declare @searchCode as varchar(255)
declare @searchName as varchar(255)
set @searchCode = @Code + '%'
set @searchName = @Name + '%'

IF @IdProveedor=0
begin
	select Articulos.*,
	       Supplier.Nombre as NombreProveedor, 
	       UnidadesMedidas.Nombre as NombreUnidad 
	       from Articulos 
	inner join Supplier on Supplier.Id = Articulos.IdProveedor 
	inner Join UnidadesMedidas on UnidadesMedidas.Id = Articulos.IdUnidad 
	where Articulos.CodigoInterno like @searchCode and 
	Articulos.Descripcion like @searchName and 
	Articulos.IdUser=@IdUser
end
IF @IdProveedor<>0
begin
	select Articulos.*,
	       Supplier.Nombre as NombreProveedor, 
	       UnidadesMedidas.Nombre as NombreUnidad 
	       from Articulos 
	inner join Supplier on Supplier.Id = Articulos.IdProveedor 
	inner Join UnidadesMedidas on UnidadesMedidas.Id = Articulos.IdUnidad 
	where Articulos.CodigoInterno like @searchCode and 
	Articulos.Descripcion like @searchName and 
	Articulos.IdUser=@IdUser and 
	Articulos.IdProveedor=@IdProveedor
end

end


GO
/****** Object:  StoredProcedure [dbo].[Select_Sesion]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Select_Sesion]
as
begin
select * from Sesiones
end
GO
/****** Object:  StoredProcedure [dbo].[Select_SesionByID]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[Select_SesionByID] (@Id bigint)
as
begin
select * from Sesiones where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[select_singleArticle]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_singleArticle](@IdUser bigint, @IdProveedor bigint, @CodigoInterno varchar(50))
as
begin
select * from Articulos where IdUser=@IdUser and IdProveedor=@IdProveedor and LOWER(CodigoInterno)=LOWER(@CodigoInterno)
end


GO
/****** Object:  StoredProcedure [dbo].[select_singlearticlebase]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[select_singlearticlebase](@IdUser bigint, @IdArticle bigint)
as
begin
select * from Articulos where Id=@IdArticle and IdUser = @IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[select_singlearticlebaseByCodes]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_singlearticlebaseByCodes](@IdUser bigint, @CodeArticle varchar(255))
as
begin
select * from Articulos where (CodigoBarra=@CodeArticle OR CodigoInterno=@CodeArticle)  and IdUser = @IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[select_SingleSupplier]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[select_SingleSupplier](@IdUser bigint, @IdSupplier bigint)
as
begin
select * from Supplier where Supplier.IdUser=@IdUser and Supplier.Id=@IdSupplier
end


GO
/****** Object:  StoredProcedure [dbo].[select_singleUnidades]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[select_singleUnidades](@IdUnidad bigint)
as
begin
select * from UnidadesMedidas where Id=@IdUnidad
end


GO
/****** Object:  StoredProcedure [dbo].[select_top5productsByCodigo]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_top5productsByCodigo] (@UserId bigint, @Top bigint, @Chain varchar(50) )
as
begin
declare @chaintosearch varchar(50) = @Chain + '%'
select distinct top (@Top) CodigoInterno from Articulos where CodigoInterno like @chaintosearch and IdUser=@UserId
end


GO
/****** Object:  StoredProcedure [dbo].[select_top5productsByName]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[select_top5productsByName] (@UserId bigint, @Top bigint, @Chain varchar(50) )
as
begin
declare @chaintosearch varchar(50) = @Chain + '%'
select distinct top (@Top) Descripcion from Articulos where Descripcion like @chaintosearch and IdUser=@UserId
end


GO
/****** Object:  StoredProcedure [dbo].[Select_TreatmentByID]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Select_TreatmentByID] (@Id bigint)
as
begin
select * from Treatment where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[SELECT_ULTIMAFACTURACREADA]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_ULTIMAFACTURACREADA] (@IdUser bigint)
as
begin
select top 1 * from Facturas where IdUser=@IdUser ORDER BY Id desc
end


GO
/****** Object:  StoredProcedure [dbo].[Serlect_ClienteByID]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Serlect_ClienteByID] (@iduser bigint, @idclient bigint)
as
begin
select * from Clientes where Id=@idclient and IdUser = @iduser
end


GO
/****** Object:  StoredProcedure [dbo].[TirameTodo]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[TirameTodo]
as
begin
select * from Clientes
select Nombre from Clientes
end
GO
/****** Object:  StoredProcedure [dbo].[Unallow_Treatment]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Unallow_Treatment] (@Id bigint)
as
begin
update Treatment
set Allowed=0
where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[update_ArticleCantidad]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_ArticleCantidad](@Iduser bigint, @IdProduct bigint, @CantidadINT bigint, @CantidadDEC decimal(18,4), @Decimal bit)
as
begin
if @Decimal=1
begin
update Articulos set 
CantidadDEC=@CantidadDEC where 
IdUser=@Iduser and Id=@IdProduct
end
else
begin
update Articulos set 
CantidadINT=@CantidadINT where 
IdUser=@Iduser and Id=@IdProduct
end
end


GO
/****** Object:  StoredProcedure [dbo].[update_ArticleData]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[update_ArticleData] (
@IdArt bigint,
@IdUser bigint,
@IdProvider bigint, 
@CodigoInterno varchar(50), 
@CodigoBarra varchar(50), 
@Descripcion varchar(255), 
@PrecioNeto decimal (18,4),
@IVA decimal (18,4),
@PrecioCompra decimal (18,4),
@PorcentajeGanancia decimal (18,4),
@PrecioFinal decimal (18,4),
@IdUnidad bigint,
@EsMateriaPrima bit,
@MateriaPrima bigint)
as
begin
Update Articulos set 
IdProveedor=@IdProvider, 
CodigoInterno=@CodigoInterno,
CodigoBarra=@CodigoBarra,
Descripcion = @Descripcion,
PrecioNeto = @PrecioNeto,
IVA = @IVA,
PrecioCompra = @PrecioCompra,
PorcentajeGanancia = @PorcentajeGanancia,
PrecioFinal = @PrecioFinal,
IdUnidad = @IdUnidad,
Padre = @EsMateriaPrima,
ArticuloPadre = @MateriaPrima
 where IdUser=@IdUser and Id=@IdArt
end


GO
/****** Object:  StoredProcedure [dbo].[update_articlePrice]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[update_articlePrice](@IdUser bigint,@Id bigint, @precioneto decimal(18,4), @iva decimal(18,4),@preciocompra decimal(18,4),@porcentajeganancia decimal(18,4),@preciofinal decimal(18,4))
as
begin
update Articulos set PrecioNeto=@precioneto,IVA=@iva,PrecioCompra=@preciocompra,PorcentajeGanancia=@porcentajeganancia,PrecioFinal=@preciofinal where IdUser=@IdUser and Id=@Id
end


GO
/****** Object:  StoredProcedure [dbo].[Update_Cliente]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Cliente] 
(
@IdCliente bigint,
@RazonSocial varchar(150),
@DNICUITCUIL varchar(100),
@Pais varchar(100),
@Provincia varchar(100),
@Localidad varchar(100),
@Domicilio varchar(100),
@Observaciones text,
@TipoIva varchar(100),
@Descuento decimal(18,4),
@Email varchar(100),
@IdUser bigint,
@LimiteDeCredito decimal(18,4),
@Suspendida bit
)
as
begin
	update Clientes set 
	RazonSocial=@RazonSocial, DNI_CUIT_CUIL=@DNICUITCUIL, Pais=@Pais, Provincia=@Provincia, Localidad=@Localidad,
	Domicilio=@Domicilio, Observaciones=@Observaciones, TipoIva=@TipoIva,Descuento=@Descuento,Email=@Email,LimiteDeCredito=@LimiteDeCredito, Suspendida=@Suspendida
	where Id=@IdCliente and IdUser = @IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[Update_Password_Vendedor]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_Password_Vendedor](
@IdUser bigint, 
@IdVendedor bigint, 
@Password varchar(8))
as
begin 
update Vendedores set [Password]=@Password where Id=@IdVendedor and IdUser=@IdUser
end

GO
/****** Object:  StoredProcedure [dbo].[Update_Sesion]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Update_Sesion] (@IdTratamiento bigint, @Nombre varchar(50), @Monto decimal(18,4), @Costo decimal(18,4), @Descripcion varchar(200), @Id bigint)
as
begin
update Sesiones
SET IdTratamiento=@IdTratamiento, Nombre=@Nombre, Monto=@Monto, Costo=@Costo, Descripcion=@Descripcion
where Id=@Id
end
GO
/****** Object:  StoredProcedure [dbo].[update_Supplier]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[update_Supplier] 
(
@IdUser bigint,
@IdSupplier bigint,
@Nombre varchar(255),
@NombreFantasia varchar(255),
@Pais bigint,
@Provincia bigint,
@Localidad varchar(100),
@Domicilio varchar(100),
@Telefono1 varchar(100),
@Telefono2 varchar(100),
@MailContacto varchar(50),
@MailPedidos varchar(50),
@IdCategoriaAfip bigint,
@NroIngresosBrutos varchar(50),
@IdTipoDocumento bigint,
@NroDocumento varchar(50),
@Detalle varchar(50)
)
as
begin
update Supplier set 
Nombre=@Nombre, 
NombreFantasía=@NombreFantasia, 
País=@Pais,
Provincia=@Provincia,
Localidad=@Localidad,
Domicilio=@Domicilio,
Teléfono1=@Telefono1,
Teléfono2=@Telefono2,
MailContacto=@MailContacto,
MailPedidos=@MailPedidos,
IdCategoriaAfip=@IdCategoriaAfip,
NroIngresosBrutos=@NroIngresosBrutos,
IdTipoDocumento=@IdTipoDocumento,
NroDocumento=@NroDocumento,
Detalle=@Detalle
where Id=@IdSupplier and IdUser=@IdUser
end



GO
/****** Object:  StoredProcedure [dbo].[Update_Treatment]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Update_Treatment] (@Nombre varchar(50),@Precio decimal(18,4), @FechaCreacion date, @FechaCaducidad date, @Descripcion varchar(200), @Allowed bit, @Id bigint)
as
begin
update Treatment
set Nombre=@Nombre, Precio=@Precio, FechaCreacion=@FechaCreacion, FechaCaducidad=@FechaCaducidad, Descripcion=@Descripcion, Allowed=@Allowed
where id=@Id
end

GO
/****** Object:  StoredProcedure [dbo].[UPDATE_UserConfiguration]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UPDATE_UserConfiguration](@IdUser bigint, @NombreNegocio varchar(200), @MostrarLogo bit, @FacturaPorDefecto varchar(2), @PIN varchar(5), @Kiosco bit)
as
begin
update UserConfiguration set NombreNegocio=@NombreNegocio, MostrarLogoNegocio=@MostrarLogo, FacturaPorDefecto=@FacturaPorDefecto, PIN=@PIN, Kiosco=@Kiosco where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[UpdateAvailabilityTarjetaById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[UpdateAvailabilityTarjetaById](@IdTarjeta bigint, @State bit)
as
begin
update Tarjetas set Available=@State where Id=@IdTarjeta
end

GO
/****** Object:  StoredProcedure [dbo].[UpdateFacturaTicket]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateFacturaTicket] (@UserId bigint, @FacturaID bigint, @ticketId varchar(255))
as
begin
Update Facturas set Printed=1,Transmitida=1,SerialTICKET=@ticketId where Id=@FacturaID and IdUser=@UserId
end


GO
/****** Object:  StoredProcedure [dbo].[UpdateNombreTarjetaById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[UpdateNombreTarjetaById](@IdTarjeta bigint, @Nombre varchar(50))
as
begin
update Tarjetas set NombreTarjeta=@Nombre where Id=@IdTarjeta
end

GO
/****** Object:  StoredProcedure [dbo].[UpdatePrintConfigurationByIdUser]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdatePrintConfigurationByIdUser](@IdUser bigint, @Puerto varchar(6), @Baudios bigint, @Modelo varchar(50))
as
begin
update PrintConfiguration set Puerto=@Puerto, Baudios=@Baudios, Modelo=@Modelo where IdUser=@IdUser
end


GO
/****** Object:  StoredProcedure [dbo].[UpdateRecargoTarjetaById]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[UpdateRecargoTarjetaById](@IdTarjeta bigint, @Recargo decimal(18,2))
as
begin
update Tarjetas set Recargo=@Recargo where Id=@IdTarjeta
end

GO
/****** Object:  StoredProcedure [dbo].[updateStockTratamientoCantidad]    Script Date: 29/06/2019 1:48:17 ******/
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
/****** Object:  StoredProcedure [dbo].[UpdateVendedor]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateVendedor] (@IdUser bigint, @IdVendedor bigint, @NombreVendedor varchar(255), @Porcentaje decimal(18,4))
as
begin
update Vendedores set NombreVendedor=@NombreVendedor, PorcentajeComision=@Porcentaje where IdUser=@IdUser and Id=@IdVendedor
end


GO
/****** Object:  Table [dbo].[AgendaTurnos]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AgendaTurnos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DateReservacion] [datetime] NOT NULL,
	[IdCliente] [bigint] NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
	[IdUnico] [varchar](50) NULL,
	[IdBox] [bigint] NULL,
	[Asignado] [varchar](10) NULL,
 CONSTRAINT [PK_AgendaTurnos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ArqueosDeCaja]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ArqueosDeCaja](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdLocal] [bigint] NOT NULL,
	[Total] [decimal](18, 2) NULL,
	[Fecha] [datetime] NULL,
	[Anotaciones] [varchar](255) NOT NULL,
 CONSTRAINT [PK_ArqueosDeCaja] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Articulos]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Articulos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NULL,
	[IdProveedor] [bigint] NULL,
	[CodigoInterno] [varchar](50) NULL,
	[CodigoBarra] [varchar](50) NULL,
	[Descripcion] [varchar](255) NULL,
	[PrecioNeto] [decimal](18, 4) NULL,
	[IVA] [decimal](18, 4) NULL,
	[PrecioCompra] [decimal](18, 4) NULL,
	[PorcentajeGanancia] [decimal](18, 4) NULL,
	[PrecioFinal] [decimal](18, 4) NULL,
	[IdUnidad] [bigint] NULL,
	[CantidadINT] [bigint] NULL,
	[CantidadDEC] [decimal](18, 4) NULL,
	[Padre] [bit] NULL,
	[ArticuloPadre] [bigint] NULL,
 CONSTRAINT [PK_Articulos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Boxes]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Boxes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdSucursal] [bigint] NOT NULL,
	[Detalle] [varchar](50) NOT NULL,
	[IdProfesional] [bigint] NOT NULL,
 CONSTRAINT [PK_Boxes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CategoriaAFIP]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CategoriaAFIP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdCategoriaAFIP] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_TipoCategoriaAFIP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_CategoriaAFIP] UNIQUE NONCLUSTERED 
(
	[IdCategoriaAFIP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Clientes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[RazonSocial] [varchar](150) NOT NULL,
	[DNI_CUIT_CUIL] [varchar](100) NOT NULL,
	[Pais] [varchar](100) NOT NULL,
	[Provincia] [varchar](100) NOT NULL,
	[Localidad] [varchar](100) NOT NULL,
	[Domicilio] [varchar](100) NOT NULL,
	[Observaciones] [text] NOT NULL,
	[TipoIva] [varchar](100) NOT NULL,
	[Descuento] [decimal](18, 4) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[LimiteDeCredito] [decimal](18, 4) NOT NULL,
	[Suspendida] [bit] NOT NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ColorCodes]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ColorCodes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[colorcode] [varchar](8) NOT NULL,
 CONSTRAINT [PK_ColorCodes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DetallesFacturas]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesFacturas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdFactura] [bigint] NOT NULL,
	[IdArticulo] [bigint] NOT NULL,
	[PrecioNeto] [decimal](18, 4) NOT NULL,
	[IVA] [decimal](18, 4) NOT NULL,
	[PrecioCompra] [decimal](18, 4) NOT NULL,
	[PorcentajeGanancia] [decimal](18, 4) NOT NULL,
	[PrecioFinal] [decimal](18, 4) NOT NULL,
	[CantidadINT] [bigint] NOT NULL,
	[CantidadDEC] [decimal](18, 4) NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
 CONSTRAINT [PK_DetallesFacturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DetallesRemitos]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallesRemitos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdRemito] [bigint] NOT NULL,
	[IdArticulo] [bigint] NOT NULL,
	[Costo] [decimal](18, 4) NOT NULL,
	[CantDEC] [decimal](18, 4) NOT NULL,
	[CantINT] [bigint] NOT NULL,
	[Total] [decimal](18, 4) NOT NULL,
 CONSTRAINT [PK_DetallesRemitos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Empleados_Local]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados_Local](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[LocalID] [bigint] NOT NULL,
 CONSTRAINT [PK_Empleados_Local] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facturas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[SerialAFIP] [varchar](255) NOT NULL,
	[SerialTICKET] [varchar](255) NOT NULL,
	[Printed] [bit] NOT NULL,
	[PrintAgain] [bit] NOT NULL,
	[Transmitida] [bit] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Tipo] [varchar](5) NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[Domicilio] [varchar](255) NOT NULL,
	[Telefono] [varchar](255) NOT NULL,
	[Localidad] [varchar](255) NOT NULL,
	[Cuit] [varchar](255) NOT NULL,
	[RepInsc] [bit] NOT NULL,
	[RespNoInsc] [bit] NOT NULL,
	[Exento] [bit] NOT NULL,
	[ConsumidorFinal] [bit] NOT NULL,
	[RespMonotributo] [bit] NOT NULL,
	[Contado] [bit] NOT NULL,
	[CtaCte] [bit] NOT NULL,
	[IdCtaCte] [bigint] NOT NULL,
	[Cheque] [bit] NOT NULL,
	[Dni] [varchar](255) NOT NULL,
	[Tarjeta] [bit] NOT NULL,
	[Idtargeta] [bigint] NOT NULL,
	[NumeroTarjeta] [varchar](50) NOT NULL,
	[Observaciones] [text] NOT NULL,
	[SubTotal] [decimal](18, 4) NULL,
	[Ivas] [bit] NULL,
	[Total] [decimal](18, 4) NULL,
 CONSTRAINT [PK_Facturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovimientoClientes]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovimientoClientes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdCliente] [bigint] NOT NULL,
	[TipoMovimiento] [varchar](3) NOT NULL,
	[Importe] [decimal](18, 4) NOT NULL,
	[IdFactura] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[IdLocal] [bigint] NULL,
 CONSTRAINT [PK_MovimientoClientes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pagos]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Pagos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdSeller] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[Detalle] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Pagos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrintAction]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrintAction](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[PrintAction] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PrintAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrintConfiguration]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrintConfiguration](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[Puerto] [varchar](6) NOT NULL,
	[Baudios] [bigint] NOT NULL,
	[Modelo] [varchar](50) NOT NULL,
 CONSTRAINT [PK_PrintConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PrintersKeys]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PrintersKeys](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Iduser] [bigint] NOT NULL,
	[Printer] [varchar](255) NOT NULL,
	[PrivateKey] [varchar](255) NOT NULL,
 CONSTRAINT [PK_PrintersKeys] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Provincia](
	[Id] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_Provincia] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Remitos]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Remitos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdProveedor] [bigint] NOT NULL,
	[NroRemito] [varchar](100) NULL,
	[Fecha] [date] NOT NULL,
	[Total] [decimal](18, 4) NOT NULL,
 CONSTRAINT [PK_Remitos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Retiros]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Retiros](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdSeller] [bigint] NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Monto] [decimal](18, 2) NOT NULL,
	[Detalle] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Retiros] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sesiones]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sesiones](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Monto] [decimal](18, 4) NOT NULL,
	[Costo] [decimal](18, 4) NOT NULL,
	[Descripcion] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Sesiones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StockAlertaProductos]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockAlertaProductos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Producto] [int] NULL,
	[Stock_Minimo] [decimal](18, 0) NULL,
 CONSTRAINT [PK_StockAlertaProductos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockAlertaUsuariosANotificar]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockAlertaUsuariosANotificar](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Id_Usuario] [int] NOT NULL,
 CONSTRAINT [PK_StockAlertaUsuariosANotificar] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockTratamiento]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockTratamiento](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdArticulo] [bigint] NOT NULL,
	[CanINT] [bigint] NOT NULL,
	[CantDEC] [decimal](18, 4) NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
 CONSTRAINT [PK_StockAgregado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockTratamientoConsumido]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockTratamientoConsumido](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdArticulo] [bigint] NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
	[FechaConsumido] [datetime] NOT NULL,
 CONSTRAINT [PK_StockTratamientoConsumido] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sucursales]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sucursales](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[NombreLocal] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Sucursales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Supplier](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[Nombre] [varchar](255) NOT NULL,
	[NombreFantasía] [varchar](255) NOT NULL,
	[País] [bigint] NOT NULL,
	[Provincia] [bigint] NOT NULL,
	[Localidad] [varchar](100) NOT NULL,
	[Domicilio] [varchar](100) NOT NULL,
	[Teléfono1] [varchar](100) NOT NULL,
	[Teléfono2] [varchar](100) NOT NULL,
	[MailContacto] [varchar](50) NOT NULL,
	[MailPedidos] [varchar](50) NOT NULL,
	[IdCategoriaAfip] [bigint] NOT NULL,
	[NroIngresosBrutos] [varchar](50) NOT NULL,
	[IdTipoDocumento] [bigint] NOT NULL,
	[NroDocumento] [varchar](50) NOT NULL,
	[Detalle] [varchar](50) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tarjetas]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tarjetas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdLocal] [bigint] NOT NULL,
	[Recargo] [decimal](18, 2) NOT NULL,
	[NombreTarjeta] [varchar](50) NOT NULL,
	[Available] [bit] NOT NULL,
	[RutaDeImagen] [varchar](250) NULL,
 CONSTRAINT [PK_Tarjetas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoDocumento]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoDocumento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdTipoDocumento] [int] NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_TipoDocumento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_TipoDocumento] UNIQUE NONCLUSTERED 
(
	[IdTipoDocumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Treatment]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Treatment](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Precio] [decimal](18, 4) NOT NULL,
	[FechaCreacion] [date] NOT NULL,
	[FechaCaducidad] [date] NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[Allowed] [bit] NOT NULL,
	[UserId] [bigint] NULL,
 CONSTRAINT [PK_Treatment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UnidadesMedidas]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UnidadesMedidas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NULL,
	[Simbolo] [varchar](50) NULL,
	[DisplaySimbol] [float] NULL,
	[Decimal] [float] NULL,
 CONSTRAINT [PK_UnidadesMedidas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserConfiguration]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserConfiguration](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[NombreNegocio] [varchar](200) NOT NULL,
	[MostrarLogoNegocio] [bit] NOT NULL,
	[FacturaPorDefecto] [varchar](2) NOT NULL,
	[PIN] [varchar](5) NOT NULL,
	[Kiosco] [bit] NOT NULL,
 CONSTRAINT [PK_UserConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vendedores]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vendedores](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[NombreVendedor] [varchar](255) NOT NULL,
	[PorcentajeComision] [decimal](18, 4) NOT NULL,
	[Password] [varchar](8) NULL,
 CONSTRAINT [PK_Vendedores] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VendedoresYFacturas]    Script Date: 29/06/2019 1:48:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendedoresYFacturas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[IdUser] [bigint] NOT NULL,
	[IdSeller] [bigint] NOT NULL,
	[IdFactura] [bigint] NOT NULL,
 CONSTRAINT [PK_VendedoresYFacturas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[DetallesFacturas] ADD  DEFAULT ((0)) FOR [IdTratamiento]
GO
ALTER TABLE [dbo].[UserConfiguration] ADD  CONSTRAINT [DF_UserConfiguration_Kiosco]  DEFAULT ((0)) FOR [Kiosco]
GO
