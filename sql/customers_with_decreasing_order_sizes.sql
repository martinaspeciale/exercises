-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- Find customers with 3 consecutive orders where the total amount 
strictly decreased.
-- Return: customer_id, customer_name.

WITH ranked_orders AS (
  SELECT
    customer_id,
    total_amount,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
  FROM Orders
),
joined AS (
  SELECT
    a.customer_id,
    a.total_amount AS amt1,
    b.total_amount AS amt2,
    c.total_amount AS amt3
  FROM ranked_orders a
  JOIN ranked_orders b ON a.customer_id = b.customer_id AND a.rn + 1 = 
b.rn
  JOIN ranked_orders c ON a.customer_id = c.customer_id AND a.rn + 2 = 
c.rn
)
SELECT DISTINCT
  c.id AS customer_id,
  c.name AS customer_name
FROM joined j
JOIN Customers c ON j.customer_id = c.id
WHERE j.amt1 > j.amt2 AND j.amt2 > j.amt3;

