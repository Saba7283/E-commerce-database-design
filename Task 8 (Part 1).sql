USE ecommercedb;

DELIMITER $$

CREATE FUNCTION GetOrderTotal(orderID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(oi.Quantity * p.Price)
    INTO total
    FROM OrderItems oi
    JOIN Products p ON oi.ProductID = p.ProductID
    WHERE oi.OrderID = orderID;

    RETURN total;
END$$

DELIMITER ;
