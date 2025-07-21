-- Tables:
-- Products(id, category_id)
-- Categories(id, name)
-- OrderItems(id, order_id, product_id, quantity)
-- Orders(id, order_date)
--
-- Problem:
-- For each category and month, compute total quantity sold.
-- Return: category_id, category_name, month (YYYY-MM), total_quantity.

SELECT
  c.id AS category_id,
  c.name AS category_name,
  TO_CHAR(o.order_date, 'YYYY-MM') AS month,
  SUM(oi.quantity) AS total_quantity
FROM
  OrderItems oi
  JOIN Orders o ON oi.order_id = o.id
  JOIN Products p ON oi.product_id = p.id
  JOIN Categories c ON p.category_id = c.id
GROUP BY
  c.id, c.name, TO_CHAR(o.order_date, 'YYYY-MM')
ORDER BY
  category_id, month;

