-- Tables:
-- Orders(id, order_date)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
-- Products(id, category_id)
-- Categories(id, name)
--
-- Problem:
-- Find categories where revenue increased for 3 consecutive months.
-- Return: category_id, category_name.

WITH monthly_revenue AS (
  SELECT
    p.category_id,
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
  FROM Orders o
  JOIN OrderItems oi ON o.id = oi.order_id
  JOIN Products p ON oi.product_id = p.id
  GROUP BY p.category_id, TO_CHAR(o.order_date, 'YYYY-MM')
),
ranked AS (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY month) AS rn
  FROM monthly_revenue
),
joined AS (
  SELECT
    a.category_id,
    a.revenue AS rev1,
    b.revenue AS rev2,
    c.revenue AS rev3
  FROM ranked a
  JOIN ranked b ON a.category_id = b.category_id AND a.rn + 1 = b.rn
  JOIN ranked c ON a.category_id = c.category_id AND a.rn + 2 = c.rn
)
SELECT DISTINCT
  cat.id AS category_id,
  cat.name AS category_name
FROM joined j
JOIN Categories cat ON j.category_id = cat.id
WHERE j.rev1 < j.rev2 AND j.rev2 < j.rev3;

