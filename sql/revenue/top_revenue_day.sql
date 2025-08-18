-- Tables:
-- Orders(id, order_date, total_amount)
--
-- Problem:
-- Find the single day with the highest total revenue.
-- Return: order_date, total_revenue.

SELECT
  DATE(order_date) AS order_date,
  SUM(total_amount) AS total_revenue
FROM
  Orders
GROUP BY
  DATE(order_date)
ORDER BY
  total_revenue DESC
LIMIT 1;

