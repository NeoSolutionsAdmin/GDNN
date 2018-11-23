USE [Sistema]
GO

/****** Object:  Table [dbo].[Empleados_Local]    Script Date: 05/11/2018 18:06:18 ******/
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


USE [Sistema]
GO

/****** Object:  Table [dbo].[Sucursales]    Script Date: 05/11/2018 18:06:48 ******/
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

ALTER TABLE Treatment
ADD UserId bigint;

GO

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Search_Tratamiento]    Script Date: 02/11/2018 16:34:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Search_Tratamiento](@LocalId bigint, @cadenadebusqueda varchar(50))
as
begin
select * from Treatment where Nombre like '%' + @cadenadebusqueda + '%' and UserId = @LocalId
end
GO

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Insert_Treatment]    Script Date: 02/11/2018 15:54:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Insert_Treatment] (@UserId bigint, @Nombre varchar(50),@Precio decimal(18,4), @FechaCreacion date, @FechaCaducidad date, @Descripcion varchar(200), @Allowed bit)
as
begin
insert into Treatment(UserId,Nombre,Precio,FechaCreacion,FechaCaducidad,Descripcion,Allowed) values(@UserId,@Nombre,@Precio,@FechaCreacion,@FechaCaducidad,@Descripcion,@Allowed)
end

GO
alter table DetallesFacturas add IdTratamiento bigint
GO
CREATE PROCEDURE GetTreatmentsBySucursal (@UserId bigint)
AS
BEGIN
select * from Treatment where UserId = @UserId

END
GO
create procedure searchLocales (@stringBusqueda varchar(50))
as
begin
select * from Sucursales where NombreLocal like '%' + @stringBusqueda + '%'
end
USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[ObtenerLocal]    Script Date: 06/11/2018 14:54:34 ******/
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


USE [Sistema]
GO

/****** Object:  Table [dbo].[StockAlertaProductos]    Script Date: 08/11/2018 18:29:40 ******/
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

USE [Sistema]
GO

/****** Object:  Table [dbo].[StockAlertaUsuariosANotificar]    Script Date: 08/11/2018 18:29:55 ******/
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

USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[AgregarProductoConAlertaDeStock]    Script Date: 08/11/2018 19:01:15 ******/
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
USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[AgregarUserParaAlertar]    Script Date: 08/11/2018 19:01:27 ******/
DROP PROCEDURE [dbo].[AgregarUserParaAlertar]
GO

/****** Object:  StoredProcedure [dbo].[AgregarUserParaAlertar]    Script Date: 08/11/2018 19:01:27 ******/
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
USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[BorrarProductoConAlerta]    Script Date: 08/11/2018 19:01:43 ******/
DROP PROCEDURE [dbo].[BorrarProductoConAlerta]
GO

/****** Object:  StoredProcedure [dbo].[BorrarProductoConAlerta]    Script Date: 08/11/2018 19:01:43 ******/
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
USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[BorrarUserParaAlertar]    Script Date: 08/11/2018 19:01:58 ******/
DROP PROCEDURE [dbo].[BorrarUserParaAlertar]
GO

/****** Object:  StoredProcedure [dbo].[BorrarUserParaAlertar]    Script Date: 08/11/2018 19:01:58 ******/
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
USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[RecuperarProductosConAlertaDeStock]    Script Date: 08/11/2018 19:02:22 ******/
DROP PROCEDURE [dbo].[RecuperarProductosConAlertaDeStock]
GO

/****** Object:  StoredProcedure [dbo].[RecuperarProductosConAlertaDeStock]    Script Date: 08/11/2018 19:02:22 ******/
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
USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[ModificarProductoConAlertaDeStock]    Script Date: 08/11/2018 19:02:34 ******/
DROP PROCEDURE [dbo].[ModificarProductoConAlertaDeStock]
GO

/****** Object:  StoredProcedure [dbo].[ModificarProductoConAlertaDeStock]    Script Date: 08/11/2018 19:02:34 ******/
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
USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[RecuperarUsuariosParaAlertar]    Script Date: 08/11/2018 19:02:47 ******/
DROP PROCEDURE [dbo].[RecuperarUsuariosParaAlertar]
GO

