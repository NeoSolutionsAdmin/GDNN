USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[CANCEL_DateAgenda]    Script Date: 06/12/2018 2:05:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CANCEL_DateAgenda](@idTurno bigint)
as
begin
delete AgendaTurnos where Id=@idTurno
end

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaBetweenDate]    Script Date: 06/12/2018 2:08:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_DateAgendaBetweenDate](@Start datetime, @End datetime, @IdUsuario bigint)
as
begin
select * from AgendaTurnos where IdUsuario=@IdUsuario and DateReservacion between @Start and @End
end

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaById]    Script Date: 06/12/2018 2:08:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_DateAgendaById](@Id bigint)
as
begin
select * from AgendaTurnos Where Id=@id
end

USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_DateAgendaByIdCliente]    Script Date: 06/12/2018 2:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SELECT_DateAgendaByIdCliente](@IdUser bigint, @IdCliente bigint)
as
begin 
select * from AgendaTurnos where IdCliente=@IdCliente and IdUsuario=@IdUser;
end

