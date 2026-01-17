CREATE TABLE order_item 
(
	id int identity(1,1) not null,
	orderid int not null,
	quantity int not null,
	net decimal(18,2) not null,
	gross decimal(18,2) not null,
	productid int not null, 
	name nvarchar(100) not null
);

ALTER TABLE order_item ADD CONSTRAINT PK_order_item_id PRIMARY KEY (id);

ALTER TABLE order_item ADD CONSTRAINT FK_orderitem_orderheader_id FOREIGN KEY (orderid) REFERENCES order_header(id);
