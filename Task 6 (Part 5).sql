SELECT c.Name, summary.MaxOrder
FROM (
    SELECT CustomerID, MAX(Amount) AS MaxOrder
    FROM Orders
    GROUP BY CustomerID
) AS summary
JOIN Customers c ON c.CustomerID = summary.CustomerID;
