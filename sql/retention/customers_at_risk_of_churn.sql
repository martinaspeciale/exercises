-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- Identify customers who **haven't ordered in the last 90 days**.
-- Return: customer_id, customer_name, last_order_date.

WITH last_orders AS (
  SELECT
    o.customer_id,
    MAX(o.order_date) AS last_order_date
  FROM Orders o
  GROUP BY o.customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  lo.last_order_date
FROM last_orders lo
JOIN Customers c ON c.id = lo.customer_id
WHERE lo.last_order_date < CURRENT_DATE - INTERVAL '90 days'
ORDER BY lo.last_order_date;

