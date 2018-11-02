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
