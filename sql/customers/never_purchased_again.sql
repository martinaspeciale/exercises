-- Tables:
-- OrderItems(id, order_id, product_id)
-- Orders(id, customer_id)
--
-- Problem:
-- Find products that were purchased only once by each customer and never 
bought again by anyone.
-- Return: product_id.

WITH product_customer_counts AS (
  SELECT
    o.customer_id,
    oi.product_id,
    COUNT(*) AS times_ordered
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
  GROUP BY o.customer_id, oi.product_id
),
unique_buys AS (
  SELECT product_id
  FROM product_customer_counts
  WHERE times_ordered = 1
),
global_counts AS (
  SELECT product_id, COUNT(*) AS buyers
  FROM product_customer_counts
  GROUP BY product_id
)
SELECT ub.product_id
FROM unique_buys ub
JOIN global_counts gc ON ub.product_id = gc.product_id
WHERE gc.buyers = 1;

