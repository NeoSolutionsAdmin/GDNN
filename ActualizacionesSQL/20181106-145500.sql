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


