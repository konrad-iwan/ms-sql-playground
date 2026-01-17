CREATE TABLE product 
(
	id int identity(1,1) not null, 
	name nvarchar(100) not null, 
	description nvarchar(max),
    net decimal(18,2) not null,
	gross decimal(18,2) not null,
);

ALTER TABLE product ADD CONSTRAINT PK_product_id PRIMARY KEY (id);
