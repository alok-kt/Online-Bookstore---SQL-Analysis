-- Create Tables --

DROP TABLE IF EXISTS books;
CREATE TABLE books (
	Book_ID INT PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(100),
	Genre VARCHAR(50),
	Published_Year INT,
	Price NUMERIC(10, 2),
	Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
	Customer_ID INT PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	Order_ID INT PRIMARY KEY,
	Customer_ID INT REFERENCES customers(Customer_ID),
	Book_ID INT REFERENCES Books(Book_ID),
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);

-- Import Data into 'books' table --
-- Importing data to the 3 tables using Import/Export option --

-- Selecting the tables --

SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;
