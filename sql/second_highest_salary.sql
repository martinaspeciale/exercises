-- Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries.
-- Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

-- It's possible that multiple employees may share the same second highest salary.
-- In case of duplicate, display the salary only once.

-- employee Schema:
-- column_name     type      description
-- employee_id     integer   The unique ID of the employee.
-- name            string    The name of the employee.
-- salary          integer   The salary of the employee.
-- department_id   integer   The department ID of the employee.
-- manager_id      integer   The manager ID of the employee.

SELECT 
  salary AS second_highest_salary
FROM 
  employee
WHERE 
  salary < (
    SELECT MAX(salary)
    FROM employee
  )
ORDER BY 
  salary DESC
LIMIT 1;

-- or simply: SELECT DISTINCT + ORDER BY + OFFSET AND LIMIT 
SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
OFFSET 1 LIMIT 1;

