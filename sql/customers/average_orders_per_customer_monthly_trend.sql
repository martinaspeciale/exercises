-- Tables:
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each month, compute the average number of orders per customer.
-- Return: month (YYYY-MM), avg_orders_per_customer.

WITH monthly_orders AS (
  SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    customer_id,
    COUNT(*) AS order_count
  FROM Orders
  GROUP BY TO_CHAR(order_date, 'YYYY-MM'), customer_id
),
monthly_summary AS (
  SELECT
    month,
    AVG(order_count)::numeric(10,2) AS avg_orders_per_customer
  FROM monthly_orders
  GROUP BY month
)
SELECT * FROM monthly_summary ORDER BY month;

