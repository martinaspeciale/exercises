-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- Classify each customer based on their order count:
-- - 'Frequent' if >10 orders
-- - 'Regular' if 5–10 orders
-- - 'Occasional' if 1–4 orders
-- - 'Inactive' if 0 orders
-- Return: customer_id, customer_name, order_count, frequency_label.

WITH order_counts AS (
  SELECT
    customer_id,
    COUNT(*) AS order_count
  FROM
    Orders
  GROUP BY
    customer_id
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  COALESCE(oc.order_count, 0) AS order_count,
  CASE
    WHEN COALESCE(oc.order_count, 0) > 10 THEN 'Frequent'
    WHEN COALESCE(oc.order_count, 0) BETWEEN 5 AND 10 THEN 'Regular'
    WHEN COALESCE(oc.order_count, 0) BETWEEN 1 AND 4 THEN 'Occasional'
    ELSE 'Inactive'
  END AS frequency_label
FROM
  Customers c
LEFT JOIN order_counts oc ON c.id = oc.customer_id
ORDER BY
  order_count DESC;

