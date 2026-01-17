CREATE OR ALTER PROCEDURE [dbo].[usp_add_random_orders] @year int, @quantity int = 100
AS 
BEGIN
SET NOCOUNT ON;

IF (@year NOT BETWEEN 1900 AND 9999)
BEGIN
	PRINT 'wrong @year value';
	RETURN;
END;

DECLARE @i INT, @j INT;
DECLARE @ids TABLE (id int);

SET @i = 0;
WHILE @i < @quantity 
    BEGIN
		INSERT INTO order_header (createdate, userloginid, netvalue, grossvalue)
		OUTPUT inserted.id INTO @ids
		SELECT DATEADD(DAY,(FLOOR(364 * RAND())),CONVERT(DATETIME,(CONVERT(NVARCHAR(MAX),@year) + '-01-01'))) AS createdate,
		(SELECT TOP 1 ul.id FROM userlogin ul ORDER BY NEWID()) AS userloginid,
		0 AS netvalue,
		0 AS grossvalue;

		SELECT @j = CEILING(3 * RAND());
		WHILE(@j > 0)
		BEGIN
			INSERT INTO order_item(orderid, quantity, net, gross, productid, name)
			SELECT TOP 1 
				(SELECT TOP 1 id FROM @ids) AS orderid,
				CEILING(5 * RAND()) AS quantity,
				p.net, 
				p.gross,
				p.id, 
				p.name 
			FROM	
				product p
			ORDER BY NEWID();

			SELECT @j = @j - 1;
		END;	
		DELETE FROM @ids;

		SELECT @i = @i + 1; 	
    END;
	
END; 
GO

-----select * from order_item

SELECT * FROM order_header oh
--DELETE FROM order_header 
SELECT *
FROM
order_header oh 
JOIN order_item oi ON oi.orderid = oh.id 


EXEC dbo.usp_add_random_orders @year = 2025, @quantity = 1000; 


SELECT DATEADD(DAY,200, CONVERT(DATETIME,(CONVERT(NVARCHAR(MAX),'2025') + '-01-01')))


select floor(rand() * 10)


DECLARE @Constant AS INT;
SET @Constant = 10;

SELECT ROUND(@Constant * RAND(), 0) AS FirstRandomInteger,
       FLOOR(@Constant * RAND()) AS SecondRandomInteger,
       CEILING(@Constant * RAND()) AS ThirdRandomInteger;
GO

SELECT FLOOR(364 * RAND())

UPDATE oh
SET 
	oh.netvalue = (SELECT SUM(oi.net * oi.quantity) FROM order_item oi WHERE oi.orderid = oh.id)
   ,oh.grossvalue = (SELECT SUM(oi.net * oi.quantity) FROM order_item oi WHERE oi.orderid = oh.id)*1.23
FROM order_header oh 

