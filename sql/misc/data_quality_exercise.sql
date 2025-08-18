/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Identify orders with negative or zero total_amount.
Return: order_id, total_amount.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
orders(order_id, customer_id, order_date, total_amount)

*/

select 
    order_id, total_amount 
from 
    orders 
where 
    total_amount <= 0