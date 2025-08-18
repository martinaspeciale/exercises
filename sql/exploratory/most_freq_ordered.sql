-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id)
-- OrderItems(id, order_id, product_id, quantity)
-- Products(id, name)
--
-- Problem:
-- For each customer, find the product they have ordered the most (by 
quantity).
-- Return: customer_id, customer_name, product_id, product_name, 
total_quantity.

WITH customer_products AS (
  SELECT
    o.customer_id,
    oi.product_id,
    SUM(oi.quantity) AS total_quantity,
    RANK() OVER (PARTITION BY o.customer_id ORDER BY SUM(oi.quantity) 
DESC) AS rnk
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
  GROUP BY o.customer_id, oi.product_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  cp.product_id,
  p.name AS product_name,
  cp.total_quantity
FROM customer_products cp
JOIN Customers c ON cp.customer_id = c.id
JOIN Products p ON cp.product_id = p.id
WHERE cp.rnk = 1
ORDER BY customer_id;

