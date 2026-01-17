UPDATE oh
SET 
	oh.netvalue = (SELECT SUM(oi.net * oi.quantity) FROM order_item oi WHERE oi.orderid = oh.id)
   ,oh.grossvalue = (SELECT SUM(oi.net * oi.quantity) FROM order_item oi WHERE oi.orderid = oh.id)*1.23
FROM order_header oh 

UPDATE order_header 
SET netvalue = (SELECT SUM(net * quantity) FROM order_item oi WHERE oi.orderid = order_header.id),
grossvalue = (SELECT SUM(net * quantity) FROM order_item oi WHERE oi.orderid = order_header.id) * 1.23

SELECT * 
FROM 
order_header oh
WHERE oh.netvalue IS NOT NULL 

/*
DELETE oh
FROM 
order_header oh 
WHERE oh.id NOT IN (SELECT oi.orderid FROM order_item oi)
*/

select * 
from 
order_item oi 

UPDATE oh
SET 
    oh.netvalue = oi_sums.total_net,
    oh.grossvalue = oi_sums.total_net * 1.23
FROM order_header oh
INNER JOIN (
    SELECT orderid, SUM(net * quantity) as total_net
    FROM order_item
    GROUP BY orderid
) oi_sums ON oh.id = oi_sums.orderid

/*
delete from order_item; 
delete from order_header;
*/