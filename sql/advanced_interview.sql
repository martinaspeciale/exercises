-- ===========================================
-- ADVANCED SQL INTERVIEW-STYLE EXERCISE
-- ===========================================

-- PROBLEM STATEMENT:
-- You work for an online retail company. You have two tables:
--
-- 1. Orders
--    - order_id (INT)
--    - customer_id (INT)
--    - order_date (DATE)
--    - order_amount (DECIMAL)
--
-- 2. Customers
--    - customer_id (INT)
--    - customer_name (TEXT)
--    - country (TEXT)
--
-- Write a query to find the TOP 3 customers in each country
-- by their total spending (sum of order_amount),
-- considering only orders from the last 12 months
-- (relative to the latest date in the Orders table).
--
-- If there is a tie for 3rd place, include all customers who tie.
--
-- Output columns:
--   - country
--   - customer_id
--   - customer_name
--   - total_spending
--
-- ORDER the final results by country ASC, total_spending DESC.
--
-- ===========================================
-- EXAMPLE SCHEMA
-- ===========================================

-- CREATE TABLE Customers (
--   customer_id INT PRIMARY KEY,
--   customer_name TEXT,
--   country TEXT
-- );

-- CREATE TABLE Orders (
--   order_id INT PRIMARY KEY,
--   customer_id INT REFERENCES Customers(customer_id),
--   order_date DATE,
--   order_amount DECIMAL
-- );

-- ===========================================
-- SAMPLE DATA (OPTIONAL)
-- ===========================================

-- INSERT INTO Customers VALUES
-- (1, 'Alice', 'USA'),
-- (2, 'Bob', 'USA'),
-- (3, 'Charlie', 'USA'),
-- (4, 'Diana', 'USA'),
-- (5, 'Eve', 'Canada'),
-- (6, 'Frank', 'Canada'),
-- (7, 'Grace', 'Canada'),
-- (8, 'Heidi', 'Canada');

-- INSERT INTO Orders VALUES
-- (101, 1, '2024-05-15', 500),
-- (102, 2, '2024-06-01', 300),
-- (103, 3, '2024-04-10', 700),
-- (104, 4, '2023-07-01', 200),
-- (105, 1, '2023-08-15', 400),
-- (106, 5, '2024-02-01', 800),
-- (107, 6, '2024-03-15', 400),
-- (108, 7, '2023-11-20', 300),
-- (109, 8, '2024-06-10', 600);

-- ===========================================
-- HARD REQUIREMENTS:
--   * Use window functions
--   * Handle ties for 3rd place (include all ties)
--   * Filter by rolling 12 months based on the MAX(order_date)
-- ===========================================


-- ===========================================
-- SOLUTION
-- ===========================================

WITH MaxDate AS (
  SELECT MAX(order_date) AS max_date FROM Orders
),
FilteredOrders AS (
  SELECT
    o.*
  FROM
    Orders o
    JOIN MaxDate m ON o.order_date >= (m.max_date - INTERVAL '12 months')
),
CustomerSpending AS (
  SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    SUM(o.order_amount) AS total_spending
  FROM
    FilteredOrders o
    JOIN Customers c ON o.customer_id = c.customer_id
  GROUP BY
    c.customer_id,
    c.customer_name,
    c.country
),
RankedSpending AS (
  SELECT
    country,
    customer_id,
    customer_name,
    total_spending,
    RANK() OVER (
      PARTITION BY country
      ORDER BY total_spending DESC
    ) AS spending_rank
  FROM
    CustomerSpending
)
SELECT
  country,
  customer_id,
  customer_name,
  total_spending
FROM
  RankedSpending
WHERE
  spending_rank <= 3
ORDER BY
  country ASC,
  total_spending DESC;
