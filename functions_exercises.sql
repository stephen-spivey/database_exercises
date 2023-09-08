-- Copy the order by exercise and save it as functions_exercises.sql.

-- Write a query to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together 
-- as a single column named full_name.
USE employees;
SELECT CONCAT(first_name," ", last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%e';

-- Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name," ", last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%e';


-- Use a function to determine how many results were returned from your previous query.
SELECT COUNT(UPPER(CONCAT(first_name," ", last_name)))
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%e';

-- Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the 
-- company (Hint: You will also need to use NOW() or CURDATE()),
SELECT CONCAT(first_name," ", last_name) AS full_name,
DATEDIFF(CURDATE(), hire_date) AS Days_Employed
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25';

-- Find the smallest and largest current salary from the salaries table.
SELECT MIN(salary)
FROM salaries;

SELECT MAX(salary)
FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and 
-- consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month 
-- the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

SELECT LOWER(concat(
	left(first_name,1), left(last_name,4),
    '_',
    date_format(birth_date, '%m'), 
    right(year(birth_date),2)
    )) as username,
    first_name,
    last_name,
    birth_date

FROM 
	employees;