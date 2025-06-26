-- Goal: Find the mode(s) of order occurrences from the items_per_order table.
-- Each row contains 'item_count' (number of items per order)
-- and 'order_occurrences' (how many times that item_count appears across orders).

-- Steps:
-- 1. Find the maximum value of 'order_occurrences' (i.e., the mode frequency).
-- 2. Select all 'item_count' values that have this maximum frequency.
-- 3. Sort the result in ascending order in case of ties.

SELECT item_count
FROM items_per_order
WHERE order_occurrences = (
    SELECT MAX(order_occurrences)
    FROM items_per_order
)
ORDER BY item_count ASC;
