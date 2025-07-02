/*
Exercise 1: Daily Sales and 7-Day Rolling Average

You have a sales table with daily sales amounts per store.

Table: sales

CREATE TABLE sales (
  store_id INT,
  sale_date DATE,
  amount DECIMAL(10,2)
);

Sample data:
| store_id | sale_date  | amount |
|----------|------------|--------|
| 1        | 2024-01-01 | 100.00 |
| 1        | 2024-01-02 | 120.00 |
| 1        | 2024-01-03 | 130.00 |
| ...      | ...        | ...    |

Task:
1. For a given store_id (say 1), return each day's sales amount and its rolling 7-day average.
2. Write a first, slow version (e.g., with correlated subquery or self-join).
3. Then write an optimized version using window functions.
*/

-- SLOW VERSION
SELECT 
    s1.sale_date,
    s1.amount,
    (
        SELECT AVG(s2.amount)
        FROM sales s2
        WHERE s2.store_id = s1.store_id
          AND s2.sale_date BETWEEN DATE_SUB(s1.sale_date, INTERVAL 6 DAY) AND s1.sale_date
    ) AS rolling_avg_7_days
FROM sales s1
WHERE s1.store_id = 1
ORDER BY s1.sale_date;

-- this runs a subquery for every row --> slow for large data 

-- OPTIMIZED VERSION WITH WINDOW FUNCTION 
-- OPTIMIZED VERSION
SELECT
    sale_date,
    amount,
    ROUND(AVG(amount) OVER (
        PARTITION BY store_id
        ORDER BY sale_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS rolling_avg_7_days
FROM sales
WHERE store_id = 1
ORDER BY sale_date;

-- window function computes rolling average efficiently without repeated subqueries
