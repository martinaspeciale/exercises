-- Tables:
-- Products(id, name, category_id)
-- OrderItems(id, order_id, product_id, quantity)
--
-- Problem:
-- Find all products that have never been ordered.
-- Return: product_id, product_name.

SELECT
  p.id AS product_id,
  p.name AS product_name
FROM
  Products p
LEFT JOIN
  OrderItems oi ON p.id = oi.product_id
WHERE
  oi.id IS NULL
ORDER BY
  p.id;
