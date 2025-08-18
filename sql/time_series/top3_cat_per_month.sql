-- Tables:
-- Categories(id, name)
-- Products(id, category_id)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
-- Orders(id, order_date)
--
-- Problem:
-- For each month, return the **top 3 categories** by revenue.
-- Return: month (YYYY-MM), category_id, category_name, revenue.

WITH category_revenue AS (
  SELECT
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    c.id AS category_id,
    c.name AS category_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
  FROM OrderItems oi
  JOIN Orders o ON oi.order_id = o.id
  JOIN Products p ON oi.product_id = p.id
  JOIN Categories c ON p.category_id = c.id
  GROUP BY TO_CHAR(o.order_date, 'YYYY-MM'), c.id, c.name
),
ranked AS (
  SELECT *,
         RANK() OVER (PARTITION BY month ORDER BY revenue DESC) AS rnk
  FROM category_revenue
)
SELECT
  month,
  category_id,
  category_name,
  revenue
FROM ranked
WHERE rnk <= 3
ORDER BY month, rnk;

