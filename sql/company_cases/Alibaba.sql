-- You're trying to find the mean number of items per order on Alibaba,
-- rounded to 1 decimal place using tables which include information 
-- on the count of items in each order (item_count table) 
-- and the corresponding number of orders for each item count (order_occurrences table).

-- Table: items_per_order
-- Columns:
-- item_count (integer)
-- order_occurrences (integer)

SELECT 
    ROUND(
        (SUM(order_occurrences * item_count)::numeric) / SUM(order_occurrences)::numeric, 
        1
    ) AS mean_items_per_order
FROM 
    items_per_order;
