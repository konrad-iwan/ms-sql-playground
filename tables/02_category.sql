CREATE TABLE category 
(
	id int identity(1,1) primary key not null, 
	name nvarchar(100) not null,
	parentid int null
);

ALTER TABLE category ADD CONSTRAINT PK_category_id PRIMARY KEY (id);

ALTER TABLE category
ADD CONSTRAINT FK_category_parentid_category_id FOREIGN KEY (parentid) REFERENCES category (id);
