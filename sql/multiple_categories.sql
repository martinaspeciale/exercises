-- Tables:
-- Orders(id)
-- OrderItems(id, order_id, product_id)
-- Products(id, category_id)
--
-- Problem:
-- Find all orders that include products from more than one category.
-- Return: order_id, category_count.

WITH order_categories AS (
  SELECT
    oi.order_id,
    COUNT(DISTINCT p.category_id) AS category_count
  FROM OrderItems oi
  JOIN Products p ON oi.product_id = p.id
  GROUP BY oi.order_id
)
SELECT
  order_id,
  category_count
FROM order_categories
WHERE category_count > 1
ORDER BY category_count DESC;

