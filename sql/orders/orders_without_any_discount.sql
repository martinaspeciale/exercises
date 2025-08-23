-- Tables:
-- Orders(id, total_amount, discount)
--
-- Problem:
-- Find all orders where no discount was applied and rank them by highest 
total_amount.
-- Return: order_id, total_amount.

SELECT
  id AS order_id,
  total_amount
FROM Orders
WHERE discount = 0 OR discount IS NULL
ORDER BY total_amount DESC;

