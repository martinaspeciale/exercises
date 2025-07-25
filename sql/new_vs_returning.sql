-- Tables:
-- Customers(id)
-- Orders(id, customer_id, order_date, total_amount)
--
-- Problem:
-- Classify each order as 'New' if it's the customer's first order, else 
'Returning'.
-- Compute total revenue from new vs returning customers.
-- Return: customer_type, total_revenue.

WITH first_orders AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order_date
  FROM Orders
  GROUP BY customer_id
),
classified AS (
  SELECT
    o.id AS order_id,
    CASE
      WHEN o.order_date = f.first_order_date THEN 'New'
      ELSE 'Returning'
    END AS customer_type,
    o.total_amount
  FROM Orders o
  JOIN first_orders f ON o.customer_id = f.customer_id
)
SELECT
  customer_type,
  SUM(total_amount) AS total_revenue
FROM classified
GROUP BY customer_type;

