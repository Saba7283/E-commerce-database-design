-- 1. Drop existing tables (optional for fresh start)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- 2. Create tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 3. Insert data
INSERT INTO customers VALUES
(1, 'Ayaan', 'ayaan@example.com'),
(2, 'Neha', 'neha@example.com'),
(3, 'Ravi', 'ravi@example.com');

INSERT INTO products VALUES
(101, 'Laptop', 50000.00, 'Electronics'),
(102, 'Phone', 25000.00, 'Electronics'),
(103, 'Book', 500.00, 'Books'),
(104, 'Table', 3000.00, 'Furniture');

INSERT INTO orders VALUES
(201, 1, 75500.00, '2025-08-01'),
(202, 2, 25000.00, '2025-08-02'),
(203, 3, 500.00, '2025-08-03'),
(204, 1, 3000.00, '2025-08-04');

INSERT INTO order_items VALUES
(301, 201, 101, 1),
(302, 201, 103, 5),
(303, 202, 102, 1),
(304, 203, 103, 1),
(305, 204, 104, 1);

-- 4. Queries using SUM, COUNT, AVG, GROUP BY, HAVING

-- Total customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Average order value
SELECT AVG(total_amount) AS average_order_value FROM orders;

-- Total spent by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- Orders per customer
SELECT customer_id, COUNT(order_id) AS number_of_orders
FROM orders
GROUP BY customer_id;

-- Customers who spent more than ₹50000
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING total_spent > 50000;

-- Average product price per category
SELECT category, AVG(price) AS average_price
FROM products
GROUP BY category;

-- Products sold more than 1 time
SELECT product_id, SUM(quantity) AS total_quantity_sold
FROM order_items
GROUP BY product_id
HAVING total_quantity_sold > 1;

-- Top 2 spending customers
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 2;
