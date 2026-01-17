CREATE OR ALTER FUNCTION dbo.tvf_orders_by_months_lag(@mindate datetime, @maxdate datetime)
RETURNS TABLE AS 
RETURN
WITH CTE AS
(
	SELECT 
		YEAR(oh.createdate) year, 
		MONTH(oh.createdate) month, 
		FORMAT(oh.createdate, 'yyyy-MM') yearmonth, 
		SUM(oh.netvalue) AS netvalue, 
		SUM(oh.grossvalue) AS grossvalue
	FROM 
		dbo.order_header oh 
	WHERE oh.createdate >= @mindate AND oh.createdate < @maxdate
	GROUP BY 
		YEAR(oh.createdate), MONTH(oh.createdate), FORMAT(oh.createdate, 'yyyy-MM')
)
SELECT 
	CTE.*, 
	ISNULL(LAG(CTE.netvalue, 1) OVER (ORDER BY year, month),0) AS previousmonth_netvalue,
	ISNULL(LAG(CTE.grossvalue, 1) OVER (ORDER BY year, month),0) AS previousmonth_grossvalue,
	ISNULL(CTE.netvalue - LAG(CTE.netvalue, 1) OVER (ORDER BY year, month),0) AS diff_previousmonth_netvalue,
	ISNULL(CTE.grossvalue - LAG(CTE.grossvalue, 1) OVER (ORDER BY year, month),0) AS diff_previousmonth_grossvalue
FROM
CTE;
GO

SELECT * 
FROM 
dbo.tvf_orders_by_months_lag('2025-01-01','2026-01-01');
GO;



