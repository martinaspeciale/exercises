-- Tables:
-- OrderItems(id, order_id, product_id)
-- Orders(id, order_date)
--
-- Problem:
-- For each product, find the longest gap (in days) between consecutive 
orders.
-- Return: product_id, max_gap_days.

WITH product_orders AS (
  SELECT
    oi.product_id,
    o.order_date,
    LAG(o.order_date) OVER (PARTITION BY oi.product_id ORDER BY 
o.order_date) AS prev_date
  FROM OrderItems oi
  JOIN Orders o ON oi.order_id = o.id
),
gaps AS (
  SELECT
    product_id,
    EXTRACT(DAY FROM order_date - prev_date) AS gap_days
  FROM product_orders
  WHERE prev_date IS NOT NULL
)
SELECT
  product_id,
  MAX(gap_days) AS max_gap_days
FROM gaps
GROUP BY product_id
ORDER BY max_gap_days DESC;

