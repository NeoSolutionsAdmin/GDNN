Use Sistema
Go
CREATE PROCEDURE GetTreatmentsBySucursal (@UserId bigint)
AS
BEGIN
select * from Treatment where UserId = @UserId

END
GO
