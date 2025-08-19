-- Tables:
-- Orders(id, total_amount, status)
--
-- Problem:
-- Calculate the total revenue lost due to canceled orders.
-- Return: total_lost_revenue.

SELECT
  SUM(total_amount) AS total_lost_revenue
FROM Orders
WHERE status = 'canceled';

