-- Goal:
-- For each user, find their most recent transaction date,
-- and count how many products they bought on that exact date.
-- Output: transaction_date, user_id, number of products (purchase_count)
-- Sort the result by transaction_date.

WITH most_recent AS (
  -- Step 1: Get the most recent transaction date for each user
  SELECT 
    user_id, 
    MAX(transaction_date) AS transaction_date
  FROM 
    user_transactions
  GROUP BY 
    user_id
)

SELECT 
  t.transaction_date, 
  t.user_id, 
  COUNT(DISTINCT t.product_id) AS purchase_count
  -- Use COUNT(DISTINCT product_id) in case there are duplicate entries per product
FROM 
  most_recent r
JOIN 
  user_transactions t 
  ON r.user_id = t.user_id 
  AND r.transaction_date = t.transaction_date
  -- Step 2: Join on both user_id and transaction_date to get only the most recent transaction
GROUP BY 
  t.transaction_date, 
  t.user_id
ORDER BY 
  t.transaction_date;
