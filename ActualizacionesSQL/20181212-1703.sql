USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[update_Supplier]    Script Date: 12/12/2018 17:02:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[update_Supplier] 
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


