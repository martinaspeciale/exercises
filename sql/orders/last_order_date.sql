-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer, find their last order date.
-- Return: customer_id, customer_name, last_order_date.

SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  MAX(o.order_date) AS last_order_date
FROM
  Customers c
  LEFT JOIN Orders o ON c.id = o.customer_id
GROUP BY
  c.id, c.name
ORDER BY
  last_order_date DESC NULLS LAST;

