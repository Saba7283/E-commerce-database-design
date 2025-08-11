-- Step 1: Select your database
USE ecommercedb;

-- Step 2: Drop existing tables if they exist
SET FOREIGN_KEY_CHECKS = 0; -- Disable foreign key checks
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
SET FOREIGN_KEY_CHECKS = 1; -- Re-enable foreign key checks

-- Step 3: Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50)
);

-- Step 4: Create Orders table (no foreign key restriction)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50),
    Quantity INT
);

-- Step 5: Insert data into Customers
INSERT INTO Customers VALUES
(1, 'Alice', 'Delhi'),
(2, 'Bob', 'Mumbai'),
(3, 'Charlie', 'Bangalore'),
(4, 'David', 'Pune');

-- Step 6: Insert data into Orders (includes unmatched CustomerID = 5)
INSERT INTO Orders VALUES
(101, 1, 'Laptop', 2),        -- Match with Alice
(102, 1, 'Mouse', 5),         -- Match with Alice
(103, 2, 'Keyboard', 1),      -- Match with Bob
(104, 5, 'Monitor', 3);       -- No matching customer

-- Step 7: INNER JOIN - Matching rows from both tables
SELECT Customers.Name, Orders.Product, Orders.Quantity
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- Step 8: LEFT JOIN - All customers, even without orders
SELECT Customers.Name, Orders.Product, Orders.Quantity
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- Step 9: RIGHT JOIN - All orders, even without matching customers
SELECT Customers.Name, Orders.Product, Orders.Quantity
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- Step 10: FULL OUTER JOIN - Simulated using UNION of LEFT and RIGHT joins
SELECT Customers.Name, Orders.Product, Orders.Quantity
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT Customers.Name, Orders.Product, Orders.Quantity
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;
