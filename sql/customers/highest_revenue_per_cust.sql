-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, total_amount)
--
-- Problem:
-- For each customer, find the **order** with the highest total_amount.
-- Return: customer_id, customer_name, order_id, total_amount.

WITH ranked_orders AS (
  SELECT
    o.customer_id,
    o.id AS order_id,
    o.total_amount,
    RANK() OVER (PARTITION BY o.customer_id ORDER BY o.total_amount DESC) 
AS rnk
  FROM Orders o
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  ro.order_id,
  ro.total_amount
FROM ranked_orders ro
JOIN Customers c ON ro.customer_id = c.id
WHERE ro.rnk = 1
ORDER BY customer_id;

