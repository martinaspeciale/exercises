-- Tables:
-- Orders(id, order_date)
-- OrderItems(id, order_id, product_id)
-- Products(id, category_id)
-- Categories(id, name)
--
-- Problem:
-- For each category, compute the **average time (in days)** between 
orders of products in that category.
-- Return: category_id, category_name, avg_days_between_orders.

WITH category_orders AS (
  SELECT DISTINCT
    p.category_id,
    o.order_date
  FROM OrderItems oi
  JOIN Orders o ON oi.order_id = o.id
  JOIN Products p ON oi.product_id = p.id
),
ranked AS (
  SELECT
    category_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY category_id ORDER BY order_date) AS 
prev_order
  FROM category_orders
),
gaps AS (
  SELECT
    category_id,
    EXTRACT(DAY FROM order_date - prev_order) AS gap
  FROM ranked
  WHERE prev_order IS NOT NULL
)
SELECT
  c.id AS category_id,
  c.name AS category_name,
  ROUND(AVG(g.gap), 2) AS avg_days_between_orders
FROM gaps g
JOIN Categories c ON g.category_id = c.id
GROUP BY c.id, c.name
ORDER BY avg_days_between_orders;

