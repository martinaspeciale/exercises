-- Tables:
-- Orders(id, order_date, total_amount)
--
-- Problem:
-- Compute the **cumulative revenue** by day.
-- Return: order_date, daily_revenue, cumulative_revenue.

WITH daily AS (
  SELECT
    DATE(order_date) AS order_date,
    SUM(total_amount) AS daily_revenue
  FROM Orders
  GROUP BY DATE(order_date)
)
SELECT
  order_date,
  daily_revenue,
  SUM(daily_revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM daily
ORDER BY order_date;

