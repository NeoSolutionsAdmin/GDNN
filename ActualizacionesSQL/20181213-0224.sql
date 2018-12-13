USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Search_Tratamiento]    Script Date: 12/13/2018 2:23:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Search_Tratamiento](@LocalId bigint, @cadenadebusqueda varchar(50))
as
begin
select * from Treatment where Nombre like '%' + @cadenadebusqueda + '%' and UserId = @LocalId order by Nombre
end
