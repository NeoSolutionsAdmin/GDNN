USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Delete_SesionById]    Script Date: 10/11/2018 17:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Delete_SesionById] (@Id bigint)
as
begin
delete from Sesiones
where IdTratamiento=@Id
end
