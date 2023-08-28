CREATE DATABASE IF NOT EXISTS LIBRARY;
USE LIBRARY;

SET GLOBAL FOREIGN_KEY_CHECKS=0;

CREATE TABLE Client (
	id_client INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    client_firstName VARCHAR (100) NOT NULL,
    client_lastName VARCHAR (100) NOT NULL,
    password_client VARCHAR (30) NOT NULL,
    client_phone VARCHAR (12) NOT NULL,
    client_address VARCHAR (200) NOT NULL,
    client_mail VARCHAR (150) NOT NULL,
    client_photo LONGBLOB,
    id_statusClient INT NOT NULL,
    client_document VARCHAR(16) NOT NULL
);
SELECT * FROM Client;

CREATE TABLE Employee (
	id_employee INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    employee_firstName VARCHAR (50) NOT NULL,
    employee_lastName VARCHAR (90) NOT NULL,
    password_employee VARCHAR (30) NOT NULL,
    employee_address VARCHAR (200) NOT NULL,
    employee_phone VARCHAR (12) NOT NULL,
    employee_mail VARCHAR (200) NOT NULL,
    employee_photo LONGBLOB,
    id_TypeEmployee INT NOT NULL
);
SELECT * FROM Employee;
    
CREATE TABLE Sales (
	id_sales INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_issue DATE NOT NULL,
    sale_address VARCHAR(200) NOT NULL,
    sale_total_due DOUBLE(5,2),
    type_of_payment INT NOT NULL,
    id_product INT NOT NULL,
    id_salePurchaser INT NOT NULL,
    id_employee INT NOT NULL
);
SELECT * FROM Sales;

CREATE TABLE SalesReturn (
	id_saleReturned INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_returned DATE,
    return__comment VARCHAR (200) NOT NULL,
    id_sale INT NOT NULL
);
SELECT * FROM SalesReturn;

-- Table to storage books
CREATE TABLE Products (
	id_product INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product_brand INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    product_price DOUBLE(5,2) NOT NULL,
    product_photo LONGBLOB,
    date_entry DATE,
    product_description VARCHAR (500) DEFAULT 'Sin descripción',
    id_productStatus INT NOT NULL,
    id_productDistributor INT NOT NULL,
    id_review INT DEFAULT NULL
);
SELECT * FROM Products;

CREATE TABLE ProductEspecification (
	id_especification INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product__quantity INT DEFAULT 0,
    product__author VARCHAR (100) NOT NULL,
    product_format VARCHAR(300) NOT NULL,
    product_themes VARCHAR(300) NOT NULL,
    id_productGender INT NOT NULL,
    id_clasification INT NOT NULL,
    id_product INT NOT NULL
);
SELECT * FROM ProductEspecification;

CREATE TABLE Distributor (
	id_distributor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name_distributor VARCHAR(120) NOT NULL,
    comments VARCHAR(400) DEFAULT 'Sin comentarios registrados',
    register_date DATE
);
SELECT * FROM Distributor;

CREATE TABLE Bills (
	id_bill INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    sale__correlative INT DEFAULT NULL,
    quantity INT NOT NULL,
    id_sales INT NOT NULL,
    id_client INT NOT NULL,
    date_issue DATE,
    comments VARCHAR(100) NOT NULL
);
SELECT * FROM Bills;


-- ********************* CHILDREN TABLE *********************
CREATE TABLE StatusClient (
	id_StatusClient INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    status__client VARCHAR (50)
);
SELECT * FROM StatusClient;

CREATE TABLE TypeEmployee (
	id_TypeEmployee INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    type__employee VARCHAR(50)
);
SELECT * FROM TypeEmployee;

CREATE TABLE Payment (
	id_payment INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    type__payment VARCHAR (40)
);
SELECT * FROM Payment;

-- Usar como EDITORIAL y no como marca
CREATE TABLE Brands (
	id_brand INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    brand__name VARCHAR (40)
);
SELECT * FROM Brands;

CREATE TABLE ProductStatus (
	id_productStatus INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product__state VARCHAR(40) NOT NULL
);
SELECT * FROM ProductStatus;

CREATE TABLE Gender (
	id_gender INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    product__gender VARCHAR (50) NOT NULL
);
SELECT * FROM Gender;

CREATE TABLE Clasification (
	id_clasification INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    clasification__product VARCHAR (50) NOT NULL
);
SELECT * FROM Clasification;

CREATE TABLE Reviews (
	id_review INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name_client VARCHAR(200) NOT NULL,
    product_review LONGTEXT NOT NULL,
    review_date DATE
);

