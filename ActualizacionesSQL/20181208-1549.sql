USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[GetBoxesBySucursal]    Script Date: 08/12/2018 15:47:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetBoxesBySucursal] (@IdSucursal bigint)
AS
BEGIN
select * from Boxes where IdSucursal = @IdSucursal

END
