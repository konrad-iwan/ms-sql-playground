--trigger DML

CREATE OR ALTER TRIGGER dbo.tgProduct_ins
ON dbo.product 
AFTER INSERT
AS
BEGIN
	INSERT INTO product_history (productid, name, description, net, gross, operationtype)
	SELECT id, name, description, net, gross, 'I'
	FROM
	inserted;
END;

GO

CREATE OR ALTER TRIGGER dbo.tgProduct_upd
ON dbo.product 
AFTER UPDATE
AS
BEGIN
	INSERT INTO product_history (productid, name, description, net, gross, operationtype)
	SELECT id, name, description, net, gross, 'U'
	FROM
	inserted;
END;

GO

CREATE OR ALTER TRIGGER dbo.tgProduct_del
ON dbo.product 
AFTER DELETE
AS
BEGIN
	INSERT INTO product_history (productid, name, description, net, gross, operationtype)
	SELECT id, name, description, net, gross, 'D'
	FROM
	deleted;
END;

--stworzyc tabelke z historia produktu 
CREATE TABLE product_history
(
	id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	productid INT NOT NULL, 
	name nvarchar(100) NOT NULL,
	description nvarchar(max),
	net decimal(18,2) NOT NULL,
	gross decimal(18,2) NOT NULL,
	changedate datetime NOT NULL DEFAULT (GETDATE()),
	operationtype NVARCHAR(1) NOT NULL,
	currentuser NVARCHAR(MAX) NOT NULL DEFAULT (CURRENT_USER)
);

INSERT INTO product(name, description, net, gross)
SELECT 'Motrola X88','Produkt z literowk¹',1000,1230;

UPDATE p
SET p.name = 'Motorola X88' 
FROM product p 
WHERE p.name = 'Motrola X88';

DELETE p 
FROM 
product p 
WHERE p.name = 'Motorola X88';

SELECT * FROM product_history; 

