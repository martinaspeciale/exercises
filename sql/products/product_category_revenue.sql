/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
For 2024, compute total revenue for each product category in each customer region.
Return: region, category, total_revenue.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)
order_items(order_item_id, order_id, product_id, quantity, price_per_unit)
products(product_id, category, product_name)

*/
SELECT 
    c.region, 
    p.category, 
    SUM(i.quantity * i.price_per_unit) AS total_revenue
FROM 
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items i ON i.order_id = o.order_id
    JOIN products p ON p.product_id = i.product_id
WHERE 
    EXTRACT(YEAR FROM o.order_date) = 2024
GROUP BY 
    c.region, p.category
ORDER BY
    c.region, p.category;
