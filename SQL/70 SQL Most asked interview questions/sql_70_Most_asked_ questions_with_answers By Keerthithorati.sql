
-- 1. Retrieve the second-highest salary of an employee
SELECT MAX(salary) AS second_highest_salary
FROM Employees
WHERE salary < 
             (
			 SELECT MAX(salary) 
			 FROM Employees
			 )

-- 2. Get the nth highest salary (example: 3rd highest)
SELECT salary
FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM Employees
) AS Ranked
WHERE rnk = 3;

-- 3. Fetch all employees whose salary is greater than the average salary
SELECT employee_id, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 4. Display the current date and time
SELECT CURRENT_TIMESTAMP AS current_date_time;

-- 5. Find duplicate records in a table (based on employee_id)
SELECT employee_id, COUNT(*) AS count
FROM Employees
GROUP BY employee_id
HAVING COUNT(*) > 1;

-- 6. Delete duplicate rows (keep one)
WITH Duplicates AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY (SELECT NULL)) AS rn
    FROM Employees
)
DELETE FROM Duplicates WHERE rn > 1;

-- 7. Get common records from two tables
SELECT employee_id
FROM Employees
INTERSECT
SELECT employee_id
FROM Managers;

-- 8. Retrieve the last 10 records from a table (based on hire_date)
SELECT TOP 10 *
FROM Employees
ORDER BY hire_date DESC;

-- 9. Fetch the top 5 employees with the highest salaries
SELECT TOP 5 employee_id, salary
FROM Employees
ORDER BY salary DESC;

-- 10. Calculate the total salary of all employees
SELECT SUM(salary) AS total_salary
FROM Employees;

-- 11. Find all employees who joined in the year 2020
SELECT employee_id, hire_date
FROM Employees
WHERE YEAR(hire_date) = 2020;

-- 12. Find employees whose name starts with 'A'
SELECT employee_id, first_name
FROM Employees
WHERE first_name LIKE 'A%';

-- 13. Find employees who do not have a manager
SELECT employee_id
FROM Employees
WHERE manager_id IS NULL;

-- 14. Find the department with the highest number of employees
SELECT TOP 1 department_id, COUNT(*) AS employee_count
FROM Employees
GROUP BY department_id
ORDER BY employee_count DESC;

-- 15. Get the count of employees in each department
SELECT department_id, COUNT(*) AS employee_count
FROM Employees
GROUP BY department_id;

-- 16. Employees with highest salary in each department
SELECT department_id, employee_id, salary
FROM (
    SELECT *, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rk
    FROM Employees
) AS Ranked
WHERE rk = 1;

-- 17. Update the salary of all employees by 10%
UPDATE Employees
SET salary = salary * 1.10;

-- 18. Find employees whose salary is between 50,000 and 100,000
SELECT employee_id, salary
FROM Employees
WHERE salary BETWEEN 50000 AND 100000;

-- 19. Find the youngest employee
SELECT TOP 1 employee_id, birth_date
FROM Employees
ORDER BY birth_date DESC;

-- 20. Fetch the first and last record from a table
(SELECT TOP 1 * FROM Employees ORDER BY hire_date ASC)
UNION ALL
(SELECT TOP 1 * FROM Employees ORDER BY hire_date DESC);

-- 21. Find employees reporting to a specific manager (e.g., manager_id = 200)
SELECT employee_id, first_name
FROM Employees
WHERE manager_id = 200;

-- 22. Find the total number of departments
SELECT COUNT(DISTINCT department_id) AS total_departments
FROM Employees;

-- 23. Department with the lowest average salary
SELECT TOP 1 department_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id
ORDER BY avg_salary ASC;

-- 24. Delete all employees from a department (e.g., dept 101)
DELETE FROM Employees
WHERE department_id = 101;

-- 25. Employees in the company for more than 5 years
SELECT employee_id, hire_date
FROM Employees
WHERE DATEDIFF(YEAR, hire_date, GETDATE()) > 5;

-- 26. Second-largest value from a table (e.g., second-highest salary)
SELECT MAX(salary) AS second_highest
FROM Employees
WHERE salary < (SELECT MAX(salary) FROM Employees);

