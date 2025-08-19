-- Tables:
-- Customers(id, segment)
-- Orders(id, customer_id)
-- OrderItems(id, order_id, product_id, quantity)
-- Products(id, name)
--
-- Problem:
-- For each customer segment, return the most frequently purchased 
product.
-- Return: segment, product_id, product_name, total_quantity.

WITH segment_products AS (
  SELECT
    c.segment,
    oi.product_id,
    SUM(oi.quantity) AS total_quantity,
    RANK() OVER (PARTITION BY c.segment ORDER BY SUM(oi.quantity) DESC) AS 
rnk
  FROM Customers c
  JOIN Orders o ON c.id = o.customer_id
  JOIN OrderItems oi ON o.id = oi.order_id
  GROUP BY c.segment, oi.product_id
)
SELECT
  sp.segment,
  sp.product_id,
  p.name AS product_name,
  sp.total_quantity
FROM segment_products sp
JOIN Products p ON sp.product_id = p.id
WHERE sp.rnk = 1
ORDER BY sp.segment;

