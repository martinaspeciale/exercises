-- Tables:
-- Orders(id, order_date)
--
-- Problem:
-- Find missing order IDs in the sequence of Orders.
-- Return: missing_order_id.

SELECT
  gs.id AS missing_order_id
FROM generate_series(
  (SELECT MIN(id) FROM Orders),
  (SELECT MAX(id) FROM Orders)
) gs(id)
LEFT JOIN Orders o ON gs.id = o.id
WHERE o.id IS NULL
ORDER BY missing_order_id;

