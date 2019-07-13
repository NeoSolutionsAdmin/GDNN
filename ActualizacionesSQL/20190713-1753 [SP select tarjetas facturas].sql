USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[SELECT_FACTURASBetweenDates]    Script Date: 13/07/2019 17:47:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE SELECT_Facturas_Tarjetas_betweenDates (@IdUser bigint, @FechaDesde varchar(255), @FechaHasta varchar(255))
as
begin

	select * from Facturas where IdUser=@IdUser and Fecha Between CONVERT(datetime,@FechaDesde,120) and CONVERT(datetime,@FechaHasta,120) and Tarjeta = 1

end