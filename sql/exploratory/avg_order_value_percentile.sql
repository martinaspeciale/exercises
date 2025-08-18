-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- For each customer, compute their average order value (AOV).
-- Then, assign a percentile rank to each customer's AOV among all 
customers.
-- Return: customer_id, customer_name, avg_order_value, percentile_rank 
(as 0-100 integer).

WITH customer_aov AS (
  SELECT
    customer_id,
    AVG(total_amount) AS avg_order_value
  FROM
    Orders
  GROUP BY
    customer_id
),
with_percentile AS (
  SELECT
    ca.customer_id,
    ca.avg_order_value,
    NTILE(100) OVER (ORDER BY ca.avg_order_value) AS percentile_rank
  FROM
    customer_aov ca
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  wp.avg_order_value,
  wp.percentile_rank
FROM
  with_percentile wp
  JOIN Customers c ON wp.customer_id = c.id
ORDER BY
  percentile_rank ASC;

