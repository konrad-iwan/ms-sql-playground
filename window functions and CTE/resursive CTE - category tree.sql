CREATE view categories_tree AS 
WITH cte_categories AS 
(
	SELECT c.*, 1 AS depth, CONVERT(nvarchar(100), NULL) AS parentname, CONVERT(nvarchar(max),'') AS path
	FROM
	category c
	WHERE c.parentid IS NULL 
	UNION ALL 
	SELECT c.*, cc.depth + 1 AS depth, cc.name AS parentname, cc.path + (CASE WHEN cc.path <> '' THEN ' / ' ELSE '' END) + c.name AS path
	FROM
	category c
	JOIN cte_categories cc ON cc.id = c.parentid 
)
SELECT *
FROM
cte_categories;

GO

SELECT *
FROM
categories_tree ct; 