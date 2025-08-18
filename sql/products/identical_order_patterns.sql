-- Tables:
-- Orders(id, customer_id, order_date)
-- OrderItems(id, order_id, product_id)
--
-- Problem:
-- Find pairs of customers who have ordered exactly the same set of 
products.
-- Return: customer_id_1, customer_id_2.

WITH customer_products AS (
  SELECT DISTINCT o.customer_id, oi.product_id
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
),
product_sets AS (
  SELECT customer_id, STRING_AGG(product_id::TEXT, ',' ORDER BY 
product_id) AS product_signature
  FROM customer_products
  GROUP BY customer_id
)
SELECT
  a.customer_id AS customer_id_1,
  b.customer_id AS customer_id_2
FROM product_sets a
JOIN product_sets b ON a.product_signature = b.product_signature AND 
a.customer_id < b.customer_id
ORDER BY customer_id_1, customer_id_2;

