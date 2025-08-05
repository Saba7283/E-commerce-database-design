USE ecommercedb;
-- Disable safe update temporarily
SET SQL_SAFE_UPDATES = 0;

-- Insert customers (no duplicate entries)
INSERT INTO customers (name, email, address)
VALUES
  ('Priya Verma', NULL, 'Chennai'),
  ('Aman Yadav', 'aman@example.com', NULL),
  ('Sneha Roy', NULL, NULL);

-- Insert new products
INSERT INTO products (name, price, stock)
VALUES
  ('Monitor', 7000.00, 10),
  ('Tablet', 25000.00, NULL), -- Stock unknown
  ('Charger', 500.00, 50);

-- Insert orders for existing customers
INSERT INTO orders (customer_id, order_date)
VALUES
  (5, '2025-08-05'),
  (6, '2025-08-05');

-- Example insert into order_items
INSERT INTO order_items (order_id, product_id, quantity)
VALUES
  (106, 2, 1),  -- Example: order 106, product 2 (Tablet), quantity 1
  (107, 1, 2);  -- order 107, product 1 (Monitor)

-- Update address for Aman Yadav
UPDATE customers
SET address = 'Kolkata'
WHERE name = 'Aman Yadav';

-- Update Tablet stock from NULL to actual
UPDATE products
SET stock = 25
WHERE name = 'Tablet';

-- Fix a specific order’s date
UPDATE orders
SET order_date = '2025-08-02'
WHERE order_id = 103;

-- Delete customer with NULL email (only Sneha Roy)
DELETE FROM customers
WHERE email IS NULL AND name = 'Sneha Roy';

-- Delete a wrongly added order item
DELETE FROM order_items
WHERE order_item_id = 4;

-- Re-enable safe update mode
SET SQL_SAFE_UPDATES = 1;
