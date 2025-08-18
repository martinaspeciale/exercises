-- Tables:
-- Orders(id)
-- OrderItems(id, order_id, quantity)
--
-- Problem:
-- Find orders where the **total quantity of items** is more than 3x the 
average.
-- Return: order_id, total_quantity.

WITH order_totals AS (
  SELECT order_id, SUM(quantity) AS total_quantity
  FROM OrderItems
  GROUP BY order_id
),
overall_avg AS (
  SELECT AVG(total_quantity) AS avg_quantity FROM order_totals
)
SELECT
  ot.order_id,
  ot.total_quantity
FROM order_totals ot, overall_avg oa
WHERE ot.total_quantity > 3 * oa.avg_quantity
ORDER BY total_quantity DESC;

