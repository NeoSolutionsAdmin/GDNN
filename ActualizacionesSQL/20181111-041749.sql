Create Procedure GetArticleById(@ID bigint)
as
begin
Select * from Articulos where Id=@ID
end