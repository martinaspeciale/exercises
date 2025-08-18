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

For each customer who has orders in at least 2 different months,
calculate their month-over-month percentage growth in total order amount,
for all month pairs where both the current and previous month have orders.

Output columns:
- customer_id
- year_month (format 'YYYY-MM')
- growth_percentage

Details:
- For each customer, aggregate order_amount by month.
- For consecutive months, compute:
    (current_month_total - previous_month_total) / previous_month_total * 100
- Exclude customers with orders in fewer than 2 months.
- Exclude rows where previous_month_total = 0.
*/

WITH MonthlyTotals AS (
    SELECT
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m') AS year_month,
        SUM(order_amount) AS total_amount
    FROM Orders
    GROUP BY
        customer_id,
        DATE_FORMAT(order_date, '%Y-%m')
),
CustomerMonthCounts AS (
    SELECT
        customer_id,
        COUNT(DISTINCT year_month) AS month_count
    FROM MonthlyTotals
    GROUP BY customer_id
    HAVING COUNT(DISTINCT year_month) >= 2
),
OrderedMonths AS (
    SELECT
        mt.
