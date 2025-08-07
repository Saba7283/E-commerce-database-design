-- Use the ecommercedb database
USE ecommercedb;

-- STEP 1: Drop order_items table first (it references products)
DROP TABLE IF EXISTS order_items;

-- STEP 2: Now drop products safely
DROP TABLE IF EXISTS products;

-- STEP 3: Recreate products table with category
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    category VARCHAR(50)
);

-- STEP 4: Re-insert product data with categories
INSERT INTO products (name, price, stock, category)
VALUES
('Smartphone', 15000.00, 50, 'Electronics'),
('Laptop', 60000.00, 30, 'Electronics'),
('Headphones', 2000.00, 100, 'Electronics'),
('Keyboard', 1200.00, 80, 'Accessories'),
('Mouse', 800.00, 90, 'Accessories'),
('Novel Book', 500.00, 70, 'Books'),
('Notebook', 100.00, 150, 'Books');


-- ✅ 1. Select all customer details
-- Select unique customer names only (no repeats), clean whitespace
SELECT DISTINCT TRIM(name) AS name,
       email,
       address
FROM customers;

-- ✅ 2. Select name and email of customers from Mumbai
SELECT name, email 
FROM customers
WHERE city = 'Mumbai';

-- ✅ 3. Get top 5 customers ordered by name
SELECT * FROM customers
ORDER BY name ASC
LIMIT 5;

-- ✅ 4. Get all orders placed by customer with ID = 2
SELECT * FROM orders
WHERE customer_id = 2;

-- ✅ 5. Show the 3 most recent orders
SELECT * FROM orders
ORDER BY order_date DESC
LIMIT 3;

-- ✅ 6. Select name and price of products in 'Electronics' category
SELECT name, price 
FROM products
WHERE category = 'Electronics';

-- ✅ 7. Select top 5 expensive products
SELECT * FROM products
ORDER BY price DESC
LIMIT 5;

-- ✅ 8. Combine WHERE + ORDER BY + LIMIT
-- Get 3 cheapest books
SELECT name, price 
FROM products
WHERE category = 'Books'
ORDER BY price ASC
LIMIT 3;
