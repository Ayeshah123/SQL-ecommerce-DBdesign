--Create Database
IF DB_ID('ecommerce_db') IS NULL
BEGIN
	CREATE DATABASE ecommerce_db;
END
GO

--Use Database
USE ecommerce_db;
GO

--Create Tables
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
		Created_at DATE NOT NULL
	)
END;
GO

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

IF OBJECT_ID('Categories', 'U') IS NULL
BEGIN
	CREATE TABLE Categories(
		Category_ID INT PRIMARY KEY IDENTITY(1, 1),
		Category_Name NVARCHAR(100) UNIQUE NOT NULL
	)
END;
GO

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

--Insert values
INSERT INTO Customers(
	First_Name,
	Last_Name,
	Email,
	Phone,
	Customer_City,
	Customer_Country)
VALUES('Asad',
	'Imran',
	'asad.imran112@gmail.com',
	'03124785224',
	'Lahore',
	'Pakistan'),
	('Ali',
	'Khan',
	'ali.khan545@gmail.com',
	'03451122697',
	'London',
	'England');


INSERT INTO Orders(
	Customer_ID,
	OrderTime)
VALUES(1,
	GETDATE()),
	(2,
	GETDATE())

INSERT INTO Categories(
	Category_Name)
VALUES('Electronics'),
	('Kitchenware')

INSERT INTO Suppliers(
	Supplier_Name,
	Supplier_City,
	Supplier_Country)
VALUES('Dawlance',
	'Oslo',
	'Norway'),
	('Kenwood',
	'Berlin',
	'Germany')

INSERT INTO Products(
	Product_Name,
	Category_ID,
	Supplier_ID,
	Unit_Price)
VALUES(
	'AC',
	1,
	2,
	80000), 
	(
	'Cutlery',
	2,
	2,
	5000)

INSERT INTO OrderDetails(
	Order_ID,
	Product_ID,
	Quantity)
VALUES(
	1, 1, 2),
	(2, 2, 1)

