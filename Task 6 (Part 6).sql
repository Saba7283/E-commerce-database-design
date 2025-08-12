SELECT OrderID, CustomerID, Amount
FROM Orders o
WHERE Amount > (
    SELECT AVG(Amount)
    FROM Orders
    WHERE CustomerID = o.CustomerID
);
