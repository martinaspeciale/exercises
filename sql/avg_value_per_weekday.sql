-- Tables:
-- Orders(id, order_date, total_amount)
--
-- Problem:
-- Compute the average order value per weekday.
-- Return: weekday (e.g. 'Monday'), avg_order_value.

SELECT
  TO_CHAR(order_date, 'Day') AS weekday,
  ROUND(AVG(total_amount), 2) AS avg_order_value
FROM Orders
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY avg_order_value DESC;

