SELECT 
    Name,
    (SELECT COUNT(*) 
     FROM Orders 
     WHERE Orders.CustomerID = Customers.CustomerID) AS TotalOrders
FROM Customers;
