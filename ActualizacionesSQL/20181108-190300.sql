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











