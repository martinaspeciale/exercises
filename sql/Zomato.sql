-- Zomato is a leading online food delivery service that connects users
-- with various restaurants and cuisines, allowing them to browse menus,
-- place orders, and get meals delivered to their doorsteps.

-- Recently, Zomato encountered an issue with their delivery system.
-- Due to an error in the delivery driver instructions, each item's order 
-- was swapped with the item in the subsequent row.

-- As a data analyst, you're asked to correct this swapping error and return 
-- the proper pairing of order ID and item.

-- If the last item has an odd order ID, it should remain as the last item 
-- in the corrected data. 
-- For example, if the last item is Order ID 7 Tandoori Chicken, 
-- then it should remain as Order ID 7 in the corrected data.

-- In the results, return the correct pairs of order IDs and items.

-- Table: orders
-- Columns:
-- - order_id (integer): The ID of each Zomato order.
-- - item (string): The name of the food item in each order.

WITH numbered_orders AS (
  SELECT 
    order_id,
    item,
    ROW_NUMBER() OVER (ORDER BY order_id) AS rn
  FROM orders
),
swapped_orders AS (
  -- Swap odd-indexed row with the next (even-indexed) row
  SELECT 
    o1.order_id AS order_id,
    o2.item AS item
  FROM numbered_orders o1
  JOIN numbered_orders o2
    ON o1.rn = o2.rn - 1
  WHERE MOD(o1.rn, 2) = 1

  UNION ALL

  SELECT 
    o2.order_id AS order_id,
    o1.item AS item
  FROM numbered_orders o1
  JOIN numbered_orders o2
    ON o1.rn = o2.rn - 1
  WHERE MOD(o1.rn, 2) = 1

  UNION ALL

  -- Keep the last unpaired row if total rows is odd
  SELECT 
    order_id,
    item
  FROM numbered_orders
  WHERE rn = (SELECT MAX(rn) FROM numbered_orders)
    AND MOD((SELECT MAX(rn) FROM numbered_orders), 2) = 1
)

-- Final result: swapped items correctly matched to order IDs
SELECT order_id, item
FROM swapped_orders
ORDER BY order_id;
