-- Goal:
-- Identify users who made purchases on 3 or more consecutive days.
-- A shopping spree is defined as 3+ consecutive transaction days.
-- Output: distinct user IDs in ascending order.

WITH dated_transactions AS (
  SELECT 
    user_id, 
    DATE(transaction_date) AS txn_date
  FROM 
    transactions
  GROUP BY 
    user_id, DATE(transaction_date)  -- remove multiple transactions per day
),
ranked_transactions AS (
  SELECT 
    user_id, 
    txn_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY txn_date) AS row_num
  FROM 
    dated_transactions
),
grouped_transactions AS (
  SELECT 
    user_id, 
    txn_date,
    DATE_SUB(txn_date, INTERVAL row_num DAY) AS spree_group
    -- Subtracting row number from date gives the same value for consecutive dates
    -- This trick allows us to group consecutive days

    -- txn_date - (rn || ' days')::interval AS spree_group
    -- PostgreSQL way to subtract N days from a date

  FROM 
    ranked_transactions
),
spree_lengths AS (
  SELECT 
    user_id, 
    COUNT(*) AS consecutive_days
  FROM 
    grouped_transactions
  GROUP BY 
    user_id, spree_group
  HAVING 
    COUNT(*) >= 3
)
SELECT DISTINCT user_id
FROM spree_lengths
ORDER BY user_id;
