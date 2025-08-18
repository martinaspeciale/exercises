-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- Find customers who have placed an order in **July** every year from 
2022 to 2024.
-- Return: customer_id, customer_name.

WITH july_orders AS (
  SELECT DISTINCT
    customer_id,
    EXTRACT(YEAR FROM order_date) AS year
  FROM Orders
  WHERE EXTRACT(MONTH FROM order_date) = 7
    AND EXTRACT(YEAR FROM order_date) IN (2022, 2023, 2024)
),
year_counts AS (
  SELECT
    customer_id,
    COUNT(DISTINCT year) AS year_count
  FROM july_orders
  GROUP BY customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name
FROM year_counts yc
JOIN Customers c ON c.id = yc.customer_id
WHERE yc.year_count = 3;

