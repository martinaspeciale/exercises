-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id)
-- OrderItems(id, order_id, product_id)
-- Products(id, name, category_id)
--
-- Problem:
-- For a given category (e.g. category_id = 1), find all customers who 
have ordered **every product** in that category.
-- Return: customer_id, customer_name.

WITH category_products AS (
  SELECT id AS product_id
  FROM Products
  WHERE category_id = 1
),
customer_product_orders AS (
  SELECT DISTINCT
    o.customer_id,
    oi.product_id
  FROM
    Orders o
    JOIN OrderItems oi ON o.id = oi.order_id
  WHERE
    oi.product_id IN (SELECT product_id FROM category_products)
),
customer_coverage AS (
  SELECT
    customer_id,
    COUNT(DISTINCT product_id) AS products_ordered
  FROM
    customer_product_orders
  GROUP BY
    customer_id
),
total_products AS (
  SELECT COUNT(*) AS total FROM category_products
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name
FROM
  customer_coverage cc
  JOIN total_products tp ON cc.products_ordered = tp.total
  JOIN Customers c ON cc.customer_id = c.id
ORDER BY
  customer_id;

