-- Task:
-- Identify the top two highest-grossing products within each category in the year 2022.
-- The product_spend table contains: category, product, user_id, spend, transaction_date.

-- Step 1: Aggregate total spend per product per category for transactions in 2022
WITH prod_cat_unique AS (
  SELECT 
    category, 
    product, 
    SUM(spend) AS totperprod
  FROM 
    product_spend 
  WHERE 
    EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY 
    category, 
    product 
), 

-- Step 2: Rank products within each category by total spend in descending order
catprod AS (
  SELECT 
    category, 
    product, 
    totperprod AS total_spend, 
    ROW_NUMBER() OVER (
      PARTITION BY category 
      ORDER BY totperprod DESC 
    ) AS rn
  FROM 
    prod_cat_unique
)

-- Step 3: Select top 2 products per category
SELECT 
  category, 
  product, 
  total_spend
FROM 
  catprod
WHERE 
  rn <= 2
ORDER BY 
  category, 
  total_spend DESC;
