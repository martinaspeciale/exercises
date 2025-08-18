/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
For each customer, calculate their total lifetime value (sum of all their order amounts).
Return: customer_id, lifetime_value.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)

*/

SELECT 
    customer_id, 
    SUM(total_amount) AS lifetime_value
FROM 
    orders
GROUP BY 
    customer_id;

