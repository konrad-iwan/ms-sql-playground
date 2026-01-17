CREATE FUNCTION dbo.fn_clientWithMostOrders()
RETURNS NVARCHAR(MAX)
AS BEGIN
	DECLARE @id INT, @txt NVARCHAR(MAX);

	SELECT @id = 
	(SELECT TOP 1 oh.userloginid 
	FROM
	dbo.order_header oh 
	GROUP BY oh.userloginid
	ORDER BY COUNT(*) DESC);

	SELECT @txt =
	(
		SELECT ul.login + ' (id = ' + CONVERT(NVARCHAR(MAX), ul.id) + ', email = ' + ul.email + ')'
		FROM 
		dbo.userlogin ul 
		WHERE ul.id = @id
	);

	RETURN @txt; 
END;

SELECT dbo.fn_clientWithMostOrders();

