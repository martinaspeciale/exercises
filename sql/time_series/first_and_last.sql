-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
-- OrderItems(id, order_id, product_id)
-- Products(id, name)
--
-- Problem:
-- For each customer, return the first and last product they ever ordered.
-- Return: customer_id, customer_name, first_product_id, 
first_product_name, last_product_id, last_product_name.

WITH product_orders AS (
  SELECT
    o.customer_id,
    oi.product_id,
    o.order_date,
    ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date 
ASC) AS rn_first,
    ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date 
DESC) AS rn_last
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
),
first_last AS (
  SELECT
    customer_id,
    MAX(CASE WHEN rn_first = 1 THEN product_id END) AS first_product_id,
    MAX(CASE WHEN rn_last = 1 THEN product_id END) AS last_product_id
  FROM product_orders
  GROUP BY customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  f.first_product_id,
  fp.name AS first_product_name,
  f.last_product_id,
  lp.name AS last_product_name
FROM first_last f
JOIN Customers c ON f.customer_id = c.id
LEFT JOIN Products fp ON f.first_product_id = fp.id
LEFT JOIN Products lp ON f.last_product_id = lp.id;

