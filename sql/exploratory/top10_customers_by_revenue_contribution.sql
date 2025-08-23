-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, total_amount)
--
-- Problem:
-- Find the **top 10 customers** contributing the highest total revenue.
-- Return: customer_id, customer_name, total_revenue, contribution_pct.

WITH customer_revenue AS (
  SELECT
    o.customer_id,
    SUM(o.total_amount) AS total_revenue
  FROM Orders o
  GROUP BY o.customer_id
),
total_revenue AS (
  SELECT SUM(total_revenue) AS global_revenue FROM customer_revenue
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  cr.total_revenue,
  ROUND((cr.total_revenue / tr.global_revenue) * 100, 2) AS contribution_pct
FROM customer_revenue cr
JOIN Customers c ON cr.customer_id = c.id
CROSS JOIN total_revenue tr
ORDER BY total_revenue DESC
LIMIT 10;

