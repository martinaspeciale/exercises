/*
Exercise 2: Pivot Monthly Expenses by Category

You have an expenses table tracking monthly expenses per department and category.

Table: expenses

CREATE TABLE expenses (
  department VARCHAR(50),
  expense_month DATE,
  category VARCHAR(50),
  amount DECIMAL(10,2)
);

Sample data:
| department | expense_month | category | amount |
|------------|---------------|----------|--------|
| 'HR'       | '2024-01-01'  | 'Travel' | 200.00 |
| 'HR'       | '2024-01-01'  | 'Supplies' | 150.00 |
| 'IT'       | '2024-01-01'  | 'Travel' | 300.00 |
| ...        | ...           | ...      | ...    |

Task:
1. For a given month ('2024-01-01'), list total expenses per department in columns by category (pivot).
2. First, write a slow/manual version with CASE expressions.
3. Then write an optimized / cleaner version using PIVOT (if your DBMS supports it).
*/

-- SLOW VERSION (manual pivot with CASE)
SELECT
    department,
    SUM(CASE WHEN category = 'Travel' THEN amount ELSE 0 END) AS Travel,
    SUM(CASE WHEN category = 'Supplies' THEN amount ELSE 0 END) AS Supplies,
    SUM(CASE WHEN category = 'Equipment' THEN amount ELSE 0 END) AS Equipment
FROM expenses
WHERE expense_month = '2024-01-01'
GROUP BY department
ORDER BY department;

-- this manually defines each category in CASE statements, hard to scale if many categories
