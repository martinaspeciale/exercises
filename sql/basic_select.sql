-- Select all employees
SELECT * FROM employees;

-- Filter engineers
SELECT name, salary FROM employees WHERE department = 'Engineering';
