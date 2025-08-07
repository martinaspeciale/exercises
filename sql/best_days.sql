-- Tables:
-- Customers(id, name, created_at)
--
-- Problem:
-- Find the 5 days with the highest number of new customer signups.
-- Return: signup_date, customer_count.

SELECT
  DATE(created_at) AS signup_date,
  COUNT(*) AS customer_count
FROM Customers
GROUP BY DATE(created_at)
ORDER BY customer_count DESC
LIMIT 5;


