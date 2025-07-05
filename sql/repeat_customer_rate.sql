/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Calculate the percentage of customers who placed more than one order in 2024.
Return a single number: repeat_customer_percentage.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)
*/
WITH repeat_customer AS (
    SELECT 
        c.customer_id 
    FROM   
        customers c
        LEFT JOIN orders o ON c.customer_id = o.customer_id
    WHERE
        EXTRACT(YEAR FROM o.order_date) = 2024
    GROUP BY 
        c.customer_id 
    HAVING 
        COUNT(o.order_id) > 1
)
SELECT 
    SUM(CASE WHEN r.customer_id IS NOT NULL THEN 1 ELSE 0 END) * 100.0 /
    COUNT(*) AS repeat_customer_percentage 
FROM 
    customers c
    LEFT JOIN repeat_customer r ON c.customer_id = r.customer_id;
