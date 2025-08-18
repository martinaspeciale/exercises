-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer with at least 2 orders, compute their average number 
of days between consecutive orders.
-- Return: customer_id, customer_name, avg_days_between_orders.

WITH ordered AS (
  SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS 
prev_order_date
  FROM Orders
),
intervals AS (
  SELECT
    customer_id,
    EXTRACT(DAY FROM order_date - prev_order_date) AS gap_days
  FROM ordered
  WHERE prev_order_date IS NOT NULL
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  ROUND(AVG(i.gap_days), 2) AS avg_days_between_orders
FROM
  intervals i
  JOIN Customers c ON i.customer_id = c.id
GROUP BY
  c.id, c.name
ORDER BY
  avg_days_between_orders DESC;


