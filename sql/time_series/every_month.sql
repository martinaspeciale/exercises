-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- Find customers who placed at least one order in **every month of 
2024**.
-- Return: customer_id, customer_name.

WITH customer_months AS (
  SELECT
    customer_id,
    TO_CHAR(order_date, 'YYYY-MM') AS month
  FROM Orders
  WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
  GROUP BY customer_id, TO_CHAR(order_date, 'YYYY-MM')
),
month_counts AS (
  SELECT customer_id, COUNT(DISTINCT month) AS month_count
  FROM customer_months
  GROUP BY customer_id
)
SELECT c.id AS customer_id, c.name AS customer_name
FROM month_counts mc
JOIN Customers c ON c.id = mc.customer_id
WHERE mc.month_count = 12;

