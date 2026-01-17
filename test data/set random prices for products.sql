--random price between 1000 and 5000, dividible by 10
;with cte as 
(
	select marka + ' ' + model AS name, marka, CEILING(100 + ABS(CHECKSUM(NEWID())) % 400) * 10 net
	from
	smartfony
)
insert into product (name, description, net, gross)
select cte.*, cte.net * 1.23 AS gross
from 
cte 

