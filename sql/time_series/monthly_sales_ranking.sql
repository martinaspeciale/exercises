-- ============================================================
-- Exercise 2: Monthly Sales Ranking
--
-- Table: orders
-- Columns:
--   id          INT       - Order ID (PK)
--   customer_id INT       - Customer ID (FK)
--   order_date  DATE      - Date of order
--   amount      DECIMAL   - Order amount in USD
--
-- Request:
--   For all orders in 2023, calculate per month:
--     - month (as YYYY-MM)
--     - total sales
--     - number of orders
--     - ranking of months by total sales (1 = highest sales)
--
--   Return columns:
--     - month
--     - total_sales
--     - order_count
--     - sales_rank
-- ============================================================

WITH monthly_summary AS (
    SELECT
        TO_CHAR(order_date, 'YYYY-MM') AS month,
        SUM(amount) AS total_sales,
        COUNT(*) AS order_count
    FROM orders
    WHERE EXTRACT(YEAR FROM order_date) = 2023
    GROUP BY month
)
SELECT
    month,
    total_sales,
    order_count,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM monthly_summary
ORDER BY sales_rank;
