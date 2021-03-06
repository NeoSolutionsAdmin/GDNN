USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[insert_Supplier]    Script Date: 12/12/2018 16:49:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[insert_Supplier](
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


