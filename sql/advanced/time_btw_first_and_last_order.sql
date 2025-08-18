-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer, calculate the number of days between their first and 
last order.
-- Return: customer_id, customer_name, days_between_orders.

WITH order_bounds AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order
  FROM
    Orders
  GROUP BY
    customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  EXTRACT(DAY FROM ob.last_order - ob.first_order) AS days_between_orders
FROM
  order_bounds ob
  JOIN Customers c ON ob.customer_id = c.id
WHERE
  ob.first_order <> ob.last_order
ORDER BY
  days_between_orders DESC;

