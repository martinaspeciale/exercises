/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
For 2024, compute the % contribution of each product category to total revenue.
Return: category, percent_of_total_revenue.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
orders(order_id, customer_id, order_date, total_amount)
order_items(order_item_id, order_id, product_id, quantity, price_per_unit)
products(product_id, category, product_name)

*/
WITH per_category AS (
    SELECT 
        p.category, 
        SUM(i.quantity * i.price_per_unit) AS cat_total_revenue 
    FROM 
        products p 
        JOIN order_items i ON p.product_id = i.product_id 
        JOIN orders o ON o.order_id = i.order_id 
    WHERE 
        EXTRACT(YEAR FROM o.order_date) = 2024 
    GROUP BY 
        p.category
)
SELECT 
    category, 
    cat_total_revenue / (
        SELECT SUM(cat_total_revenue) FROM per_category
    ) * 100.0 AS percent_of_total_revenue
FROM 
    per_category
ORDER BY 
    percent_of_total_revenue DESC;
