USE [Sistema]
GO

/****** Object:  StoredProcedure [dbo].[getStockConsumidoByDates]    Script Date: 17/12/2018 17:22:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[getStockConsumidoByDates] (@IdUser bigint,@Fecha1 varchar(50), @Fecha2 varchar(50))
as
begin
select * from StockTratamientoConsumido where IdUser=@IdUser and FechaConsumido between convert (datetime, @Fecha1, 120) and convert (datetime, @Fecha2, 120)
end

GO


