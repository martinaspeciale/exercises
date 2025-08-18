-- ============================================================
-- Exercise 3: Top Products with Category Ranking
--
-- Table: products
-- Columns:
--   id       INT       - Product ID (PK)
--   name     TEXT      - Product name
--   price    DECIMAL   - Price in USD
--   category TEXT      - Product category
--
-- Table: order_items
-- Columns:
--   id         INT     - Order Item ID (PK)
--   order_id   INT     - Order ID (FK)
--   product_id INT     - Product ID (FK)
--   quantity   INT     - Quantity ordered
--
-- Request:
--   Find, for each product:
--     - product name
--     - category
--     - total quantity sold
--     - category rank by quantity sold (1 = most sold in category)
--
--   Only include products with total quantity > 50.
--   Order by category and category_rank.
-- ============================================================

WITH product_sales AS (
    SELECT
        p.id,
        p.name,
        p.category,
        SUM(oi.quantity) AS total_quantity
    FROM products p
    JOIN order_items oi ON p.id = oi.product_id
    GROUP BY p.id, p.name, p.category
)
SELECT
    name AS product_name,
    category,
    total_quantity,
    RANK() OVER (
        PARTITION BY category
        ORDER BY total_quantity DESC
    ) AS category_rank
FROM product_sales
WHERE total_quantity > 50
ORDER BY category, category_rank;
