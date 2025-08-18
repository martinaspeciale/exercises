-- Tables:
-- Products(id, name, category_id)
-- Categories(id, name)
-- OrderItems(id, order_id, product_id, quantity)
--
-- Problem:
-- For each product category, find the top 3 products with the highest total quantity sold.
-- Return: category_name, product_id, product_name, total_quantity_sold
-- Order the output by category_name, total_quantity_sold descending.
-- Notes:
-- Use a window function to rank products within each category.

WITH product_sales AS (
  SELECT
    p.id AS product_id,
    p.name AS product_name,
    c.id AS category_id,
    c.name AS category_name,
    SUM(oi.quantity) AS total_quantity_sold
  FROM
    Products p
    JOIN Categories c ON p.category_id = c.id
    JOIN OrderItems oi ON p.id = oi.product_id
  GROUP BY
    p.id, p.name, c.id, c.name
),
ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY category_id
      ORDER BY total_quantity_sold DESC
    ) AS rnk
  FROM
    product_sales
)
SELECT
  category_name,
  product_id,
  product_name,
  total_quantity_sold
FROM
  ranked
WHERE
  rnk <= 3
ORDER BY
  category_name ASC,
  total_quantity_sold DESC;
