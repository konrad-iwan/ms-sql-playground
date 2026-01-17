CREATE VIEW cte_orderNumbers AS 
WITH CTE AS 
(
	SELECT 
		oh.id, 
		oh.createdate,
		ROW_NUMBER() OVER (PARTITION BY YEAR(oh.createdate), MONTH(oh.createdate) ORDER BY oh.id) AS ordinalnumber,
		'Ord/' 
		+ CONVERT(NVARCHAR(MAX),YEAR(oh.createdate))
		+ '/'
		+ CONVERT(NVARCHAR(MAX),FORMAT(MONTH(oh.createdate),'00')) 
		+ '/'
		+ CONVERT(NVARCHAR(MAX), FORMAT(ROW_NUMBER() OVER (PARTITION BY YEAR(oh.createdate), MONTH(oh.createdate) ORDER BY oh.id),'000000')) AS  ordno
	FROM
	dbo.order_header oh 
)
SELECT CTE.*
FROM
CTE;

SELECT * FROM cte_orderNumbers; 

