USE employees;
SELECT database();

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- First row: Irena Reutenauer; Last row: Vidya Simmen
SELECT *
FROM employees
WHERE first_name
IN ('Irena','Vidya','Maya')
ORDER BY first_name;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- First row: Irena Acton; Last row: Vidya Zweizig
SELECT *
FROM employees
WHERE first_name
IN ('Irena','Vidya','Maya')
ORDER BY first_name, last_name;

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
-- First row: Irena Acton; Last row: Maya Zyda
SELECT *
FROM employees
WHERE first_name
IN ('Irena','Vidya','Maya')
ORDER BY last_name, first_name;

-- Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
-- Number of employees returned: 899. First row: Employee 10021, Ramzi Erde; Last row: Employee 499648, Tadahiro Erde.
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY emp_no;

-- Write a query to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
-- Number of employees returned: 899. Newest employee: Teiji Eldridge; Oldest employee: Sergi Erde.

SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY hire_date DESC;

-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.
-- Number of employees returned: 362. Oldest employee: Alselm Capello; Newest employee: Khun Bernini.
SELECT *
FROM employees 
WHERE hire_date >= '1990-01-01'
AND hire_date < '1999-12-31'
AND birth_date LIKE '%12-25'
ORDER BY hire_date;