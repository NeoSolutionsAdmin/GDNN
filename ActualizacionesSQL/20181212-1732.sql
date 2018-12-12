USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[AgregarUserParaAlertar]    Script Date: 12/12/2018 5:31:10 PM ******/
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

/****** Object:  StoredProcedure [dbo].[AgregarProductoConAlertaDeStock]    Script Date: 12/12/2018 5:31:24 PM ******/
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

/****** Object:  StoredProcedure [dbo].[RecuperarUsuariosParaAlertar]    Script Date: 12/12/2018 5:31:39 PM ******/
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

/****** Object:  StoredProcedure [dbo].[ModificarProductoConAlertaDeStock]    Script Date: 12/12/2018 5:31:52 PM ******/
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

/****** Object:  StoredProcedure [dbo].[RecuperarProductosConAlertaDeStock]    Script Date: 12/12/2018 5:32:05 PM ******/
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




