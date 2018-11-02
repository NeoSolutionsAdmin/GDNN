USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Insert_Treatment]    Script Date: 02/11/2018 15:54:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Insert_Treatment] (@UserId bigint, @Nombre varchar(50),@Precio decimal(18,4), @FechaCreacion date, @FechaCaducidad date, @Descripcion varchar(200), @Allowed bit)
as
begin
insert into Treatment(UserId,Nombre,Precio,FechaCreacion,FechaCaducidad,Descripcion,Allowed) values(@UserId,@Nombre,@Precio,@FechaCreacion,@FechaCaducidad,@Descripcion,@Allowed)
end

