-- Tables:
-- Orders(id, order_date, total_amount)
--
-- Problem:
-- Calculate the **7-day rolling average** of daily revenue.
-- Return: order_date, daily_revenue, rolling_avg_7d.

WITH daily_revenue AS (
  SELECT
    DATE(order_date) AS order_date,
    SUM(total_amount) AS daily_revenue
  FROM Orders
  GROUP BY DATE(order_date)
)
SELECT
  order_date,
  daily_revenue,
  ROUND(
    AVG(daily_revenue) OVER (
      ORDER BY order_date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2
  ) AS rolling_avg_7d
FROM daily_revenue
ORDER BY order_date;

