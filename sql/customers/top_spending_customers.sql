-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
-- Products(id, category_id)
-- Categories(id, name)
--
-- Problem:
-- For each category, find the customer who spent the most in that 
category.
-- Return: category_name, customer_id, customer_name, total_spent.

WITH customer_category_spend AS (
  SELECT
    p.category_id,
    o.customer_id,
    SUM(oi.quantity * oi.unit_price) AS total_spent
  FROM OrderItems oi
  JOIN Orders o ON oi.order_id = o.id
  JOIN Products p ON oi.product_id = p.id
  GROUP BY p.category_id, o.customer_id
),
ranked AS (
  SELECT
    *,
    RANK() OVER (PARTITION BY category_id ORDER BY total_spent DESC) AS 
rnk
  FROM customer_category_spend
)
SELECT
  cat.name AS category_name,
  ccs.customer_id,
  cust.name AS customer_name,
  ccs.total_spent
FROM ranked ccs
JOIN Categories cat ON ccs.category_id = cat.id
JOIN Customers cust ON ccs.customer_id = cust.id
WHERE rnk = 1
ORDER BY category_name;

