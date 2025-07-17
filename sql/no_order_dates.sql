-- Tables:
-- Orders(id, order_date)
--
-- Problem:
-- Generate a list of all dates in June 2025 with no orders.
-- Return: missing_date.

WITH all_dates AS (
  SELECT
    generate_series(DATE '2025-06-01', DATE '2025-06-30', interval '1 
day')::date AS missing_date
),
order_dates AS (
  SELECT DISTINCT DATE(order_date) AS order_date
  FROM Orders
)
SELECT
  ad.missing_date
FROM
  all_dates ad
LEFT JOIN
  order_dates od ON ad.missing_date = od.order_date
WHERE
  od.order_date IS NULL
ORDER BY
  ad.missing_date;

