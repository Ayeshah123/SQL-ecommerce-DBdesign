

/*
====================================================================================================================================================
															E-Commerce Database
====================================================================================================================================================

    Overview
    This SQL script creates a relational database for an E-Commerce Management System. It defines the database structure,
    creates tables, establishes relationships between entities, and inserts sample records.

    Tables
    - Customers
    - Orders
    - Categories
    - Suppliers
    - Products
    - OrderDetails

====================================================================================================================================================
*/


---------------------------------------------------------------- CREATE DATABASE -------------------------------------------------------------------


-- Creates a new database only if it does not already exist.
IF DB_ID('Ecommerce') IS NULL
	BEGIN
		CREATE DATABASE Ecommerce;
	END
GO


------------------------------------------------------------------- USE DATABASE -------------------------------------------------------------------

-- Switches the SQL session to the HospitalManagementSystem database.
USE Ecommerce;
GO


------------------------------------------------------------------ CREATE TABLES -------------------------------------------------------------------


-- CUSTOMERS TABLE
IF OBJECT_ID('Customers', 'U') IS NULL 
BEGIN
	CREATE TABLE Customers(
		Customer_ID INT PRIMARY KEY IDENTITY(1,1),
		First_Name NVARCHAR(50) NOT NULL,
		Last_Name NVARCHAR(50) NOT NULL,
		Email NVARCHAR(100) UNIQUE NOT NULL,
		Phone NVARCHAR(100),
		Customer_City NVARCHAR(70),
		Customer_Country NVARCHAR(70),
		Created_at DATE DEFAULT GETDATE()
	)
END;
GO


-- ORDERS TABLE
IF OBJECT_ID('Orders', 'U') IS NULL
BEGIN
	CREATE TABLE Orders(
		Order_ID INT PRIMARY KEY IDENTITY(1,1),
		Customer_ID INT NOT NULL,
		OrderTime DATETIME DEFAULT GETDATE(),

		FOREIGN KEY (Customer_ID)
		REFERENCES Customers(Customer_ID)
	)
END;
GO


-- CATEGORIES TABLE
IF OBJECT_ID('Categories', 'U') IS NULL
BEGIN
	CREATE TABLE Categories(
		Category_ID INT PRIMARY KEY IDENTITY(1, 1),
		Category_Name NVARCHAR(100) UNIQUE NOT NULL
	)
END;
GO


-- SUPPLIERS TABLE
IF OBJECT_ID('Suppliers', 'U') IS NULL
BEGIN
	CREATE TABLE Suppliers(
		Supplier_ID INT PRIMARY KEY IDENTITY(1,1),
		Supplier_Name NVARCHAR(100) UNIQUE NOT NULL,
		Supplier_City NVARCHAR(100) NOT NULL,
		Supplier_Country NVARCHAR(100) NOT NULL
	)
END;
GO

-- PRODUCTS TABLE
IF OBJECT_ID('Products', 'U') IS NULL
BEGIN
	CREATE TABLE Products(
		Product_ID INT PRIMARY KEY IDENTITY(1,1),
		Product_Name NVARCHAR(100) UNIQUE NOT NULL,
		Category_ID INT NOT NULL,
		Supplier_ID INT NOT NULL,
		Unit_Price DECIMAL(10,2) NOT NULL,
		Created_at DATE DEFAULT GETDATE(),

		FOREIGN KEY (Category_ID)
		REFERENCES Categories(Category_ID),

		FOREIGN KEY (Supplier_ID)
		REFERENCES Suppliers(Supplier_ID)
	)
END;
GO


-- ORDER DETAILS TABLE
IF OBJECT_ID('OrderDetails', 'U') IS NULL
BEGIN
	CREATE TABLE OrderDetails(
		OrderDetail_ID INT PRIMARY KEY IDENTITY(1,1),
		Order_ID INT NOT NULL,
		Product_ID INT NOT NULL,
		Quantity INT CHECK (Quantity > 0),

		FOREIGN KEY (Order_ID)
		REFERENCES Orders(Order_ID),

		FOREIGN KEY (Product_ID)
		REFERENCES Products(Product_ID)
)
END;
GO


------------------------------------------------------------------ INSERT VALUES -------------------------------------------------------------------


-- Insert customer records
INSERT INTO Customers(First_Name, Last_Name, Email, Phone, Customer_City, Customer_Country)
VALUES	('Asad', 'Imran', 'asad.imran112@gmail.com', '03124785224', 'Lahore', 'Pakistan'),
		('Ali', 'Khan', 'ali.khan545@gmail.com', '03451122697', 'London', 'England');


-- Insert order records
INSERT INTO Orders(Customer_ID, OrderTime)
VALUES	(1, GETDATE()),
		(2, GETDATE())


-- Insert category records
INSERT INTO Categories(Category_Name)
VALUES	('Electronics'),
		('Kitchenware')


-- Insert supplier records
INSERT INTO Suppliers(Supplier_Name, Supplier_City, Supplier_Country)
VALUES	('Dawlance', 'Oslo', 'Norway'),
		('Kenwood',	'Berlin', 'Germany')


-- Insert product records
INSERT INTO Products(Product_Name, Category_ID, Supplier_ID, Unit_Price)
VALUES	('AC', 1, 2,80000), 
		('Cutlery', 2, 2,5000)


-- Insert order detail records
INSERT INTO OrderDetails(Order_ID, Product_ID, Quantity)
VALUES	(1, 1, 2),
		(2, 2, 1)


/*
===============================================================================================================================================
                                                            VIEW DATA
===============================================================================================================================================
*/

-- Retrieves records from each table.

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Categories;
SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM OrderDetails;


