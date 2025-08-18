-- Tables:
-- OrderItems(id, order_id, product_id)
-- Products(id, category_id)
--
-- Problem:
-- Find orders where all items belong to the same category.
-- Return: order_id, category_id.

SELECT
  oi.order_id,
  p.category_id
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.id
GROUP BY oi.order_id, p.category_id
HAVING COUNT(DISTINCT p.category_id) = 1;

