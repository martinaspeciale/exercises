-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- Find customers whose order amounts are strictly increasing over time.
-- Only include customers with at least 2 orders.
-- Return: customer_id, customer_name.

WITH ranked_orders AS (
  SELECT
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
  FROM
    Orders
),
check_increase AS (
  SELECT
    ro.customer_id,
    ro.rn,
    ro.total_amount,
    LAG(ro.total_amount) OVER (PARTITION BY ro.customer_id ORDER BY ro.rn) 
AS prev_amount
  FROM
    ranked_orders ro
),
invalid_customers AS (
  SELECT DISTINCT customer_id
  FROM check_increase
  WHERE prev_amount IS NOT NULL AND total_amount <= prev_amount
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name
FROM
  Customers c
WHERE
  c.id NOT IN (SELECT customer_id FROM invalid_customers)
  AND EXISTS (
    SELECT 1 FROM Orders o WHERE o.customer_id = c.id HAVING COUNT(*) > 1
  )
ORDER BY
  customer_id;

