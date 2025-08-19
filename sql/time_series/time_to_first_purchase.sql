-- Tables:
-- Customers(id, created_at)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer, compute the number of days between signup and first 
order.
-- Return: customer_id, signup_date, first_order_date, 
days_to_first_purchase.

WITH first_orders AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order_date
  FROM Orders
  GROUP BY customer_id
)
SELECT
  c.id AS customer_id,
  c.created_at::date AS signup_date,
  fo.first_order_date::date,
  EXTRACT(DAY FROM fo.first_order_date - c.created_at) AS 
days_to_first_purchase
FROM Customers c
JOIN first_orders fo ON c.id = fo.customer_id
ORDER BY days_to_first_purchase;

