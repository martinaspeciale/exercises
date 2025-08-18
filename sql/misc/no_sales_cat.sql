-- Tables:
-- Categories(id, name)
-- Products(id, name, category_id)
-- OrderItems(id, order_id, product_id, quantity)
--
-- Problem:
-- Find all product categories that have never had a product sold.
-- Return: category_id, category_name.

SELECT
  c.id AS category_id,
  c.name AS category_name
FROM
  Categories c
LEFT JOIN Products p ON c.id = p.category_id
LEFT JOIN OrderItems oi ON p.id = oi.product_id
WHERE
  oi.id IS NULL
ORDER BY
  c.id;

