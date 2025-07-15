-- Tables:
-- Orders(id, order_date, total_amount)
--
-- Problem:
-- Calculate total revenue per month for 2024.
-- Return: month (YYYY-MM), total_revenue.

SELECT
  TO_CHAR(order_date, 'YYYY-MM') AS month,
  SUM(total_amount) AS total_revenue
FROM
  Orders
WHERE
  order_date >= '2024-01-01'
  AND order_date < '2025-01-01'
GROUP BY
  TO_CHAR(order_date, 'YYYY-MM')
ORDER BY
  month;

