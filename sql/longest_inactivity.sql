-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer, find the **longest gap in days** between any two of 
their orders.
-- Return: customer_id, customer_name, max_gap_days.

WITH ordered_dates AS (
  SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS 
prev_order
  FROM Orders
),
gaps AS (
  SELECT
    customer_id,
    EXTRACT(DAY FROM order_date - prev_order) AS gap_days
  FROM ordered_dates
  WHERE prev_order IS NOT NULL
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  MAX(g.gap_days) AS max_gap_days
FROM gaps g
JOIN Customers c ON c.id = g.customer_id
GROUP BY c.id, c.name
ORDER BY max_gap_days DESC;

