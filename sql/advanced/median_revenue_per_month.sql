-- Tables:
-- Orders(id, order_date, total_amount)
--
-- Problem:
-- Calculate the **median monthly revenue** across all months.
-- Return: month (YYYY-MM), median_revenue.

WITH monthly_revenue AS (
  SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(total_amount) AS revenue
  FROM Orders
  GROUP BY TO_CHAR(order_date, 'YYYY-MM')
),
ranked AS (
  SELECT
    month,
    revenue,
    ROW_NUMBER() OVER (ORDER BY revenue) AS rn,
    COUNT(*) OVER () AS total_months
  FROM monthly_revenue
)
SELECT
  month,
  revenue AS median_revenue
FROM ranked
WHERE rn = (total_months + 1) / 2
   OR rn = (total_months + 2) / 2;

