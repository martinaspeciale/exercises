/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Classify customers based on their total number of orders:
- 'Low' (1–2 orders)
- 'Medium' (3–5 orders)
- 'High' (>5 orders)
Return: customer_id, segment.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)

*/
WITH per_customer AS (
    SELECT 
        customer_id, 
        COUNT(*) AS tot_orders 
    FROM 
        orders 
    GROUP BY 
        customer_id 
)
SELECT 
    customer_id, 
    CASE 
        WHEN tot_orders BETWEEN 1 AND 2 THEN 'Low' 
        WHEN tot_orders BETWEEN 3 AND 5 THEN 'Medium'
        ELSE 'High'
    END AS segment 
FROM 
    per_customer
ORDER BY
    customer_id;
