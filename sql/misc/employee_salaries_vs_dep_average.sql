-- ============================================================
-- Exercise 1: Employee Salaries vs. Department Average
--
-- Table: employees
-- Columns:
--   id            INT       - Employee ID (PK)
--   name          TEXT      - Employee full name
--   department_id INT       - Department ID (FK)
--   salary        DECIMAL   - Monthly salary
--
-- Table: departments
-- Columns:
--   id   INT     - Department ID (PK)
--   name TEXT    - Department name
--
-- Request:
--   For each employee, show:
--     - employee name
--     - department name
--     - salary
--     - average salary in that department
--     - whether the employee earns above the department average ('Yes'/'No')
--
--   Order results by department name and employee name.
-- ============================================================

SELECT
    e.name AS employee_name,
    d.name AS department_name,
    e.salary,
    ROUND(AVG(e.salary) OVER (PARTITION BY e.department_id), 2) AS department_avg_salary,
    CASE
        WHEN e.salary > AVG(e.salary) OVER (PARTITION BY e.department_id) THEN 'Yes'
        ELSE 'No'
    END AS above_department_avg
FROM employees e
JOIN departments d ON e.department_id = d.id
ORDER BY d.name, e.name;
