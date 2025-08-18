-- Tables:
-- Orders(id, order_date)
--
-- Problem:
-- Find the day of the week with the most orders.
-- Return: weekday (e.g., 'Monday'), order_count.

SELECT
  TO_CHAR(order_date, 'Day') AS weekday,
  COUNT(*) AS order_count
FROM
  Orders
GROUP BY
  TO_CHAR(order_date, 'Day')
ORDER BY
  order_count DESC
LIMIT 1;

