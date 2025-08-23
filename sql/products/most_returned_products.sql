-- Tables:
-- Products(id, name)
-- Returns(id, product_id, quantity)
--
-- Problem:
-- Find the top 5 products with the highest total return quantity.
-- Return: product_id, product_name, total_returned.

SELECT
  p.id AS product_id,
  p.name AS product_name,
  SUM(r.quantity) AS total_returned
FROM Returns r
JOIN Products p ON r.product_id = p.id
GROUP BY p.id, p.name
ORDER BY total_returned DESC
LIMIT 5;

