-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer with at least 2 orders, find the longest number of 
days between two consecutive orders.
-- Return: customer_id, customer_name, max_days_between_orders.

WITH ordered_dates AS (
  SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS 
previous_order
  FROM
    Orders
),
gaps AS (
  SELECT
    customer_id,
    order_date,
    previous_order,
    EXTRACT(DAY FROM order_date - previous_order) AS days_between
  FROM
    ordered_dates
  WHERE
    previous_order IS NOT NULL
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  MAX(g.days_between) AS max_days_between_orders
FROM
  gaps g
  JOIN Customers c ON g.customer_id = c.id
GROUP BY
  c.id, c.name
ORDER BY
  max_days_between_orders DESC;

