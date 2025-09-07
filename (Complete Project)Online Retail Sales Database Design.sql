CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- E-Commerce Database Design

-- Drop tables if they already exist (to reset database)
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- ==========================================================
-- 1. Create Tables (DDL)
-- ==========================================================

-- Customers Table
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Products Table
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) UNIQUE,
    description VARCHAR(255),
    price DECIMAL(10,2),
    stock_quantity INT
);

-- Orders Table
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES Customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2)
);

-- Order Items Table
CREATE TABLE OrderItems (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES Orders(order_id),
    product_id INT REFERENCES Products(product_id),
    quantity INT,
    price DECIMAL(10,2)
);

-- Payments Table
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE REFERENCES Orders(order_id),
    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
-- 2. Insert Sample Data
-- ==========================================================

-- Customers
INSERT INTO Customers (first_name, last_name, email, phone, address, city, country) VALUES
('Nayeon','Kim','lisa@gmail.com','1234567890','sector - 10, utopia , USA','utopia','USA'),
('Mina','Lay','mina@gmail.com','2345678901','sector - 11, nevermore , USA','nevermore','USA'),
('Momo','Mianna','momo@gmail.com','3456789012','sector - 12 , calphs , USA','calphs','USA'),
('Sana','Slay','sanaslay@gmail.com','4567890123','sector - 20 , sways , INDIA','sways','INDIA'),
('Yunjin','Yale','yunjinyale@gmail.com','0987654321','sector - 21 , cleiver , INDIA','cleiver','INDIA'),
('Chaewon','Yasaki','chaewonyasaki@gmail.com','6543210987','sector - 22 , laksha , INDIA','laksha','INDIA'),
('Eunchae','Ellie','eunchaeellie@gmail.com','3876542109','sector - 23 , mumbai , INDIA','mumbai','INDIA'),
('Lara','Raj','lararaj@gmail.com','876012345','sector - 24 , tamilnaidu , INDIA','tamilnaidu','INDIA'),
('Daniella','Dane','danielladane@gmail.com','3245167890','sector - 30 , seoul , SOUTH KOREA','seoul','SOUTH KOREA'),
('Manon','May','manonmay@gmail.com','0984561237','sector - 31 , busan , SOUTH KOREA','busan','SOUTH KOREA');

-- Products
INSERT INTO Products (product_name, description, price, stock_quantity) VALUES
('Laptop','Gaming Laptop',55000,10),
('Phone','Smartphone 5G',70000,15),
('Earpiece','Soundproof',10000,10),
('Watch','Smart watch',80000,20),
('Battery','Lasting 7 days',10000,15);

-- Orders
INSERT INTO Orders (customer_id, total_amount) VALUES
(1, 55000), -- Nayeon buys Laptop
(2, 70000), -- Mina buys Phone
(3, 10000), -- Momo buys Earpiece
(4, 80000), -- Sana buys Watch
(5, 10000), -- Yunjin buys Battery
(6, 55000), -- Chaewon buys Laptop
(7, 70000), -- Eunchae buys Phone
(8, 10000), -- Lara buys Earpiece
(9, 80000), -- Daniella buys Watch
(10, 10000); -- Manon buys Battery

-- Order Items
INSERT INTO OrderItems (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 55000),
(2, 2, 1, 70000),
(3, 3, 1, 10000),
(4, 4, 1, 80000),
(5, 5, 1, 10000),
(6, 1, 1, 55000),
(7, 2, 1, 70000),
(8, 3, 1, 10000),
(9, 4, 1, 80000),
(10, 5, 1, 10000);

-- Payments
INSERT INTO Payments (order_id, payment_method, amount) VALUES
(1, 'UPI', 55000),
(2, 'UPI', 70000),
(3, 'UPI', 10000),
(4, 'UPI', 80000),
(5, 'UPI', 10000),
(6, 'UPI', 55000),
(7, 'UPI', 70000),
(8, 'UPI', 10000),
(9, 'UPI', 80000),
(10, 'UPI', 10000);

-- ==========================================================
-- 3. Queries for Reports
-- ==========================================================

-- Sales by Customer
SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY total_spent DESC;

-- Best-Selling Products
SELECT p.product_name, SUM(oi.quantity) AS total_sold, SUM(oi.price) AS revenue
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Payment Summary
SELECT payment_method, SUM(amount) AS total_amount
FROM Payments
GROUP BY payment_method;
