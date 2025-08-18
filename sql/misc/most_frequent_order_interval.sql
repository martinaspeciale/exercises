-- Tables:
-- Orders(id, customer_id, order_date)
--
-- Problem:
-- For each customer with at least 3 orders, find the **most common number 
of days** between consecutive orders.
-- Return: customer_id, most_common_gap_days.

WITH ordered AS (
  SELECT
    customer_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS 
prev_date
  FROM Orders
),
gaps AS (
  SELECT
    customer_id,
    EXTRACT(DAY FROM order_date - prev_date) AS gap_days
  FROM ordered
  WHERE prev_date IS NOT NULL
),
gap_counts AS (
  SELECT
    customer_id,
    gap_days,
    COUNT(*) AS freq,
    RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS rnk
  FROM gaps
  GROUP BY customer_id, gap_days
)
SELECT
  customer_id,
  gap_days AS most_common_gap_days
FROM gap_counts
WHERE rnk = 1
ORDER BY customer_id;

