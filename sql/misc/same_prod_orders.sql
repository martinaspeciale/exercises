-- Tables:
-- OrderItems(id, order_id, product_id)
--
-- Problem:
-- Find all orders where the **same product appears more than once** 
(i.e., duplicates).
-- Return: order_id, product_id, occurrence_count.

SELECT
  order_id,
  product_id,
  COUNT(*) AS occurrence_count
FROM OrderItems
GROUP BY order_id, product_id
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;

