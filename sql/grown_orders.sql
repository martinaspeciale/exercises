-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- Find customers whose **total order amount increased** over time for at 
least 3 consecutive orders.
-- Return: customer_id, customer_name.

WITH ordered_orders AS (
  SELECT
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
  FROM Orders
),
joined_orders AS (
  SELECT
    a.customer_id,
    a.total_amount AS amt1,
    b.total_amount AS amt2,
    c.total_amount AS amt3
  FROM ordered_orders a
  JOIN ordered_orders b ON a.customer_id = b.customer_id AND a.rn + 1 = 
b.rn
  JOIN ordered_orders c ON a.customer_id = c.customer_id AND a.rn + 2 = 
c.rn
)
SELECT DISTINCT
  c.id AS customer_id,
  c.name AS customer_name
FROM joined_orders j
JOIN Customers c ON j.customer_id = c.id
WHERE j.amt1 < j.amt2 AND j.amt2 < j.amt3
ORDER BY customer_id;