-- 27. Remove all records but keep the table structure
DELETE FROM Employees;

-- 28. Get all employee records in XML format
SELECT * FROM Employees FOR XML AUTO, ELEMENTS;

-- 29. Get the current month’s name
SELECT DATENAME(MONTH, GETDATE()) AS current_month;

-- 30. Convert a string to lowercase
SELECT LOWER(first_name) AS lower_first_name
FROM Employees;

-- 31. Employees with no subordinates
SELECT e.employee_id
FROM Employees e
LEFT JOIN Employees m ON e.employee_id = m.manager_id
WHERE m.employee_id IS NULL;

-- 32. Total sales per customer (assumes Customer and Sales table)
SELECT customer_id, SUM(sales_amount) AS total_sales
FROM Sales
GROUP BY customer_id;

-- 33. Check if a table is empty
SELECT CASE WHEN EXISTS (SELECT 1 FROM Employees)
            THEN 'Table is not empty'
            ELSE 'Table is empty' END AS table_status;

-- 34. Second highest salary per department
SELECT department_id, employee_id, salary
FROM (
    SELECT *, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rk
    FROM Employees
) AS Ranked
WHERE rk = 2;

-- 35. Employees with salary a multiple of 10,000
SELECT employee_id, salary
FROM Employees
WHERE salary % 10000 = 0;

-- 36. Fetch records where a column has null values (e.g., bonus)
SELECT *
FROM Employees
WHERE bonus IS NULL;

-- 37. Count employees in each job title
SELECT job_title, COUNT(*) AS employee_count
FROM Employees
GROUP BY job_title;

-- 38. Fetch employees whose names end with ‘n’
SELECT employee_id, first_name
FROM Employees
WHERE first_name LIKE '%n';

-- 39. Employees who work in both departments 101 and 102
SELECT employee_id
FROM Employees
WHERE department_id IN (101, 102)
GROUP BY employee_id
HAVING COUNT(DISTINCT department_id) = 2;

-- 40. Employees with the same salary
SELECT employee_id, salary
FROM Employees
WHERE salary IN (
    SELECT salary
    FROM Employees
    GROUP BY salary
    HAVING COUNT(*) > 1
);

-- 41. Update salaries based on department (e.g., 10% increase for dept 101)
UPDATE Employees
SET salary = salary * 1.10
WHERE department_id = 101;

-- 42. List employees without a department
SELECT employee_id
FROM Employees
WHERE department_id IS NULL;

-- 43. Max and min salary in each department
SELECT department_id, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM Employees
GROUP BY department_id;

-- 44. Employees hired in last 6 months
SELECT employee_id, hire_date
FROM Employees
WHERE hire_date >= DATEADD(MONTH, -6, GETDATE());

-- 45. Department-wise total and average salary
SELECT department_id, SUM(salary) AS total_salary, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department_id;

-- 46. Employees who joined in the same month/year as their manager
SELECT e.employee_id, e.hire_date, m.hire_date AS manager_hire_date
FROM Employees e
JOIN Employees m ON e.manager_id = m.employee_id
WHERE MONTH(e.hire_date) = MONTH(m.hire_date) AND YEAR(e.hire_date) = YEAR(m.hire_date);

-- 47. Count employees whose names start and end with the same letter
SELECT COUNT(*) AS matching_names
FROM Employees
WHERE LEFT(LOWER(first_name), 1) = RIGHT(LOWER(first_name), 1);

-- 48. Employee names and salaries in a single string
SELECT first_name + ' ' + last_name + ' earns ' + CAST(salary AS VARCHAR) AS info
FROM Employees;

-- 49. Employees earning more than their manager
SELECT e.employee_id, e.salary, e.manager_id, m.salary AS manager_salary
FROM Employees e
JOIN Employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

-- 50. Employees in departments with less than 3 people
SELECT employee_id, department_id
FROM Employees
WHERE department_id IN (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    HAVING COUNT(*) < 3
);

-- 51. Employees with the same first name
SELECT first_name, COUNT(*) AS name_count
FROM Employees
GROUP BY first_name
HAVING COUNT(*) > 1;

-- 52. Delete employees in the company for over 15 years
DELETE FROM Employees
WHERE DATEDIFF(YEAR, hire_date, GETDATE()) > 15;

