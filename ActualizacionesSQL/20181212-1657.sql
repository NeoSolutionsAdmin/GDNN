Use Sistema
GO

ALTER TABLE dbo.Supplier ADD
	Detalle varchar(50) NULL
GO
ALTER TABLE dbo.Supplier SET (LOCK_ESCALATION = TABLE)
GO