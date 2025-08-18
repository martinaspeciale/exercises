-- Tables:
-- Products(id, name)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
--
-- Problem:
-- Compute each product's revenue and its percentage contribution to total 
revenue.
-- Return: product_id, product_name, product_revenue, revenue_percent.

WITH product_revenue AS (
  SELECT
    p.id AS product_id,
    p.name AS product_name,
    SUM(oi.quantity * oi.unit_price) AS product_revenue
  FROM
    Products p
    JOIN OrderItems oi ON p.id = oi.product_id
  GROUP BY
    p.id, p.name
),
total AS (
  SELECT SUM(product_revenue) AS total_revenue FROM product_revenue
)
SELECT
  pr.product_id,
  pr.product_name,
  pr.product_revenue,
  ROUND(100.0 * pr.product_revenue / t.total_revenue, 2) AS 
revenue_percent
FROM
  product_revenue pr, total t
ORDER BY
  product_revenue DESC;

