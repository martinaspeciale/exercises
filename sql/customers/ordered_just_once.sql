-- Tables:
-- Products(id, name)
-- OrderItems(id, order_id, product_id)
-- Orders(id, customer_id)
--
-- Problem:
-- Find all products that have only ever been ordered by one unique 
customer.
-- Return: product_id, product_name, customer_id.

WITH product_customers AS (
  SELECT
    oi.product_id,
    o.customer_id
  FROM
    OrderItems oi
    JOIN Orders o ON oi.order_id = o.id
  GROUP BY
    oi.product_id, o.customer_id
),
customer_counts AS (
  SELECT
    product_id,
    COUNT(DISTINCT customer_id) AS customer_count,
    MIN(customer_id) AS customer_id -- just to show which one
  FROM
    product_customers
  GROUP BY
    product_id
)
SELECT
  p.id AS product_id,
  p.name AS product_name,
  cc.customer_id
FROM
  customer_counts cc
  JOIN Products p ON cc.product_id = p.id
WHERE
  cc.customer_count = 1
ORDER BY
  product_id;

