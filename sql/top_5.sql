-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id)
--
-- Problem:
-- Find top 5 customers with the highest number of orders.
-- Return: customer_id, customer_name, order_count.

WITH customer_orders AS (
  SELECT
    customer_id,
    COUNT(*) AS order_count
  FROM
    Orders
  GROUP BY
    customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  co.order_count
FROM
  customer_orders co
  JOIN Customers c ON co.customer_id = c.id
ORDER BY
  co.order_count DESC
LIMIT 5;

