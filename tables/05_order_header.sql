CREATE TABLE order_header 
(
	id int identity(1,1) not null, 
	createdate datetime not null,
	userloginid int not null,
	netvalue decimal(18,2),
	grossvalue decimal(18,2)
);

ALTER TABLE order_header ADD CONSTRAINT PK_order_header_id PRIMARY KEY (id);

ALTER TABLE order_header ADD CONSTRAINT FK_order_userlogin_id FOREIGN KEY (userloginid) REFERENCES userlogin(id);

ALTER TABLE order_header ADD CONSTRAINT DF_order_createdate DEFAULT GETDATE() FOR createdate;
