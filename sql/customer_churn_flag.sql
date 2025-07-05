/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Flag customers who have not placed an order in the last 12 months as 'churned'.
Return: customer_id, churn_flag (Y/N).

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)

*/
WITH active_customers AS (
    SELECT DISTINCT
        o.customer_id
    FROM
        orders o
    WHERE
        o.order_date >= CURRENT_DATE - INTERVAL '12 months'
)
SELECT
    c.customer_id,
    CASE 
        WHEN a.customer_id IS NULL THEN 'Y'
        ELSE 'N'
    END AS churn_flag
FROM
    customers c
    LEFT JOIN active_customers a
        ON c.customer_id = a.customer_id
ORDER BY
    c.customer_id;
