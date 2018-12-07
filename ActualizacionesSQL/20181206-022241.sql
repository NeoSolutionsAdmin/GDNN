USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_DateAgenda]    Script Date: 07/12/2018 2:12:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/* Creacion de procesos de almacenado */
ALTER PROCEDURE [dbo].[INSERT_DateAgenda](@dateReservacion datetime, @IdCliente bigint, @IdUsuario bigint, @IdTratamiento bigint, @Estado varchar(20), @IdBox bigint)
as
begin
	insert into AgendaTurnos (DateReservacion,IdCliente,IdUsuario,IdTratamiento,Estado,IdBox) values (@dateReservacion,@IdCliente,@IdUsuario,@IdTratamiento,@Estado,@IdBox)
end
