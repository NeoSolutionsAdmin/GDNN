USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaById]    Script Date: 23/12/2018 18:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SELECT_DateAgendaByIdUnico](@IdUnico varchar(50))
as
begin
select * from AgendaTurnos Where IdUnico = @IdUnico
end
