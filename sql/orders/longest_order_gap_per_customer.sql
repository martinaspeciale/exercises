/*
TABLE: Orders

Columns:
- order_id INT PRIMARY KEY
- customer_id INT
- order_date DATE
- order_amount DECIMAL(10,2)

Sample Data:
(1, 101, '2024-01-05', 200.00),
(2, 101, '2024-02-10', 150.00),
(3, 102, '2024-02-15', 300.00),
(4, 103, '2024-02-20', 100.00),
(5, 101, '2024-03-05', 400.00),
(6, 102, '2024-03-12', 350.00),
(7, 103, '2024-03-15', 250.00),
(8, 104, '2024-03-18', 450.00),
(9, 104, '2024-04-02', 500.00),
(10, 101, '2024-04-10', 300.00)

QUESTION:

For each customer who has placed at least 3 orders in total,
find the longest gap in days between any two of their consecutive orders,
and output their customer_id along with that maximum gap.

Requirements:
- Only include customers with at least 3 orders.
- The gap is measured between consecutive orders ordered by date.
- Return: customer_id, max_gap_days.
*/

WITH OrderedDates AS (
    SELECT
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS prev_order_date
    FROM Orders
),
Gaps AS (
    SELECT
        customer_id,
        DATEDIFF(order_date, prev_order_date) AS gap_days
    FROM OrderedDates
    WHERE prev_order_date IS NOT NULL
),
CustomerCounts AS (
    SELECT
        customer_id,
        COUNT(*) AS num_orders
    FROM Orders
    GROUP BY customer_id
    HAVING COUNT(*) >= 3
)
SELECT
    g.customer_id,
    MAX(g.gap_days) AS max_gap_days
FROM
    Gaps g
    INNER JOIN CustomerCounts c ON g.customer_id = c.customer_id
GROUP BY
    g.customer_id;