CREATE TABLE typeEmployee (
    id_typeEmployee INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    type_employee VARCHAR(100) NOT NULL
);

CREATE TABLE availability (
    id_availability INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    book_availability VARCHAR(100) NOT NULL
);

-- ********************** Constraints to fiels ********************** --

-- Client to Status Client
ALTER TABLE Client ADD CONSTRAINT FK_statusClients
FOREIGN KEY (id_statusClient)
REFERENCES StatusClient (id_StatusClient);
-- Table Products
ALTER TABLE Products ADD CONSTRAINT FK_productStatus
FOREIGN KEY (id_ProductStatus)
REFERENCES productstatus (id_productStatus)
ON DELETE CASCADE
ON UPDATE CASCADE;
-- Employee to Type Employee 
ALTER TABLE Employee ADD CONSTRAINT FK_typeEmployee
FOREIGN KEY (id_TypeEmployee)
REFERENCES TypeEmployee (id_TypeEmployee);
-- Sales to Payment
ALTER TABLE Sales ADD CONSTRAINT FK_payment
FOREIGN KEY (type_of_payment)
REFERENCES Payment (id_payment);
-- Sales to Product 
ALTER TABLE Sales ADD CONSTRAINT FK_products
FOREIGN KEY (id_product)
REFERENCES Products (id_product);
-- Sales to Client
ALTER TABLE Sales ADD CONSTRAINT FK_purchaser
FOREIGN KEY (id_salePurchaser)
REFERENCES Client (id_client);
-- Sales to employee
ALTER TABLE Sales ADD CONSTRAINT FK_employees
FOREIGN KEY (id_employee)
REFERENCES Employee (id_employee);
-- Returned sales to Sales
ALTER TABLE SalesReturn ADD CONSTRAINT FK_salesReturn
FOREIGN KEY (id_sale)
REFERENCES Sales (id_sales);
-- Products to Brands
ALTER TABLE Products ADD CONSTRAINT FK_productBrand
FOREIGN KEY (product_brand)
REFERENCES Brands (id_brand);
-- Product Especification to Product
ALTER TABLE ProductEspecification ADD CONSTRAINT FK_product
FOREIGN KEY (id_product)
REFERENCES Products (id_product)
ON UPDATE CASCADE 
ON DELETE CASCADE;
-- Product Especification to Gender
ALTER TABLE ProductEspecification ADD CONSTRAINT FK_gender
FOREIGN KEY (id_productGender)
REFERENCES Gender (id_gender);
-- Product Especification to Clasification
ALTER TABLE ProductEspecification ADD CONSTRAINT FK_clasification
FOREIGN KEY (id_clasification)
REFERENCES Clasification (id_clasification);
-- Bills to sales 
ALTER TABLE Bills ADD CONSTRAINT FK_bill
FOREIGN KEY (id_sales)
REFERENCES Sales (id_sales);
-- Bills to clients
ALTER TABLE Bills ADD CONSTRAINT FK_billClient
FOREIGN KEY (id_client)
REFERENCES Client (id_client);
-- Product to distributor
ALTER TABLE Products ADD CONSTRAINT FK_productDistributor
FOREIGN KEY (id_productDistributor)
REFERENCES Distributor (id_distributor);

ALTER TABLE Products ADD COLUMN id_availability INT NOT NULL;

 -- ************************** Views **************************

-- View to rename fields
CREATE VIEW All_Clients AS SELECT id_client AS ID, CONCAT(client_firstName, ' ' ,client_lastName) AS Name, 
	client_phone AS Phone, client_address AS Address, client_mail AS Mail, client_photo AS photo, client_document AS DUI,status__client AS Status
FROM Client CL
INNER JOIN StatusClient SC
ON CL.id_statusClient = SC.id_StatusClient;
SELECT * FROM All_Clients;

-- Query to rename fields
CREATE VIEW All_Employees AS SELECT id_employee AS ID ,  CONCAT(employee_firstName, ' ' , employee_lastName) AS Name , employee_address AS Address, 
	employee_phone AS Phone ,employee_mail AS Mail, employee_photo AS Picture ,type__employee AS Assignment
FROM Employee EP
INNER JOIN TypeEmployee TP 
ON EP.id_TypeEmployee = TP.id_TypeEmployee
WHERE id_employee = 1;
SELECT * FROM All_Employees;

CREATE VIEW AllItems AS 
	SELECT P.id_product AS id, product_name, brand__name, CONCAT("$", product_price) AS product_price, product_photo , date_entry, product_description, product__author, product__state, product_format, product__gender, clasification__product
    FROM Products P
    INNER JOIN ProductStatus PS ON P.id_productStatus = PS.id_productStatus
    INNER JOIN Brands BR ON P.product_brand = BR.id_brand
    INNER JOIN productEspecification PDE ON P.id_product = PDE.id_product
    INNER JOIN Gender GE ON PDE.id_productGender = GE.id_gender
    INNER JOIN Clasification CL ON PDE.id_clasification = CL.id_clasification;

