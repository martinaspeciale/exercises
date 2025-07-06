/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Compute the month-over-month percentage growth in total revenue for 2024.
Return: month, total_revenue, growth_rate.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
orders(order_id, customer_id, order_date, total_amount)

*/
WITH per_month AS (
    SELECT 
        EXTRACT(MONTH FROM order_date) AS month,
        SUM(total_amount) AS total_amount
    FROM    
        orders
    WHERE
        EXTRACT(YEAR FROM order_date) = 2024
    GROUP BY 
        EXTRACT(MONTH FROM order_date)
),
prev_per_month AS (
    SELECT 
        month,
        total_amount,
        LAG(total_amount, 1) OVER (ORDER BY month) AS prev_month_total
    FROM 
        per_month
)
SELECT 
    month,
    total_amount,
    CASE
        WHEN prev_month_total IS NOT NULL THEN 
            (total_amount - prev_month_total) / prev_month_total * 100.0
        ELSE NULL
    END AS growth_rate
FROM 
    prev_per_month
ORDER BY
    month;
