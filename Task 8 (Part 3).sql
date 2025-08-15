USE ecommercedb;

-- Remove old function if it exists
DROP FUNCTION IF EXISTS GetOrderTotal;

DELIMITER $$

CREATE FUNCTION GetOrderTotal(orderID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    -- Calculate the total amount for a given order
    SELECT SUM(oi.Quantity * p.Price)
    INTO total
    FROM OrderItems oi
    JOIN Products p ON oi.ProductID = p.ProductID
    WHERE oi.OrderID = orderID;

    -- Return 0 if no matching data is found
    IF total IS NULL THEN
        SET total = 0;
    END IF;

    RETURN total;
END$$

DELIMITER ;

-- ✅ Test the function with an existing OrderID
SELECT GetOrderTotal(1001) AS OrderTotal;  -- This should return 55000 for your data



