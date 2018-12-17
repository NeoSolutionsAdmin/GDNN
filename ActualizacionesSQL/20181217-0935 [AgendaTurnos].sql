use Sistema
GO

ALTER TABLE dbo.AgendaTurnos
	DROP COLUMN Asignado
GO

ALTER TABLE dbo.AgendaTurnos SET (LOCK_ESCALATION = TABLE)
GO