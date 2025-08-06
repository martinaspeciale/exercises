-- Tables:
-- OrderItems(id, order_id, product_id)
--
-- Problem:
-- Find products that **always appear** in the same order as product ID = 
42.
-- Return: co_product_id.

WITH target_orders AS (
  SELECT DISTINCT order_id
  FROM OrderItems
  WHERE product_id = 42
),
co_products AS (
  SELECT
    oi.product_id,
    COUNT(DISTINCT oi.order_id) AS co_count
  FROM OrderItems oi
  WHERE oi.order_id IN (SELECT order_id FROM target_orders)
    AND oi.product_id != 42
  GROUP BY oi.product_id
),
order_count AS (
  SELECT COUNT(*) AS target_count FROM target_orders
)
SELECT
  cp.product_id AS co_product_id
FROM co_products cp, order_count oc
WHERE cp.co_count = oc.target_count
ORDER BY co_product_id;

