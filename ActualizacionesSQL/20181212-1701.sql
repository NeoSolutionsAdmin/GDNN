USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[select_allSupliersNames]    Script Date: 12/12/2018 16:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[select_allSupliersNames](@IdUser bigint)
as
begin
select Supplier.Id, Supplier.Nombre, Supplier.NombreFantasía, Supplier.Detalle from Supplier where Supplier.IdUser=@IdUser
end


