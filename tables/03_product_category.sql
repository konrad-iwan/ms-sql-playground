CREATE TABLE product_category 
(
	id INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
	productid INT NOT NULL,
	categoryid INT NOT NULL
);
GO

ALTER TABLE product_category ADD CONSTRAINT FK_product_category_category_id FOREIGN KEY (categoryid) REFERENCES category (id);
GO

ALTER TABLE product_category ADD CONSTRAINT FK_product_category_product_id FOREIGN KEY (productid) REFERENCES category (id);
GO