-- Create Database 
CREATE DATABASE onlinebookstore;

--switch to Database
onlinebookstore;

--create Table
--BOOKS TABLE
DROP TABLE IF EXISTS Books;  --If Table exist this query will delete it

CREATE TABLE Books(
	Book_ID	SERIAL PRIMARY KEY,
	Title VARCHAR(100),
	Author VARCHAR(200),
	Genre VARCHAR(50),
	Published_Year INT,	
	Price NUMERIC(10,2),
	Stock INT
);
SELECT * FROM Books; -- query check table is created 

--CUSTOMER TABLE
DROP TABLE IF EXISTS Customer;  --If Table exist this query will delete it

CREATE TABLE Customer(
	Customer_ID	SERIAL PRIMARY KEY,
	Name VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR(150)
);

SELECT * FROM Customer; -- query check table is created

--ORDER TABLE
DROP TABLE IF EXISTS Orders;  --If Table exist this query will delete it

CREATE TABLE Orders(
	Order_ID SERIAL PRIMARY KEY,
	Customer_ID	INT REFERENCES Customer(Customer_ID),
	Book_ID	INT REFERENCES Books(Book_ID),
	Order_Date	DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)
);
SELECT * FROM Orders; -- query check table is created



--IMPORT data into Books Table 
COPY Books(Book_ID,Title,Author,Genre,Published_Year,Price,Stock)
FROM 'C:\Users\ABC\Desktop\DATA ANALYST PROJECT\Online book store\Books.csv'
CSV HEADER

--IMPORT data into Customer Table 
COPY Customer(Customer_ID,Name,Email,Phone,City,Country)
FROM 'C:\Users\ABC\Desktop\DATA ANALYST PROJECT\Online book store\Customers.csv'
CSV HEADER;

--IMPORT data into orders Table 
COPY orders(Order_ID,Customer_ID,Book_ID,Order_Date,Quantity,Total_Amount)
FROM 'C:\Users\ABC\Desktop\DATA ANALYST PROJECT\Online book store\Orders.csv'
CSV HEADER;


-- RUN 3 Table 
SELECT * FROM Books; -- query check table is created 
SELECT * FROM Customer; -- query check table is created
SELECT * FROM Orders; -- query check table is created


-- QUESTION 
--Q1 Retrive all books in the "fiction" Genre
SELECT * FROM Books
Where genre'Fiction';

--Q2 find books publish after the year 1950
SELECT * FROM Books
where published_year>1950;

--Q3 list all the customer from canada 
SELECT * FROM Customer 
where Country'Canada';

--Q4 Show Order place in november 2023
SElECT * from orders
where order_date BETWEEN '2023-11-01' And '2023-11-30';

--Q5 RETRIVE the total Stock of books Available
SELECT SUM(stock) AS TOTAL_STOCK from Books;

--Q6 Find the detail of most expensive book 
SELECT * FROM books ORDER BY price DESC LIMIT 1;

--06.1 find the expensive book price
SELECT max(price) AS COSTLY_BOOK from Books;

--07 show all the customer who orderedmore than 1 quantity of a book
SELECT * FROM orders
WHERE Quantity>1;

--Q8 retrive all orders where the total amount exceeds $20:
SELECT * FROM orders
WHERE Total_amount>20;

--Q9 list all geres available in the table
select DISTINCT genre From Books;

--10 find the book with lowest stock
SELECT * FROM Books order by Stock LIMIT 1;

--11 Calculate the total revenue generated from all orders:
SELECT sum(total_amount) As revenue FROM orders;



--ADVANCE QUESTION 
--12 retrive the total number of books sold for each genre
SELECT b.genre,SUM(o.quantity) AS TOTAL_SOLD
	FROM books b
		JOIN
		orders o 
		ON 
		b.book_id=o.book_id
	GROUP by b.genre ;

--13 find the  average quantity of books in the 'Fantasy' genre
SELECT b.genre, AVG(o.quantity) AS TOTAL
FROM books b
JOIN orders o
  ON b.book_id = o.book_id
WHERE b.genre = 'Fantasy'
GROUP BY b.genre;

--14 list customer  who have placed atleast 2 orders 
SELECT Customer_id,c.name,COUNT(o.order_id) As ORDER_count
from orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP by o.customer_id , c.name
HAVING COUNT(order_id)>=2;

--15 find the most frequently orders book
SELECT o.Book_id ,b.title COUNT(o.oreder_id) AS order_count
FROM orders o
join books b ON b.book_id=o.book_id
Group by Book_id
order by order_count desc limit 1;






