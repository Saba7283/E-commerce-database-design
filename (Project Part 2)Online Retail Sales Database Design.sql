-- Best-Selling Products
SELECT p.product_name, SUM(oi.quantity) AS total_sold, SUM(oi.price) AS revenue
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;