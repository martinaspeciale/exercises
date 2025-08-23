-- Tables:
-- Orders(id, order_date, total_amount, total_cost)
--
-- Problem:
-- Calculate the **profit margin per month** as:
--   profit_margin = (total_revenue - total_cost) / total_revenue
-- Return: month (YYYY-MM), total_revenue, total_cost, profit_margin.

WITH monthly_data AS (
  SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(total_amount) AS total_revenue,
    SUM(total_cost) AS total_cost
  FROM Orders
  GROUP BY TO_CHAR(order_date, 'YYYY-MM')
)
SELECT
  month,
  total_revenue,
  total_cost,
  ROUND((total_revenue - total_cost) / total_revenue, 3) AS profit_margin
FROM monthly_data
ORDER BY month;

