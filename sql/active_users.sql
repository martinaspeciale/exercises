-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- List the 5 customers with the most recent order dates.
-- Return: customer_id, customer_name, last_order_date.

WITH last_orders AS (
  SELECT
    customer_id,
    MAX(order_date) AS last_order_date
  FROM Orders
  GROUP BY customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  lo.last_order_date
FROM last_orders lo
JOIN Customers c ON c.id = lo.customer_id
ORDER BY lo.last_order_date DESC
LIMIT 5;

