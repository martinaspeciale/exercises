-- Tables:
-- Customers(id, name)
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer, find the day of the week they most frequently place 
orders on.
-- Return: customer_id, customer_name, weekday, order_count.

WITH weekday_counts AS (
  SELECT
    o.customer_id,
    TO_CHAR(o.order_date, 'Day') AS weekday,
    COUNT(*) AS order_count,
    RANK() OVER (
      PARTITION BY o.customer_id ORDER BY COUNT(*) DESC
    ) AS rnk
  FROM Orders o
  GROUP BY o.customer_id, TO_CHAR(o.order_date, 'Day')
)
SELECT
  c.id AS customer_id,
  c.name AS customer_name,
  wc.weekday,
  wc.order_count
FROM weekday_counts wc
JOIN Customers c ON c.id = wc.customer_id
WHERE wc.rnk = 1
ORDER BY customer_id;

