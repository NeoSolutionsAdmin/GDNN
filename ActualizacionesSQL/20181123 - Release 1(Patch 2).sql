USE [Sistema]
GO
/****** Object:  StoredProcedure [dbo].[INSERT_TARJETA]    Script Date: 12/06/2018 01:34:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_TARJETA](@Idlocal bigint, @Recargo decimal(18,2), @NombreTarjeta varchar(50))
as
begin
  insert into Tarjetas(IdLocal, Recargo, NombreTarjeta,Available) values (@IdLocal,@Recargo,@NombreTarjeta,1)
end