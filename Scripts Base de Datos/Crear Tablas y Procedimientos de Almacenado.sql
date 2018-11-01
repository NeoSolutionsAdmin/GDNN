USE [Sistema]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Crear Tablas


USE [Sistema]
GO
/****** Object:  Table [dbo].[StockAlertaProductos]    Script Date: 01/11/2018 15:15:01 ******/
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
/****** Object:  Table [dbo].[StockAlertaUsuariosANotificar]    Script Date: 01/11/2018 15:15:01 ******/
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

-- Crear Procedimientos de Almacenado


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


