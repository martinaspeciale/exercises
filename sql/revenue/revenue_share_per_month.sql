-- Tables:
-- Products(id, category_id)
-- Categories(id, name)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
-- Orders(id, order_date)
--
-- Problem:
-- For each month and category, compute total revenue and its % share of 
that month’s total.
-- Return: month (YYYY-MM), category_name, category_revenue, 
revenue_share_percent.

WITH monthly_category_revenue AS (
  SELECT
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    c.name AS category_name,
    SUM(oi.quantity * oi.unit_price) AS category_revenue
  FROM OrderItems oi
  JOIN Orders o ON oi.order_id = o.id
  JOIN Products p ON oi.product_id = p.id
  JOIN Categories c ON p.category_id = c.id
  GROUP BY TO_CHAR(o.order_date, 'YYYY-MM'), c.name
),
monthly_totals AS (
  SELECT
    month,
    SUM(category_revenue) AS total_revenue
  FROM monthly_category_revenue
  GROUP BY month
)
SELECT
  mcr.month,
  mcr.category_name,
  mcr.category_revenue,
  ROUND(100.0 * mcr.category_revenue / mt.total_revenue, 2) AS 
revenue_share_percent
FROM monthly_category_revenue mcr
JOIN monthly_totals mt ON mcr.month = mt.month
ORDER BY mcr.month, revenue_share_percent DESC;

