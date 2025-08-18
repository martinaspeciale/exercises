-- Tables:
-- OrderItems(id, order_id, product_id)
-- Orders(id, customer_id)
--
-- Problem:
-- Find products that customers have only ever ordered once (never 
reordered by the same customer).
-- Return: product_id, customer_count.

WITH customer_product_orders AS (
  SELECT DISTINCT o.customer_id, oi.product_id, o.id AS order_id
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
),
customer_product_counts AS (
  SELECT customer_id, product_id, COUNT(*) AS order_count
  FROM customer_product_orders
  GROUP BY customer_id, product_id
  HAVING COUNT(*) = 1
)
SELECT
  product_id,
  COUNT(DISTINCT customer_id) AS customer_count
FROM customer_product_counts
GROUP BY product_id
ORDER BY customer_count DESC;