SELECT * FROM AllItems;

-- ************************** STORED PROCEDURES **************************

DELIMITER $$
CREATE PROCEDURE Add_Product (
	-- First insert params
	productBrand INT, productName VARCHAR(50), product_price DOUBLE(5,2), productPhoto LONGBLOB, 
    product_description LONGTEXT, productStatus INT, productDistributor INT, productReview INT,
    -- Second Insert params
	productQuantity INT, productAuthor VARCHAR(100), productFormat VARCHAR(300), productTheme VARCHAR(300), 
    productGender INT, productClasification INT)
BEGIN
	-- Variable to get last inserted ID
	DECLARE last_id INT DEFAULT 0;
    -- Variable para evaluar la insercción de la reseña, en caso de ser nula lo dejamos con un valor de 0 para luego actualizarla con el ID correspondiente
    DECLARE review_id INT;
    -- Evaluamos la variable y le asignamos un valor nullo
    SET review_id = IF(productReview = -1, NULL, productReview);
    
	START TRANSACTION;
    -- First Insert
    INSERT INTO Products (product_brand, product_name, product_price, product_photo, date_entry, product_description, id_productStatus, id_productDistributor, id_review)
		VALUES (productBrand, productName, product_price, productPhoto, CURDATE(), product_description, productStatus, productDistributor, review_id);
	-- GET LAST INSERTD ID
	SET last_id := LAST_INSERT_ID();
    
    IF last_id > 0 THEN
		INSERT INTO ProductEspecification (product__quantity, product__author, product_format, product_themes, id_productGender, id_clasification, id_product)
			VALUES (productQuantity, productAuthor, productFormat, productTheme, productGender, productClasification, last_id);
		COMMIT;
	ELSE 
		ROLLBACK;
    END IF;
END$$
DELIMITER ;

-- PROCURE TO DELETE PRODUCTS
DELIMITER $$
CREATE PROCEDURE delete_Product (id_to_delete INT)
BEGIN 
	START TRANSACTION;
		-- Tomamos la varible con la que recibimos de parámetro desde visual para eliminar la relación de las 2 tablas
		DELETE FROM Products WHERE id_product = id_to_delete;
        DELETE FROM ProductEspecification WHERE id_product = id_to_delete;
	COMMIT;
END$$
DELIMITER ;
-- Delete the product with the same ID
CALL delete_Product(10);

-- PROCEDURE TO SEARCH PRODUCT
DELIMITER $$
CREATE PROCEDURE Search_Product (search_product VARCHAR(100))
BEGIN
	START TRANSACTION;
    SELECT DISTINCT PR.id_product AS ID, product_name AS Libro, product__author AS Autor, product_photo AS Picture,
		brand__name AS Editorial , product__gender AS Género, clasification__product AS Clasificación, CONCAT('$', product_price) AS Precio, 
        product__quantity AS Cantidad, product_themes AS Temas, product__state
	-- Unimos las tablas
	FROM Products PR
	INNER JOIN Brands BR ON PR.product_brand = BR.id_brand 
	INNER JOIN ProductEspecification PDE ON PDE.id_especification
	INNER JOIN Gender GE ON PDE.id_productGender = GE.id_gender
	INNER JOIN Clasification CL ON CL.id_clasification = PDE.id_clasification
    INNER JOIN ProductStatus PS ON PR.id_productStatus = PS.id_productStatus
    -- Evaluamos donde va a buscar
	WHERE (product_name LIKE CONCAT('%',search_product,'%') OR
		product__author LIKE CONCAT('%',search_product,'%') OR
        brand__name LIKE CONCAT('%',search_product,'%') OR
        product__gender LIKE CONCAT('%',search_product,'%') OR
        product_themes LIKE CONCAT('%',search_product,'%') OR
        clasification__product LIKE CONCAT('%',search_product,'%'))
		AND product__quantity <> 0
        AND product__state != 'Agotado';
	COMMIT;
END$$
DELIMITER ;

-- Searching products
CALL Search_Product ('Conde');
SELECT * FROM Products;
SELECT * FROM ProductStatus;

