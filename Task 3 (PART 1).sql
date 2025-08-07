USE ecommercedb;

-- 1. Select all unique customer details (cleaned)
SELECT DISTINCT TRIM(name) AS name,
       email,
       address
FROM customers;

-- 2. Select name and email of customers from Mumbai
SELECT name, email 
FROM customers
WHERE address = 'Mumbai';

-- 3. Get top 5 customers ordered by name
SELECT * FROM customers
ORDER BY name ASC
LIMIT 5;

-- 4. Get all orders placed by customer with ID = 2
SELECT * FROM orders
WHERE customer_id = 2;

-- 5. Show the 3 most recent orders
SELECT * FROM orders
ORDER BY order_date DESC
LIMIT 3;

-- 6. Select name and price of products in 'Electronics' category
SELECT name, price 
FROM products
WHERE category = 'Electronics';

-- 7. Select top 5 expensive products
SELECT * FROM products
ORDER BY price DESC
LIMIT 5;

-- 8. Combine WHERE + ORDER BY + LIMIT for 'Books'
SELECT name, price 
FROM products
WHERE category = 'Books'
ORDER BY price ASC
LIMIT 3;
