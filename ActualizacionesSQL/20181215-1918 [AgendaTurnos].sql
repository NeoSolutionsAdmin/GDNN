Use Sistema
GO 

ALTER TABLE dbo.AgendaTurnos ADD
	Asignado varchar(10) NULL
GO
ALTER TABLE dbo.AgendaTurnos SET (LOCK_ESCALATION = TABLE)
GO