USE ecommercedb;

-- View 1: High Value Customers
-- Shows customers whose total purchase value exceeds ₹50,000
CREATE OR REPLACE VIEW HighValueCustomers AS
SELECT c.CustomerID, c.Name, SUM(oi.Quantity * p.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID, c.Name
HAVING SUM(oi.Quantity * p.Price) > 50000;

-- View 2: Mumbai Customers
-- Shows names & emails of customers in Mumbai
CREATE OR REPLACE VIEW MumbaiCustomers AS
SELECT Name, Email
FROM Customers
WHERE City = 'Mumbai';

-- View 3: Order Summary
-- Shows each order with its total value
CREATE OR REPLACE VIEW OrderSummary AS
SELECT o.OrderID, c.Name AS CustomerName, o.OrderDate,
       SUM(oi.Quantity * p.Price) AS OrderValue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY o.OrderID, c.Name, o.OrderDate;

-- USAGE EXAMPLES
-- 1. All high value customers
SELECT * FROM HighValueCustomers;

-- 2. Mumbai customers' emails
SELECT * FROM MumbaiCustomers;

-- 3. All orders and their total values
SELECT * FROM OrderSummary;

-- 4. Filter high value customers spending over 1 lakh
SELECT * FROM HighValueCustomers WHERE TotalSpent > 100000;
