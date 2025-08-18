-- A Supercloud customer is one who has purchased at least one product from every product category.
-- The steps are:
-- 1. Count how many distinct product categories exist.
-- 2. For each customer, count how many distinct product categories they have purchased from.
-- 3. Select the customers where the number of categories purchased equals the total number of categories.

WITH total_categories AS (
    -- Get total number of distinct product categories
    SELECT COUNT(DISTINCT product_category) AS total_cat
    FROM products
),

customer_categories AS (
    -- For each customer, count how many distinct product categories they have purchased from
    SELECT c.customer_id, COUNT(DISTINCT p.product_category) AS cat_count
    FROM customer_contracts c
    JOIN products p ON c.product_id = p.product_id
    GROUP BY c.customer_id
)

-- Select customers where their category count equals the total number of categories
SELECT cc.customer_id
FROM customer_categories cc
JOIN total_categories tc
ON cc.cat_count = tc.total_cat;
