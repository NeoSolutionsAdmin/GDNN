USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Get_BoxById]   Script Date: 08/12/2018 18:17:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Get_BoxById](@Id bigint)
as
begin
select * from Boxes where Id=@Id 
end


