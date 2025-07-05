/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Find the best-selling product (by quantity) in each month of 2024.
Return: month, product_id, total_quantity.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
orders(order_id, customer_id, order_date, total_amount)
order_items(order_item_id, order_id, product_id, quantity, price_per_unit)

*/
WITH per_month AS (
    SELECT 
        EXTRACT(MONTH FROM o.order_date) AS month,
        i.product_id,
        SUM(i.quantity) AS quantity
    FROM 
        orders o
        JOIN order_items i ON o.order_id = i.order_id
    WHERE 
        EXTRACT(YEAR FROM o.order_date) = 2024
    GROUP BY 
        EXTRACT(MONTH FROM o.order_date), i.product_id
),
ranked AS (
    SELECT 
        month,
        product_id,
        quantity,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY quantity DESC) AS rn
    FROM 
        per_month
)
SELECT 
    month,
    product_id,
    quantity AS total_quantity
FROM 
    ranked
WHERE 
    rn = 1
ORDER BY
    month;
