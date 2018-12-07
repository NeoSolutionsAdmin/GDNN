USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaBetweenDate]    Script Date: 07/12/2018 2:26:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[SELECT_DateAgendaBetweenDate](@Start datetime, @End datetime, @IdUsuario bigint, @IdBox bigint)
as
begin
select * from AgendaTurnos where IdUsuario=@IdUsuario and IdBox=@IdBox and DateReservacion between @Start and @End
end
