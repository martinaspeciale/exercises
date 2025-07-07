/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Compute the average order value (total_amount) for each region.
Return: region, average_order_value.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)

*/
SELECT 
    c.region, 
    AVG(o.total_amount) AS average_order_value
FROM 
    orders o
    JOIN customers c ON c.customer_id = o.customer_id
GROUP BY    
    c.region;
