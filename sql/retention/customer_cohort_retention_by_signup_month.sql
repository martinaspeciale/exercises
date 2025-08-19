-- Tables:
-- Customers(id, created_at)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer signup month, count how many customers placed an 
order in the 2nd and 3rd month after signup.
-- Return: cohort_month, retained_month_2, retained_month_3.

WITH cohorts AS (
  SELECT
    id AS customer_id,
    DATE_TRUNC('month', created_at) AS cohort_month
  FROM Customers
),
orders_by_month AS (
  SELECT
    o.customer_id,
    DATE_TRUNC('month', o.order_date) AS order_month
  FROM Orders o
),
joined AS (
  SELECT
    c.cohort_month,
    DATE_PART('month', obm.order_month) - DATE_PART('month', 
c.cohort_month) AS month_diff,
    c.customer_id
  FROM cohorts c
  JOIN orders_by_month obm ON c.customer_id = obm.customer_id
  WHERE DATE_PART('year', obm.order_month) = DATE_PART('year', 
c.cohort_month)
)
SELECT
  cohort_month,
  COUNT(DISTINCT CASE WHEN month_diff = 1 THEN customer_id END) AS 
retained_month_2,
  COUNT(DISTINCT CASE WHEN month_diff = 2 THEN customer_id END) AS 
retained_month_3
FROM joined
GROUP BY cohort_month
ORDER BY cohort_month;

