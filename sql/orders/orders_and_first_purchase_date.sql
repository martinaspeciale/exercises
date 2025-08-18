-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- For each order, add the customer's first-ever order date.
-- Return: order_id, customer_id, order_date, first_order_date.

WITH first_orders AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order_date
  FROM
    Orders
  GROUP BY
    customer_id
)
SELECT
  o.id AS order_id,
  o.customer_id,
  o.order_date,
  f.first_order_date
FROM
  Orders o
  JOIN first_orders f ON o.customer_id = f.customer_id
ORDER BY
  o.order_date;
