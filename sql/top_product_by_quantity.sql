-- Tables:
-- OrderItems(id, order_id, product_id, quantity)
-- Products(id, name)
--
-- Problem:
-- For each order, find the product with the highest quantity.
-- Return: order_id, product_id, product_name, quantity.

WITH ranked_items AS (
  SELECT
    oi.order_id,
    oi.product_id,
    p.name AS product_name,
    oi.quantity,
    RANK() OVER (PARTITION BY oi.order_id ORDER BY oi.quantity DESC) AS 
rnk
  FROM OrderItems oi
  JOIN Products p ON oi.product_id = p.id
)
SELECT
  order_id,
  product_id,
  product_name,
  quantity
FROM ranked_items
WHERE rnk = 1
ORDER BY order_id;

