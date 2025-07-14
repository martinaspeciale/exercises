-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- For each customer, compute:
-- - total_spent (sum of total_amount)
-- - avg_order_value (average total_amount)
-- - tier (label as 'High' if total_spent > 1000, 'Medium' if between 500 and 1000, 'Low' otherwise)
-- Return: customer_id, customer_name, total_spent, avg_order_value, tier.

WITH customer_stats AS (
  SELECT
    c.id AS customer_id,
    c.name AS customer_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS avg_order_value
  FROM
    Customers c
  LEFT JOIN
    Orders o ON c.id = o.customer_id
  GROUP BY
    c.id, c.name
)
SELECT
  customer_id,
  customer_name,
  total_spent,
  avg_order_value,
  CASE
    WHEN total_spent > 1000 THEN 'High'
    WHEN total_spent BETWEEN 500 AND 1000 THEN 'Medium'
    ELSE 'Low'
  END AS tier
FROM
  customer_stats
ORDER BY
  total_spent DESC;
