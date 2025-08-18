-- Tables:
-- Customers(id, name, email)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- For each month in 2024, find the customer who spent the highest total amount.
-- Return: month (as YYYY-MM), customer_id, customer_name, total_spent
-- Order the results by month ascending.
-- Notes:
-- If multiple customers tie for the highest amount in a month, include all of them.

WITH monthly_totals AS (
  SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    to_char(o.order_date, 'YYYY-MM') AS month,
    SUM(o.total_amount) AS total_spent
  FROM
    Customers c
    JOIN Orders o ON c.id = o.customer_id
  WHERE
    o.order_date >= '2024-01-01'
    AND o.order_date < '2025-01-01'
  GROUP BY
    c.id, c.name, to_char(o.order_date, 'YYYY-MM')
),
ranked AS (
  SELECT
    month,
    customer_id,
    customer_name,
    total_spent,
    RANK() OVER (PARTITION BY month ORDER BY total_spent DESC) AS rnk
  FROM
    monthly_totals
)
SELECT
  month,
  customer_id,
  customer_name,
  total_spent
FROM
  ranked
WHERE
  rnk = 1
ORDER BY
  month ASC;
