-- Tables:
-- Products(id, name)
-- OrderItems(id, order_id, product_id, quantity)
-- Orders(id, order_date)
--
-- Problem:
-- For each month, find the product with the highest total quantity sold.
-- Return: month (YYYY-MM), product_id, product_name, total_quantity.

WITH monthly_sales AS (
  SELECT
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    p.id AS product_id,
    p.name AS product_name,
    SUM(oi.quantity) AS total_quantity,
    RANK() OVER (
      PARTITION BY TO_CHAR(o.order_date, 'YYYY-MM')
      ORDER BY SUM(oi.quantity) DESC
    ) AS rnk
  FROM
    OrderItems oi
    JOIN Orders o ON oi.order_id = o.id
    JOIN Products p ON oi.product_id = p.id
  GROUP BY
    TO_CHAR(o.order_date, 'YYYY-MM'), p.id, p.name
)
SELECT
  month,
  product_id,
  product_name,
  total_quantity
FROM
  monthly_sales
WHERE
  rnk = 1
ORDER BY
  month;

