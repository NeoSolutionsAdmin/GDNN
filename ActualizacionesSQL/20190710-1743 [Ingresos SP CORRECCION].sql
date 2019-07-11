USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[Insert_Ingreso]    Script Date: 10/07/2019 17:27:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[Insert_Ingreso](@IdLocal bigint, @Monto Decimal(18,2), @Detalle varchar(250), @Fecha varchar(50))
as
begin
Insert into Ingresos(IdLocal,Monto,Detalle,Fecha) values (@IdLocal,@Monto,@Detalle,@Fecha)
end
