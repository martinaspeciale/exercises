-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id)
-- OrderItems(id, order_id, product_id)
--
-- Problem:
-- Find customers who never ordered the same product more than once.
-- Return: customer_id, customer_name.

WITH customer_products AS (
  SELECT
    o.customer_id,
    oi.product_id,
    COUNT(*) AS order_count
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
  GROUP BY o.customer_id, oi.product_id
),
repeat_check AS (
  SELECT customer_id
  FROM customer_products
  WHERE order_count > 1
  GROUP BY customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name
FROM Customers c
WHERE c.id NOT IN (SELECT customer_id FROM repeat_check)
ORDER BY customer_id;

