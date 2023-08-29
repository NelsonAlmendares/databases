CREATE DATABASE [library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'library', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\library.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'library_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\library_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 WITH LEDGER = OFF
GO
USE [library]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [library] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

CREATE TABLE [client] (
	id_client INT NOT NULL IDENTITY (1,1),
	client_firstName VARCHAR (100) NOT NULL,
	client_lastName VARCHAR (100) NOT NULL,
	password_client VARCHAR (200) NOT NULL,
	client_phone VARCHAR (12) NOT NULL,
	client_document VARCHAR (11) NOT NULL,
	client_address TEXT NOT NULL,
	client_mail VARCHAR (200) NOT NULL,
	client_photo IMAGE,
	id_statusClient INT DEFAULT 1,
	CONSTRAINT uq_mail UNIQUE (client_mail),
	CONSTRAINT ck_documentClient CHECK (client_document LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]')),
	CONSTRAINT ck_phoneClient CHECK (client_phone LIKE ('[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	CONSTRAINT PK_client PRIMARY KEY (id_client)
);
GO

CREATE TABLE [employee] (
	id_employee INT NOT NULL IDENTITY (1,1),
	employee_firstName VARCHAR (100) NOT NULL,
	employee_lastName VARCHAR (100) NOT NULL,
	password_employee VARCHAR (200) NOT NULL,
	employee_address TEXT NOT NULL,
	employee_phone INT NOT NULL,
	employee_document INT NOT NULL,
	employee_mail VARCHAR (260) NOT NULL,
	employee_photo IMAGE,
	id_typeEmployee INT NOT NULL,
	id_statusEmployee INT NOT NULL,
	CONSTRAINT UK_mail UNIQUE (employee_mail),
	CONSTRAINT CK_documentEmplyee CHECK (employee_document LIKE ('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]')),
	CONSTRAINT CK_phoneEmployee CHECK (employee_phone LIKE ('[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	CONSTRAINT PK_employee PRIMARY KEY (id_employee)
);
GO

-- Insecciones de los Clientes
INSERT INTO [dbo].[client]
	([client_firstName]
	,[client_lastName]
	,[password_client]
	,[client_phone]
	,[client_document]
	,[client_address]
	,[client_mail]
	,[client_photo]
	,[id_statusClient])
VALUES ('Nelson',
	'Almendares',
	'123456',
	'7823-2312',
	'09821309-8',
	'Por la casita',
	'nelsonjose@gmail.com',
	'',
	1);
GO
SELECT * FROM client;

-- Tabla para las facturas
CREATE TABLE [bills] (
	id_bill INT NOT NULL IDENTITY (1,1),
	sale__correlative INT NOT NULL,
	quantity INT NOT NULL,
	date__issue DATE NOT NULL,
	comments VARCHAR (200) DEFAULT '',
	id_sale INT NOT NULL,
	id_client INT NOT NULL,
	CONSTRAINT PK_bill PRIMARY KEY (id_bill)
);
GO
SELECT * FROM [dbo].[bills];

-- Tabla de Ventas
CREATE TABLE [sales] (
	id_sales INT NOT NULL IDENTITY (1,1),
	sale_date DATE NOT NULL,
	sale_address TEXT NOT NULL,
	sale_total_due FLOAT NOT NULL,
	sale_type_payment INT NOT NULL,
	id_sale_purchaser INT NOT NULL,
	id_product INT NOT NULL,
	id_employee INT NOT NULL,
	CONSTRAINT PK_sales PRIMARY KEY (id_sales)
);
GO

-- Tabla principal de Productos
CREATE TABLE [products] (
	id_product INT NOT NULL IDENTITY (1,1),
	product_name VARCHAR (100) NOT NULL,
	product_price FLOAT NOT NULL,
	product_photo IMAGE,
	product_description TEXT NOT NULL,
	date_entry DATE,
	product_brand INT NOT NULL,
	id_productStatus INT NOT NULL,
	id_productDistributor INT NOT NULL,
	id_review INT NOT NULL,
	id_availability INT NOT NULL,
	CONSTRAINT PK_product PRIMARY KEY (id_product)
);
GO

-- Tabla para la especificación de los productos
CREATE TABLE [productSpecification] (
	id_productEspecification INT NOT NULL IDENTITY (1,1),
	product__quantity INT NOT NULL,
	product__author VARCHAR (200) NOT NULL,
	product__format VARCHAR (100) NOT NULL,
	product__themes VARCHAR (100) NOT NULL,
	id_productGender INT NOT NULL,
	id_clasification INT NOT NULL,
	id_product INT NOT NULL,
	CONSTRAINT PK_productSpecification PRIMARY KEY (id_productEspecification)
);
GO

-- Tabla para los generos de los libros
CREATE TABLE [gender] (
	id_gender INT NOT NULL IDENTITY (1,1),
	book__gender VARCHAR (100) NOT NULL,
	CONSTRAINT PK_gender PRIMARY KEY (id_gender)
);
GO

INSERT INTO [dbo].[gender]
	(book__gender)
	VALUES ('Narrativo');
	/* ------------ Subgéneros --------------
		-Novela
		-Cuento
		-Leyenda 
		-Poéma Épico
	*/
INSERT INTO [dbo].[gender]
	(book__gender)
	VALUES ('Lírico');
	/* ------------ Subgéneros --------------
		-Elegía
		-Oda
		-Sátira
		-Soneto
	*/
INSERT INTO [dbo].[gender]
	(book__gender)
	VALUES ('Dramático');
	/* ------------ Subgéneros --------------
		-Ensayo
		-Biografía
		-Carta
		-Discurso
		-Oratoria
		-Articulos Científicos 
	*/
INSERT INTO [dbo].[gender]
	(book__gender)
	VALUES ('Didáctico');
	/* ------------ Subgéneros --------------
		-Novela
		-Cuento
		-Leyenda 
		-Poéma Épico
	*/

-- Tabla de Distribuidores
CREATE TABLE [distributor] (
	id_distributor INT NOT NULL IDENTITY (1,1),
	name_distributor VARCHAR (200) NOT NULL,
	comments TEXT DEFAULT 'Sin comentarios',
	register DATE
	CONSTRAINT PK_distributot PRIMARY KEY (id_distributor)
);
GO

CREATE TABLE [availability] (
	id_availability INT NOT NULL IDENTITY (1,1),
	book__availability VARCHAR (100) NOT NULL,
	CONSTRAINT PK_availability PRIMARY KEY (id_availability)
);
GO

INSERT INTO [dbo].[availability]
	(book__availability)
	VALUES ('Inmediata');
INSERT INTO [dbo].[availability]
	(book__availability)
	VALUES ('Agotado');
INSERT INTO [dbo].[availability]
	(book__availability)
	VALUES ('Pocas existencias');
INSERT INTO [dbo].[availability]
	(book__availability)
	VALUES ('Ingresos');
SELECT id_availability AS ID, book__availability AS Disponibilidad FROM [dbo].[availability];

-- Tabla para las reseñas de los productos de la librería
CREATE TABLE [reviews] (
	id_review INT NOT NULL IDENTITY (1,1),
	name_client VARCHAR (100),
	register_date DATE
	CONSTRAINT PK_review PRIMARY KEY (id_review)
);

-- Tabla para la clasificación de los libros 
CREATE TABLE [clasification] (
	id_clasification INT NOT NULL IDENTITY (1,1),
	clasification__product VARCHAR (100) NOT NULL,
	CONSTRAINT PK_clasification PRIMARY KEY (id_clasification)
);
GO

-- Tabla de marcas de los libros
CREATE TABLE [brand] (
	id_brand INT NOT NULL IDENTITY (1,1),
	product__brand VARCHAR (100) NOT NULL,
	CONSTRAINT PK_brand PRIMARY KEY (id_brand)
);
GO
SELECT * FROM brand;
-- Insercciones de la tabla de Marcas
INSERT INTO [dbo].[brand] 
	(product__brand)
	VALUES ('Ibérica');
GO

-- Tabla de estado de los Products
CREATE TABLE [productStatus] (
	id_productStatus INT NOT NULL IDENTITY (1,1),
	product__status VARCHAR (90) NOT NULL,
	CONSTRAINT PK_statusProduct PRIMARY KEY (id_productStatus)
);
GO
SELECT * FROM productStatus;
-- Insercciones de la tabla de estados de los productos
INSERT INTO [productStatus]
	(product__status)
	VALUES ('En Existencias');
GO

-- Tabla para los estados de los Clientes
CREATE TABLE [statusClient] (
	id_status INT NOT NULL IDENTITY (1,1),
	status__client VARCHAR (50) NOT NULL
	CONSTRAINT PK_statusClient PRIMARY KEY (id_status)
);
GO
-- Inserciones de los estados de los clientes
INSERT INTO [dbo].[statusClient] 
	([status__client])
	VALUES ('Activo');
GO
INSERT INTO [dbo].[statusClient] 
	([status__client])
	VALUES ('Ináctivo');
GO
SELECT * FROM statusClient;

-- Tabla para los tipos de empleados 
CREATE TABLE [statusEmployee] (
	id_statusEmployee INT NOT NULL IDENTITY (1,1),
	status__employee VARCHAR (90) NOT NULL,
	CONSTRAINT PK_statusEmployee PRIMARY KEY (id_statusEmployee)
);
GO
INSERT INTO [dbo].[statusEmployee]
	(status__employee)
	VALUES ('Activo');
INSERT INTO [dbo].[statusEmployee]
	(status__employee)
	VALUES ('Ináctivo');
INSERT INTO [dbo].[statusEmployee]
	(status__employee)
	VALUES ('Pasante');
SELECT * FROM [dbo].[statusEmployee];

-- Tabla para los estados de los empleados
CREATE TABLE [typeEmployee] (
	id_typeEmployee INT NOT NULL IDENTITY (1,1),
	type__employee VARCHAR (100) NOT NULL,
	CONSTRAINT PK_typeEmployee PRIMARY KEY (id_typeEmployee)
);
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Administrador');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Gerente');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Vendedor');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Caja');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Bodega');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Repartidor');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Ordenanza');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Seguridad');
INSERT INTO [dbo].[typeEmployee]
	(type__employee)
	VALUES ('Administración');
SELECT id_typeEmployee AS ID,type__employee AS Cargo FROM [dbo].[typeEmployee] ORDER BY type__employee ASC;

-- Tabla para los tipos de pagos de los libros
CREATE TABLE [payment] (
	id_typePayment INT NOT NULL IDENTITY (1,1),
	type__payment VARCHAR (100) NOT NULL,
	CONSTRAINT PK_payment PRIMARY KEY (id_typePayment)
);
GO
INSERT INTO [dbo].[payment]
	(type__payment)
	VALUES ('Tarjeta de crédito');
INSERT INTO [dbo].[payment] 
	(type__payment)
	VALUES ('Tarjeta de débito');
INSERT INTO [dbo].[payment] 
	(type__payment)
	VALUES ('Efectivo');
SELECT * FROM [dbo].[payment];

-- Tabla para las devoluciones
CREATE TABLE [salesReturn] (
	id_salesReturn INT NOT NULL IDENTITY (1,1),
	date_returned DATE,
	return_comments VARCHAR (300) NOT NULL,
	id_sale INT NOT NULL
	CONSTRAINT PK_salesReturn PRIMARY KEY (id_salesReturn)
);

-- VIEWS
CREATE VIEW Clientes 
	AS SELECT client_firstName AS Nombre, client_lastName AS Apellido, client_phone AS Teléfono, 
		client_document AS Documento, client_address AS Dirección, client_mail AS Correo, 
		client_photo AS Foto, status__client AS Estado
	FROM [dbo].[client]
	INNER JOIN [dbo].[statusClient] ON [client].id_statusClient = [statusClient].id_status;
GO
SELECT * FROM Clientes;

/* __________________ Constraints __________________ */

	ALTER TABLE [dbo].[client] ADD 
	CONSTRAINT FK_status 
	FOREIGN KEY (id_statusClient) 
	REFERENCES [statusClient] (id_status);

/* ------------------ Para la tabla de Ventas ------------------ */
	ALTER TABLE [dbo].[sales] ADD
	CONSTRAINT FK_product
	FOREIGN KEY (id_product)
	REFERENCES [dbo].[products] (id_product);

	ALTER TABLE [dbo].[sales] ADD 
	CONSTRAINT FK_payment
	FOREIGN KEY (sale_type_payment)
	REFERENCES [dbo].[payment] (id_typePayment);

	ALTER TABLE [dbo].[sales] ADD 
	CONSTRAINT FK_clients
	FOREIGN KEY (id_sale_purchaser)
	REFERENCES [dbo].[client] (id_client);

	ALTER TABLE [dbo].[sales] ADD 
	CONSTRAINT FK_employees
	FOREIGN KEY (id_employee)
	REFERENCES [dbo].[employee] (id_employee);

	ALTER TABLE [dbo].[salesReturn] ADD 
	CONSTRAINT FK_salesReturn
	FOREIGN KEY (id_sale)
	REFERENCES [dbo].[sales] (id_sales);

	ALTER TABLE [dbo].[bills] ADD
	CONSTRAINT FK_sales
	FOREIGN KEY (id_sale)
	REFERENCES [dbo].[sales] (id_sales);

	ALTER TABLE [dbo].[bills] ADD
	CONSTRAINT FK_client
	FOREIGN KEY (id_client)
	REFERENCES [dbo].[client] (id_client);

	/* ------------------ Para la tabla de Empleados ------------------ */

	ALTER TABLE [dbo].[employee] ADD
	CONSTRAINT FK_typeEmployee 
	FOREIGN KEY (id_typeEmployee)
	REFERENCES [dbo].[typeEmployee] (id_typeEmployee);

	ALTER TABLE [dbo].[employee] ADD
	CONSTRAINT FK_statusEmployee
	FOREIGN KEY (id_statusEmployee)
	REFERENCES [dbo].[statusEmployee] (id_statusEmployee);

	/* ------------------ Para la tabla de Productos ------------------ */
	ALTER TABLE [dbo].[products] ADD
	CONSTRAINT FK_brands
	FOREIGN KEY (product_brand)
	REFERENCES [dbo].[brand] (id_brand);

	ALTER TABLE [dbo].[products] ADD
	CONSTRAINT FK_productStatus
	FOREIGN KEY (id_productStatus)
	REFERENCES [dbo].[productStatus] (id_productStatus);

	ALTER TABLE [dbo].[products] ADD
	CONSTRAINT FK_distributor
	FOREIGN KEY (id_productDistributor)
	REFERENCES [dbo].[distributor] (id_distributor);

	ALTER TABLE [dbo].[productSpecification] ADD
	CONSTRAINT FK_productSpecification
	FOREIGN KEY (id_product)
	REFERENCES [dbo].[products] (id_product);

	ALTER TABLE [dbo].[productSpecification] ADD
	CONSTRAINT FK_clasification
	FOREIGN KEY (id_clasification)
	REFERENCES [dbo].[clasification] (id_clasification);

	ALTER TABLE [dbo].[productSpecification] ADD
	CONSTRAINT FK_gender
	FOREIGN KEY (id_productGender)
	REFERENCES [dbo].[gender] (id_gender);

	ALTER TABLE [dbo].[products] ADD
	CONSTRAINT FK_availability
	FOREIGN KEY (id_availability)
	REFERENCES [dbo].[availability] (id_availability);

	ALTER TABLE [dbo].[products] ADD id_availability INT NOT NULL;