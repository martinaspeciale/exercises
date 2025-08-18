/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Find the most ordered product (by quantity) in each region for 2024.
Return: region, product_id, total_quantity.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)
order_items(order_item_id, order_id, product_id, quantity, price_per_unit)

*/
WITH product_sales AS (
    SELECT
        c.region,
        i.product_id,
        SUM(i.quantity) AS total_quantity
    FROM
        customers c
        JOIN orders o ON c.customer_id = o.customer_id
        JOIN order_items i ON i.order_id = o.order_id
    WHERE
        EXTRACT(YEAR FROM o.order_date) = 2024
    GROUP BY
        c.region, i.product_id
),
ranked_sales AS (
    SELECT
        region,
        product_id,
        total_quantity,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY total_quantity DESC
        ) AS rank
    FROM
        product_sales
)
SELECT
    region,
    product_id,
    total_quantity
FROM
    ranked_sales
WHERE
    rank = 1
ORDER BY
    region;
