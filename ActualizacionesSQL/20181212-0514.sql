USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[BorrarProductoConAlerta]    Script Date: 12/12/2018 5:14:16 PM ******/
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

/****** Object:  StoredProcedure [dbo].[BorrarUserParaAlertar]    Script Date: 12/12/2018 5:14:25 PM ******/
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

