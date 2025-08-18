-- Tables:
-- Orders(id, order_date)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
-- Products(id, name)
--
-- Problem:
-- For each year, return the product that generated the highest total 
revenue.
-- Return: year, product_id, product_name, revenue.

WITH yearly_revenue AS (
  SELECT
    EXTRACT(YEAR FROM o.order_date) AS year,
    oi.product_id,
    SUM(oi.quantity * oi.unit_price) AS revenue
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
  GROUP BY EXTRACT(YEAR FROM o.order_date), oi.product_id
),
ranked AS (
  SELECT *,
         RANK() OVER (PARTITION BY year ORDER BY revenue DESC) AS rnk
  FROM yearly_revenue
)
SELECT
  y.year,
  y.product_id,
  p.name AS product_name,
  y.revenue
FROM ranked y
JOIN Products p ON y.product_id = p.id
WHERE rnk = 1
ORDER BY year;