/****** Object:  StoredProcedure [dbo].[RecuperarUsuariosParaAlertar]    Script Date: 08/11/2018 19:02:47 ******/
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


USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Delete_SesionById]    Script Date: 10/11/2018 17:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Delete_SesionById] (@Id bigint)
as
begin
delete from Sesiones
where IdTratamiento=@Id
end
USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[GetTreatmentsBySucursal]    Script Date: 10/11/2018 17:49:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetTreatmentsBySucursal] (@UserId bigint)
AS
BEGIN
select * from Treatment where UserId = @UserId

END
Create Procedure GetArticleById(@ID bigint)
as
begin
Select * from Articulos where Id=@ID
end
USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[RecuperarProductosConAlertaDeStock]    Script Date: 11/11/2018 4:17:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[RecuperarProductosConAlertaDeStock] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM StockAlertaProductos
END

CREATE PROCEDURE INSERT_TARJETA(@Idlocal bigint, @Recargo decimal(18,2), @NombreTarjeta varchar(50))
as
begin
	insert into Tarjeta(IdLocal, Recargo, NombreTarjeta,Available) values (@IdLocal,@Recargo,@NombreTarjeta,1)
end

/*
   Tuesday, November 13, 20183:33:18 AM
   Usuario: sa
   Servidor: .\SQLEXPRESS
   Base de datos: Sistema
   Aplicación: 
*/
Use Sistema
GO
/* Para evitar posibles problemas de pérdida de datos, debe revisar este script detalladamente antes de ejecutarlo fuera del contexto del diseñador de base de datos.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tarjetas
	(
	Id bigint NOT NULL IDENTITY (1, 1),
	IdLocal bigint NOT NULL,
	Recargo decimal(18, 2) NOT NULL,
	NombreTarjeta varchar(50) NOT NULL,
	Available bit NOT NULL,
	RutaDeImagen varchar(250) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tarjetas ADD CONSTRAINT
	PK_Tarjetas PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Tarjetas SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO
CREATE PROCEDURE GetAllTarjetasByIdLocal(@idLocal bigint)
as
begin
select * from Tarjetas where IdLocal=@idLocal
end
go
Create Procedure GetTarjetaById(@IdTarjeta bigint)
as
begin
select * from Tarjetas where Id=@IdTarjeta
end
go
Create Procedure UpdateRecargoTarjetaById(@IdTarjeta bigint, @Recargo decimal(18,2))
as
begin
update Tarjetas set Recargo=@Recargo where Id=@IdTarjeta
end
go
Create Procedure UpdateAvailabilityTarjetaById(@IdTarjeta bigint, @State bit)
as
begin
update Tarjetas set Available=@State where Id=@IdTarjeta
end
go
Create Procedure UpdateNombreTarjetaById(@IdTarjeta bigint, @Nombre varchar(50))
as
begin
update Tarjetas set NombreTarjeta=@Nombre where Id=@IdTarjeta
end
go
Create Procedure GetAvailableTarjetasByIdLocal(@IdLocal bigint)
as
begin
select * from Tarjetas where IdLocal=@IdLocal and Available=1
end
go

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Insert_MovimientoCliente]    Script Date: 11/20/2018 11:18:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Insert_MovimientoCliente](
@IdCliente bigint,
@TipoMovimiento varchar(3),
@Importe decimal(18,4),
@IdFactura bigint,
@Date varchar(100))
as
begin
insert into MovimientoClientes(
IdCliente,
TipoMovimiento,
Importe,
IdFactura,
Fecha
) values(@IdCliente,@TipoMovimiento,@Importe,@IdFactura,convert(datetime,@Date,120))
end

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[GetDetalleFactura]    Script Date: 11/21/2018 11:16:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[GetDetalleFactura](@IdFactura bigint, @IdUser bigint)
as

begin
select * from DetallesFacturas where IdFactura=@IdFactura 
end


