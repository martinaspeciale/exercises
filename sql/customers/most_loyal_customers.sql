-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- Define loyalty as customers who:
-- - Have placed at least 5 orders
-- - And made their latest order within the last 30 days (from 
'2025-07-01')
-- Return: customer_id, customer_name, total_orders, last_order_date.

WITH customer_orders AS (
  SELECT
    customer_id,
    COUNT(*) AS total_orders,
    MAX(order_date) AS last_order_date
  FROM Orders
  GROUP BY customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  co.total_orders,
  co.last_order_date
FROM customer_orders co
JOIN Customers c ON co.customer_id = c.id
WHERE co.total_orders >= 5
  AND co.last_order_date >= '2025-06-01'
ORDER BY total_orders DESC;

