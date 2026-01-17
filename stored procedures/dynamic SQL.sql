CREATE OR ALTER PROCEDURE dbo.sp_gettablecount_dynamicsql @tablename NVARCHAR(MAX)
AS 
BEGIN
	DECLARE @sql NVARCHAR(MAX) = '';

	SELECT @sql = 'SELECT COUNT(*) AS ' +  @tablename + '_count FROM ' + @tablename;
	EXEC sp_executesql @sql;
END;

GO

EXEC dbo.sp_gettablecount_dynamicsql @tablename = 'product';
