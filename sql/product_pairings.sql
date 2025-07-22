-- Tables:
-- OrderItems(id, order_id, product_id)
--
-- Problem:
-- Find the top 5 most frequently ordered **pairs of products** in the 
same order.
-- Return: product_id_1, product_id_2, pair_count.

WITH pairs AS (
  SELECT
    LEAST(oi1.product_id, oi2.product_id) AS product_id_1,
    GREATEST(oi1.product_id, oi2.product_id) AS product_id_2,
    oi1.order_id
  FROM OrderItems oi1
  JOIN OrderItems oi2 ON oi1.order_id = oi2.order_id AND oi1.product_id < 
oi2.product_id
),
pair_counts AS (
  SELECT product_id_1, product_id_2, COUNT(*) AS pair_count
  FROM pairs
  GROUP BY product_id_1, product_id_2
)
SELECT *
FROM pair_counts
ORDER BY pair_count DESC
LIMIT 5;

