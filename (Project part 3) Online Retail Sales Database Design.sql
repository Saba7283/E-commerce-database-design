-- Payment Summary
SELECT payment_method, SUM(amount) AS total_amount
FROM Payments
GROUP BY payment_method;