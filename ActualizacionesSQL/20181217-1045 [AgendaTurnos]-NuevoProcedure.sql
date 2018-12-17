USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaDate]    Script Date: 17/12/2018 10:44:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_DateAgendaDate](@Start datetime, @IdUsuario bigint, @IdBox bigint)
as
begin
select * from AgendaTurnos where IdUsuario=@IdUsuario and IdBox=@IdBox and DateReservacion=@Start
end
