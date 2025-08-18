-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- Find customers who have placed at least one order in two consecutive 
months in 2024.
-- Return: customer_id, customer_name
-- Notes:
-- Months are consecutive if they are adjacent in the calendar (e.g., 
January and February).

WITH customer_months AS (
  SELECT DISTINCT
    o.customer_id,
    to_char(o.order_date, 'YYYY-MM') AS month
  FROM
    Orders o
  WHERE
    o.order_date >= '2024-01-01'
    AND o.order_date < '2025-01-01'
),
numbered AS (
  SELECT
    customer_id,
    month,
    ROW_NUMBER() OVER (
      PARTITION BY customer_id ORDER BY month
    ) AS rn
  FROM
    customer_months
),
with_lag AS (
  SELECT
    customer_id,
    month,
    LAG(month) OVER (PARTITION BY customer_id ORDER BY month) AS 
prev_month
  FROM
    numbered
)
SELECT DISTINCT
  c.id AS customer_id,
  c.name AS customer_name
FROM
  with_lag wl
  JOIN Customers c ON wl.customer_id = c.id
WHERE
  prev_month IS NOT NULL
  AND (
    to_date(month, 'YYYY-MM') - interval '1 month' = to_date(prev_month, 
'YYYY-MM')
  )
ORDER BY
  customer_id;

