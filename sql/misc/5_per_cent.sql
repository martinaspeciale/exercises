-- Tables:
-- Orders(id, total_amount)
--
-- Problem:
-- Find orders in the top 5% of total_amount values.
-- Return: order_id, total_amount.

WITH ranked_orders AS (
  SELECT
    id AS order_id,
    total_amount,
    NTILE(20) OVER (ORDER BY total_amount DESC) AS bucket
  FROM Orders
)
SELECT order_id, total_amount
FROM ranked_orders
WHERE bucket = 1
ORDER BY total_amount DESC;

