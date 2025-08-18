-- Tables:
-- Orders(id, order_date)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
-- Products(id, category_id)
-- Categories(id, name)
--
-- Problem:
-- Compute total revenue per category in the most recent quarter (based on 
latest order_date).
-- Return: category_id, category_name, total_revenue.

WITH latest_order AS (
  SELECT MAX(order_date) AS max_date FROM Orders
),
quarter_bounds AS (
  SELECT
    DATE_TRUNC('quarter', max_date) AS start_date,
    (DATE_TRUNC('quarter', max_date) + INTERVAL '3 months') AS end_date
  FROM latest_order
),
filtered_orders AS (
  SELECT o.id
  FROM Orders o, quarter_bounds q
  WHERE o.order_date >= q.start_date AND o.order_date < q.end_date
)
SELECT
  c.id AS category_id,
  c.name AS category_name,
  SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM filtered_orders fo
JOIN OrderItems oi ON fo.id = oi.order_id
JOIN Products p ON oi.product_id = p.id
JOIN Categories c ON p.category_id = c.id
GROUP BY c.id, c.name
ORDER BY total_revenue DESC;

