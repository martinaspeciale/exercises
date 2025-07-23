-- Tables:
-- Orders(id)
-- OrderItems(id, order_id)
--
-- Problem:
-- Find all orders that have no items — abandoned carts.
-- Return: order_id.

SELECT o.id AS order_id
FROM Orders o
LEFT JOIN OrderItems oi ON o.id = oi.order_id
WHERE oi.id IS NULL
ORDER BY o.id;

