USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaById]    Script Date: 12/12/2018 4:42:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SELECT_DateAgendaById](@Id bigint)
as
begin
select * from AgendaTurnos Where Id=@Id
end
