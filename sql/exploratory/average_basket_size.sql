/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
For each customer, compute the average number of items per order
(total quantity of items / total orders).
Return: customer_id, avg_items_per_order.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
orders(order_id, customer_id, order_date, total_amount)
order_items(order_item_id, order_id, product_id, quantity, price_per_unit)

*/
WITH order_item_totals AS (
    SELECT
        o.order_id,
        o.customer_id,
        SUM(i.quantity) AS items_per_order
    FROM
        orders o
        JOIN order_items i ON o.order_id = i.order_id
    GROUP BY
        o.order_id,
        o.customer_id
)
SELECT
    customer_id,
    AVG(items_per_order) AS avg_items_per_order
FROM
    order_item_totals
GROUP BY
    customer_id
ORDER BY
    customer_id;
