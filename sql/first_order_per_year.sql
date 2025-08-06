-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- For each customer and year, find their **first order of that year**.
-- Return: customer_id, customer_name, year, order_id, order_date, 
total_amount.

WITH ranked_orders AS (
  SELECT
    o.customer_id,
    c.name AS customer_name,
    EXTRACT(YEAR FROM o.order_date) AS year,
    o.id AS order_id,
    o.order_date,
    o.total_amount,
    ROW_NUMBER() OVER (
      PARTITION BY o.customer_id, EXTRACT(YEAR FROM o.order_date)
      ORDER BY o.order_date
    ) AS rn
  FROM Orders o
  JOIN Customers c ON o.customer_id = c.id
)
SELECT
  customer_id,
  customer_name,
  year,
  order_id,
  order_date,
  total_amount
FROM ranked_orders
WHERE rn = 1
ORDER BY customer_id, year;

