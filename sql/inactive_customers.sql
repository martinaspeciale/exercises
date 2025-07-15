-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- List customers with no orders in the last 6 months.
-- Assume today's date is '2025-07-01'.
-- Return: customer_id, customer_name.

SELECT
  c.id AS customer_id,
  c.name AS customer_name
FROM
  Customers c
LEFT JOIN (
  SELECT DISTINCT customer_id
  FROM Orders
  WHERE order_date >= '2025-01-01'
) recent ON c.id = recent.customer_id
WHERE
  recent.customer_id IS NULL
ORDER BY
  c.id;

