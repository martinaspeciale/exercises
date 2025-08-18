-- Tables:
-- Orders(id, order_date)
-- OrderItems(id, order_id, quantity)
--
-- Problem:
-- For each month, calculate the average number of items per order.
-- Return: month (YYYY-MM), avg_items_per_order.

WITH order_totals AS (
  SELECT
    o.id AS order_id,
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    SUM(oi.quantity) AS total_items
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
  GROUP BY o.id, TO_CHAR(o.order_date, 'YYYY-MM')
)
SELECT
  month,
  ROUND(AVG(total_items), 2) AS avg_items_per_order
FROM order_totals
GROUP BY month
ORDER BY month;

