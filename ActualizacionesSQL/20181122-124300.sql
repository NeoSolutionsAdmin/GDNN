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

