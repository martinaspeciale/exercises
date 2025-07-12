-- Tables:
-- Employees(id, name, department_id, salary)
-- Departments(id, name)
--
-- Problem:
-- For each department, list employees whose salary is more than 1.5 times the median salary of their department.
-- Return: department_name, employee_id, employee_name, salary, department_median_salary
-- Order the output by department_name, salary descending.
-- Notes:
-- Assume departments have at least 3 employees each.
-- Use appropriate window or analytic functions to compute the median.

WITH department_medians AS (
  SELECT
    department_id,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY salary) AS median_salary
  FROM
    Employees
  GROUP BY
    department_id
),
joined AS (
  SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    e.salary,
    d.id AS department_id,
    d.name AS department_name,
    dm.median_salary
  FROM
    Employees e
    JOIN Departments d ON e.department_id = d.id
    JOIN department_medians dm ON e.department_id = dm.department_id
)
SELECT
  department_name,
  employee_id,
  employee_name,
  salary,
  median_salary AS department_median_salary
FROM
  joined
WHERE
  salary > 1.5 * median_salary
ORDER BY
  department_name ASC,
  salary DESC;
