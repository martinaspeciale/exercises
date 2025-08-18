-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- Find customers who had a gap of more than 90 days between any two 
consecutive orders.
-- Return: customer_id, customer_name, max_gap_days.

WITH order_gaps AS (
  SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS 
prev_order
  FROM Orders
),
gap_days AS (
  SELECT
    customer_id,
    EXTRACT(DAY FROM order_date - prev_order) AS gap_days
  FROM order_gaps
  WHERE prev_order IS NOT NULL
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  MAX(g.gap_days) AS max_gap_days
FROM gap_days g
JOIN Customers c ON c.id = g.customer_id
GROUP BY c.id, c.name
HAVING MAX(g.gap_days) > 90
ORDER BY max_gap_days DESC;

