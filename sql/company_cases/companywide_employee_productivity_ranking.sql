-- Tables:
-- Employees(id, name, department_id)
-- Tasks(id, employee_id, completed_at, estimated_hours, actual_hours)
-- Departments(id, name)
--
-- Problem:
-- Rank employees by **efficiency score** = estimated_hours / 
actual_hours.
-- Return: employee_id, employee_name, department_name, efficiency_score, 
rank.

WITH efficiency AS (
  SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    d.name AS department_name,
    ROUND(SUM(t.estimated_hours) / NULLIF(SUM(t.actual_hours), 0), 2) AS 
efficiency_score
  FROM Employees e
  JOIN Tasks t ON e.id = t.employee_id
  JOIN Departments d ON e.department_id = d.id
  GROUP BY e.id, e.name, d.name
)
SELECT
  employee_id,
  employee_name,
  department_name,
  efficiency_score,
  RANK() OVER (ORDER BY efficiency_score DESC) AS rank
FROM efficiency
ORDER BY rank;

