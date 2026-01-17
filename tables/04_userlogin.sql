
CREATE TABLE userlogin
(
	id int identity(1,1) not null, 
	login nvarchar(100) not null,
	password nvarchar(100) not null,
	email nvarchar(100) not null
);

ALTER TABLE userlogin ADD CONSTRAINT PK_userlogin_id PRIMARY KEY (id);