-- 53. Employees under the same manager
SELECT manager_id, COUNT(*) AS report_count
FROM Employees
GROUP BY manager_id
HAVING COUNT(*) > 1;

-- 54. Top 3 highest-paid employees in each department
SELECT *
FROM (
    SELECT *, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rk
    FROM Employees
) AS Ranked
WHERE rk <= 3;

-- 55. Employees with over 5 years of experience in each department
SELECT employee_id, department_id, hire_date
FROM Employees
WHERE DATEDIFF(YEAR, hire_date, GETDATE()) > 5;

-- 56. Employees in departments with no hires in the last 2 years
SELECT *
FROM Employees
WHERE department_id IN (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    HAVING MAX(hire_date) < DATEADD(YEAR, -2, GETDATE())
);

-- 57. Employees earning more than the average of their department
SELECT *
FROM Employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
    WHERE department_id = e.department_id
);

-- 58. Managers with more than 5 subordinates
SELECT manager_id, COUNT(*) AS team_size
FROM Employees
GROUP BY manager_id
HAVING COUNT(*) > 5;

-- 59. Employee names and hire dates in "Name - MM/DD/YYYY" format
SELECT first_name + ' - ' + CONVERT(VARCHAR, hire_date, 101) AS formatted_output
FROM Employees;

-- 60. Employees in the top 10% salary range
SELECT *
FROM Employees
WHERE salary >= (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY salary) OVER ()
);

-- 61. Group employees by age brackets (20-30, 31-40, etc.)
SELECT employee_id,
    CASE 
        WHEN age BETWEEN 20 AND 30 THEN '20-30'
        WHEN age BETWEEN 31 AND 40 THEN '31-40'
        WHEN age BETWEEN 41 AND 50 THEN '41-50'
        ELSE '51+'
    END AS age_bracket
FROM (
    SELECT employee_id, DATEDIFF(YEAR, birth_date, GETDATE()) AS age
    FROM Employees
) AS AgeCalc;

-- 62. Average salary of top 5 paid employees per department
SELECT department_id, AVG(salary) AS avg_top_5_salary
FROM (
    SELECT department_id, salary, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rk
    FROM Employees
) AS Ranked
WHERE rk <= 5
GROUP BY department_id;

-- 63. Percentage of employees in each department
SELECT department_id, 
       COUNT(*) AS emp_count,
       CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS percentage
FROM Employees
GROUP BY department_id;

-- 64. Employees with emails from '@example.com'
SELECT employee_id, email
FROM Employees
WHERE email LIKE '%@example.com';

-- 65. Year-to-date sales for each customer
SELECT customer_id, SUM(sales_amount) AS ytd_sales
FROM Sales
WHERE order_date >= DATEFROMPARTS(YEAR(GETDATE()), 1, 1)
GROUP BY customer_id;

-- 66. Hire date and day of the week for each employee
SELECT employee_id, hire_date, DATENAME(WEEKDAY, hire_date) AS hire_day
FROM Employees;

-- 67. Employees older than 30 years
SELECT employee_id, 
       TRY_CONVERT (Date, birth_date,103) as Birthdate,
	   datediff (year, TRY_CONVERT (Date, birth_date,103), GETDATE()) as Age
	   FROM Employees
WHERE DATEDIFF(YEAR, TRY_CONVERT (Date, birth_date,103), GETDATE()) > 30;

-- 68. Group employees by salary range (0–20K, 20K–50K, etc.)
SELECT employee_id, 
       salary,
       CASE 
           WHEN salary BETWEEN 0 AND 50000 THEN '0-50K'
           WHEN salary BETWEEN 50001 AND 75000 THEN '50K-75K'
           ELSE '75K+'
           END AS salary_range
FROM Employees;

-- 69. Employees without a bonus
SELECT employee_id
FROM Employees
WHERE bonus IS NULL;

-- 70. Highest, lowest, and average salary for each job role
SELECT job_title,
       MAX(salary) AS max_salary,
	   MIN(salary) AS min_salary, 
	   AVG(salary) AS avg_salary
FROM Employees
GROUP BY job_title;
