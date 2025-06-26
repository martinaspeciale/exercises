-- Given a table `user_transactions` that contains information about Wayfair user transactions
-- for different products, calculate the year-on-year (YoY) growth rate for the total spend
-- of each product, grouping the results by product ID.

-- The output should include:
-- - the year (in ascending order),
-- - product ID,
-- - current year's total spend,
-- - previous year's total spend,
-- - and the year-on-year growth percentage, rounded to 2 decimal places.

-- Table structure:
-- user_transactions
-- | Column Name       | Type     |
-- |-------------------|----------|
-- | transaction_id    | integer  |
-- | product_id        | integer  |
-- | spend             | decimal  |
-- | transaction_date  | datetime |

-- Step 1: Aggregate total spend per product per year
WITH sales_per_year AS (
  SELECT 
    EXTRACT(YEAR FROM transaction_date) AS year_,
    product_id,
    SUM(spend) AS curr_year_spend
  FROM user_transactions
  GROUP BY product_id, EXTRACT(YEAR FROM transaction_date)
),

-- Step 2: Join each year's data with the previous year's data for the same product
joined_years AS (
  SELECT 
    curr.year_ AS year,
    curr.product_id, 
    curr.curr_year_spend,
    prev.curr_year_spend AS prev_year_spend
  FROM sales_per_year curr
  LEFT JOIN sales_per_year prev
    ON curr.product_id = prev.product_id 
    AND curr.year_ = prev.year_ + 1
)

-- Step 3: Compute YoY growth rate, handling NULLs for first year
SELECT 
  year,
  product_id,
  curr_year_spend,
  prev_year_spend,
  ROUND(
    CASE 
      WHEN prev_year_spend IS NULL THEN NULL
      ELSE (curr_year_spend - prev_year_spend) / prev_year_spend * 100.0
    END,
    2
  ) AS yoy_rate
FROM joined_years
ORDER BY product_id, year;
