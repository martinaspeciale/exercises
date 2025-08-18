-- Tables:
-- Products(id, name, category_id)
-- Categories(id, name)
-- OrderItems(id, order_id, product_id, quantity, unit_price)
--
-- Problem:
-- Compute total revenue per product category.
-- Return: category_id, category_name, total_revenue.

SELECT
  c.id AS category_id,
  c.name AS category_name,
  SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM
  OrderItems oi
  JOIN Products p ON oi.product_id = p.id
  JOIN Categories c ON p.category_id = c.id
GROUP BY
  c.id, c.name
ORDER BY
  total_revenue DESC;

