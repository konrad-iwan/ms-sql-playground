-- dense rank vs rank 
CREATE TABLE #smartphone_rating 
(
	id int identity (1,1) primary key not null,
	brand nvarchar(max) not null,
	model nvarchar(max) not null,
	ranking numeric(18,2) not null
);

INSERT INTO #smartphone_rating (brand, model, ranking) 
SELECT 'iPhone', '17 PRO', 9.22 union all 
SELECT 'Samsung','S25 Ultra', 9.18 union all
SELECT 'Samsung', 'S25 FE', 8.99 union all 
SELECT 'Xiaomi', '18 ULTRA', 8.11 union all 
SELECT 'Motorola', 'G88', 8.11 union all 
SELECT 'Realme', 'C85 2026 edition', 7.45 union all 
SELECT 'Vivo', 'X22 Pro', 7.45 union all
SELECT 'OPPO', '625', 6.88 union all 
SELECT 'HTC', '625', 6.42;


SELECT 
	sr.*, 
	RANK() OVER (ORDER BY ranking DESC) AS rank,
	DENSE_RANK() OVER (ORDER BY ranking DESC) AS denserank
FROM 
#smartphone_rating sr 

DROP TABLE #smartphone_rating;

GO

