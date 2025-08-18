-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- Find customers who placed orders in **every quarter** of 2024.
-- Return: customer_id, customer_name.

WITH customer_quarters AS (
  SELECT DISTINCT
    customer_id,
    EXTRACT(QUARTER FROM order_date) AS q
  FROM Orders
  WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
),
quarter_counts AS (
  SELECT customer_id, COUNT(DISTINCT q) AS quarter_count
  FROM customer_quarters
  GROUP BY customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name
FROM quarter_counts qc
JOIN Customers c ON qc.customer_id = c.id
WHERE qc.quarter_count = 4;

