SELECT * FROM books;
SELECT * FROM customers;
SELECT * FROM orders;

-- Retrieve all books in the 'fiction' genre: --
SELECT * FROM books
WHERE genre = 'Fiction';

-- Books published after the year 1950: --
SELECT * FROM books
WHERE published_year > 1950
ORDER BY published_year; 

-- List all customers from Canada --
SELECT * FROM customers
WHERE Country = 'Canada';

-- Orders placed in Nov 2023: --
SELECT * FROM orders
WHERE Order_date BETWEEN '2023-11-01' AND '2023-11-30'
ORDER BY Order_date;

-- Retrieving the total stock of books available: --
SELECT SUM(stock) AS total_available_stock
FROM books;

-- Details of the most expensive book: --
SELECT * FROM books
ORDER BY price DESC
LIMIT 1;

-- Customers who ordered more than 1 quantity of book: --
SELECT * FROM ORDERS
WHERE quantity > 1;

-- Retrieve all orders where total amount exceeds 20$: --
SELECT * FROM orders
WHERE total_amount > 20;

-- List all genres: --
SELECT DISTINCT Genre FROM books;

-- Find the book with the lowest stock: --
SELECT * FROM books
ORDER BY stock;

-- Total revenue generated from all orders: --
SELECT SUM(Total_amount) AS total_revenue
FROM orders;

-- Retrieve the total no.of books sold for each genre: --
SELECT b.Genre, SUM(o.Quantity) AS total_per_genre
FROM books b
JOIN orders o ON o.Book_ID = b.Book_ID
GROUP BY b.Genre;

-- Average price of books in the 'fantasy' genre: --
SELECT Genre, 
CAST(AVG(Price) AS DECIMAL (10,2)) AS avg_price
FROM books
WHERE Genre = 'Fantasy'
GROUP BY Genre;

-- Customers who have placed atleast 2 orders: --
SELECT c.Name, COUNT(o.Order_ID) AS order_count
FROM customers c
JOIN orders o ON o.Customer_ID = c.Customer_ID
GROUP BY c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- Most frequently ordered book: --
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS ordered_count
FROM orders o
JOIN books b ON b.Book_ID = o.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY ordered_count DESC
LIMIT 1;

-- Top 3 expensive book in 'Fantasy' genre: --
SELECT Title, Genre, Price
FROM books
WHERE Genre = 'Fantasy'
ORDER BY Price DESC LIMIT 3;

-- Total quantity of books sold by each author: --
SELECT b.Author, SUM(o.Quantity) AS total_books_sold
FROM books b
JOIN orders o ON o.Book_ID = b.Book_ID
GROUP BY b.Author;

-- Cities where customers spent over 30$: --
SELECT c.City, SUM(o.Total_Amount) AS total_spent
FROM customers c
JOIN orders o ON o.Customer_ID = c.Customer_ID
GROUP BY c.city
HAVING SUM(o.Total_Amount) > 30
ORDER BY total_spent;

-- Customers who spent the most on orders: --
SELECT c.Customer_ID, c.Name, SUM(o.Total_Amount) AS total_spent
FROM customers c
JOIN orders o ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
ORDER BY total_spent DESC
LIMIT 10;

-- Calculate the stock remaining after fulfilling all orders: --
SELECT b.Book_ID, b.Title, b.Stock, COALESCE(SUM(o.Quantity), 0) AS order_quantity, 
	b.Stock - COALESCE(SUM(o.Quantity), 0) AS remaining_quantity
FROM books b
LEFT JOIN orders o ON o.Book_ID = b.Book_ID
GROUP BY b.Book_ID
ORDER BY b.Book_ID;