
Use Sistema
Go
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Ingresos
	(
	Id bigint NOT NULL IDENTITY (1, 1),
	IdLocal bigint NOT NULL,
	Fecha Datetime not null,
	Monto decimal(18, 2) NULL,
	Detalle varchar(250) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Ingresos ADD CONSTRAINT
	PK_Ingresos PRIMARY KEY CLUSTERED 
	(
	Id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.Ingresos SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
GO

CREATE PROCEDURE Insert_Ingreso(@IdLocal bigint, @Monto Decimal(18,2), @Detalle varchar(250))
as
begin
Insert into Ingresos(IdLocal,Monto,Detalle) values (@IdLocal,@Monto,@Detalle)
end
GO
CREATE PROCEDURE Select_IngresosBetweenDates(@IdLocal bigint, @DateStart varchar(50), @DateEnd varchar(50))
as
begin
select * from Ingresos where IdLocal=@IdLocal and Fecha Between @DateStart and @DateEnd
end
go
