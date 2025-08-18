-- Tables:
-- Products(id, name, category_id)
-- Categories(id, name)
-- OrderItems(id, order_id, product_id)
-- Orders(id, order_date)
--
-- Problem:
-- For each product category, find the earliest date a product from that 
category was ever ordered.
-- Return: category_id, category_name, first_order_date.

SELECT
  c.id AS category_id,
  c.name AS category_name,
  MIN(o.order_date) AS first_order_date
FROM
  OrderItems oi
  JOIN Products p ON oi.product_id = p.id
  JOIN Categories c ON p.category_id = c.id
  JOIN Orders o ON oi.order_id = o.id
GROUP BY
  c.id, c.name
ORDER BY
  first_order_date;

