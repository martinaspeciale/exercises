/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Classify each order into revenue buckets: 'Low' (<100), 'Medium' (100-500), 'High' (>500).
Return: order_id, bucket.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
orders(order_id, customer_id, order_date, total_amount)

*/
SELECT
    order_id,
    CASE
        WHEN total_amount < 100 THEN 'Low'
        WHEN total_amount BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS bucket
FROM
    orders;
