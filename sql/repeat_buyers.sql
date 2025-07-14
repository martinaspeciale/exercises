-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- Find all customers who have placed more than one order.
-- Return: customer_id, customer_name, order_count.

WITH order_counts AS (
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
  oc.order_count
FROM
  order_counts oc
  JOIN Customers c ON oc.customer_id = c.id
WHERE
  oc.order_count > 1
ORDER BY
  order_count DESC;

