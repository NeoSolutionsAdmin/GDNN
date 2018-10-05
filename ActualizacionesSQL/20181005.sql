/* [Sistema] Pertenece al nombre de la base de datos... cambiar de ser necesario */
USE [Sistema]
GO

/* Creacion de la tabla de reservaciones */
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AgendaTurnos](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DateReservacion] [datetime] NOT NULL,
	[IdCliente] [bigint] NOT NULL,
	[IdUsuario] [bigint] NOT NULL,
	[IdTratamiento] [bigint] NOT NULL,
	[Estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_AgendaTurnos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

/* Creacion de procesos de almacenado */
CREATE PROCEDURE INSERT_DateAgenda(@dateReservacion datetime, @IdCliente bigint, @IdUsuario bigint, @IdTratamiento bigint, @Estado varchar(20))
as
begin
	insert into AgendaTurnos (DateReservacion,IdCliente,IdUsuario,IdTratamiento,Estado) values (@dateReservacion,@IdCliente,@IdUsuario,@IdTratamiento,@Estado)
end
go
CREATE PROCEDURE SELECT_DateAgendaById(@Id bigint)
as
begin
select * from AgendaTurnos Where Id=@id
end
go
CREATE PROCEDURE SELECT_DateAgendaByIdCliente(@IdUser bigint, @IdCliente bigint)
as
begin 
select * from AgendaTurnos where IdCliente=@IdCliente and IdUsuario=@IdUser;
end
go
CREATE PROCEDURE SELECT_DateAgendaBetweenDate(@Start datetime, @End datetime, @IdUsuario bigint)
as
begin
select * from AgendaTurnos where IdUsuario=@IdUsuario and DateReservacion between @Start and @End
end
go
CREATE PROCEDURE CANCEL_DateAgenda(@idTurno bigint)
as
begin
delete AgendaTurnos where Id=@idTurno
end
go