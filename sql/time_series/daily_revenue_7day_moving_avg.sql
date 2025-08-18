-- Tables:
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- Compute total revenue per day and its 7-day moving average.
-- Return: order_day, daily_revenue, moving_avg_7d.

WITH daily_revenue AS (
  SELECT
    DATE(order_date) AS order_day,
    SUM(total_amount) AS daily_revenue
  FROM
    Orders
  GROUP BY
    DATE(order_date)
)
SELECT
  order_day,
  daily_revenue,
  ROUND(AVG(daily_revenue) OVER (
    ORDER BY order_day
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
  ), 2) AS moving_avg_7d
FROM
  daily_revenue
ORDER BY
  order_day;