-- Search 1 product by ID
DELIMITER $$
	CREATE PROCEDURE SearchById (paramID INT)
	BEGIN
		START TRANSACTION;
        SELECT PD.id_product AS ID, brand__name AS Editorial, product_name AS Libro, CONCAT('$', product_price) AS Precio, product_photo AS Foto, product__author AS Autor,
			product_format AS Caracteristicas , product_themes AS Temas, product_description AS Resumen, product__gender AS Género, 
			product__quantity AS Disponibles, clasification__product AS Clasificación ,product__state AS Estado
		FROM Products PD
		INNER JOIN Brands BR ON PD.product_brand = BR.id_brand
		INNER JOIN ProductStatus PS ON PD.id_productStatus = PS.id_productStatus
		INNER JOIN ProductEspecification PDE ON PD.id_product = PDE.id_product
		INNER JOIN Gender GE ON PDE.id_productGender = GE.id_gender
		INNER JOIN Clasification CL ON PDE.id_clasification = CL.id_clasification
		WHERE PD.id_product = paramID;
        COMMIT;
    END$$
DELIMITER ;
CALL SearchById(11);
DELIMITER $$

CREATE PROCEDURE InsertDistributor (nameDistributor VARCHAR(100), commentsDistributor LONGTEXT)
BEGIN
	START TRANSACTION;
	INSERT INTO Distributor (name_distributor, comments, register_date) VALUES (nameDistributor, commentsDistributor, CURDATE());
    COMMIT;
END$$
DELIMITER ;
CALL InsertDistributor('');


-- ********************* FUNCTIONS *********************
SELECT * FROM Clasification;

SELECT MAX(product__quantity) AS Cantidad, 
	IF (product__quantity = 0, 'Sin Existencias', 'En Existencias') AS Existencia  
FROM ProductEspecification
WHERE  id_productGender <> 3 AND id_product = 13;

SELECT DISTINCT product_name AS Product, IF (product_name LIKE "%Laza%", "Si esta", "No esta") AS Existencia FROM Products GROUP BY product_name;

DELIMITER $$
CREATE PROCEDURE SearchItem (in item VARCHAR(100))
BEGIN
	-- Variable para buscar el nombre del libro en la tabla
    DECLARE select_name VARCHAR(100);
    DECLARE end_loop INTEGER DEFAULT 0;
    
    -- Selección de la tabla y creación del cursor
    DECLARE selectTableCursor CURSOR FOR
		SELECT product_name AS Libro, CONCAT('$', product_price) AS Precio
        FROM Products
        WHERE product_name LIKE CONCAT("%",item,"%")
        GROUP BY product_name;
	-- Definimos el fin del bucle en el caso de que no encuentre más datos en la tabla
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET end_loop = 1;
    
    -- Abrimos el cursor creado
    OPEN selectTableCursor;
		searchName : LOOP
			-- Guardamos los valores de retorno de la consulta en la variable creada
			FETCH selectTableCursor INTO select_name;
            
            -- Evaluamos con un IF
            IF select_name LIKE item THEN
				select * from Products;
            END IF;
            IF end_loop = 1 THEN
				LEAVE selectTableCursor;
            END IF;
            
        END LOOP searchName;
    CLOSE selectTableCursor;
END$$
DELIMITER ;

SELECT * FROM Products;
DROP PROCEDURE SearchItem;
CALL SearchItem ("");

DELIMITER $$
CREATE PROCEDURE BuscarPersona(nombreBuscado VARCHAR(100))
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE nombre VARCHAR(100);
    DECLARE price DOUBLE(5,2);
    DECLARE productDescription VARCHAR(100);
    
    DECLARE searchName CURSOR FOR
		SELECT product_name, CONCAT('$', product_price), product_description
        FROM Products
        WHERE product_name LIKE CONCAT("%",nombreBuscado,"%")
        GROUP BY product_name;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN searchName;
		loop_cursor: LOOP
			FETCH searchName INTO nombre, price, productDescription;
            
            IF done THEN
				LEAVE loop_cursor;
            END IF;
            
            SELECT nombre, price, productDescription;
		END LOOP;
    CLOSE searchName;
END$$
DELIMITER ;

DROP PROCEDURE BuscarPersona;
CALL BuscarPersona ("La ");

INSERT INTO Distributor (name_distributor, comments, register_date) 	
	VALUES("Héctor Martínez", "Entrega cada 15 en sucursal de Santa Elena, camión blanco matricula AE2321", CURDATE());
INSERT INTO Distributor (name_distributor, comments, register_date) 	
	VALUES("Joseluis Dominguez", "Distribuidor de copias de Alfaguara cada fin de mes en sucursal de Santa Mónica, camión blanco matricula SD3412", CURDATE());
INSERT INTO Distributor (name_distributor, comments, register_date) 	
	VALUES("Víctor Sánchez", "Distribuidor de Facela, entrega en ambas sucursales, camión blanco matricula GFS259", CURDATE());





