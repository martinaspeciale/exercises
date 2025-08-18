-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- For each month, list the top 3 customers by revenue.
-- Return: month (YYYY-MM), customer_id, customer_name, total_revenue.

WITH monthly_revenue AS (
  SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    customer_id,
    SUM(total_amount) AS total_revenue
  FROM Orders
  GROUP BY TO_CHAR(order_date, 'YYYY-MM'), customer_id
),
ranked AS (
  SELECT
    mr.*,
    RANK() OVER (PARTITION BY month ORDER BY total_revenue DESC) AS rnk
  FROM monthly_revenue mr
)
SELECT
  r.month,
  r.customer_id,
  c.name AS customer_name,
  r.total_revenue
FROM
  ranked r
  JOIN Customers c ON r.customer_id = c.id
WHERE
  r.rnk <= 3
ORDER BY
  r.month, r.rnk;

