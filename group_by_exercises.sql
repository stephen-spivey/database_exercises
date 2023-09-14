USE employees;

-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
-- There are 7 unique titles.
SELECT DISTINCT title
FROM titles;

-- Write a query to find a list of all unique last names that start and end with 'E' using GROUP BY.
SELECT DISTINCT last_name
FROM employees
HAVING last_name LIKE '%e'
AND last_name LIKE 'E%';

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
select distinct first_name, last_name
from employees
having last_name like 'E%' and last_name like '%E'
order by last_name;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
-- Last names Chleq, Lindqvist, and Qiwen.
SELECT DISTINCT last_name
FROM employees
HAVING last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';

-- Add a COUNT() to your results for exercise 5 to find the number of employees with the same last name.
SELECT 
	DISTINCT last_name, 
	COUNT(*)
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%'
AND last_name NOT LIKE '%qu%';

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees with those names for each gender.
SELECT 
	first_name
	, gender
    , COUNT(*)
FROM employees
WHERE first_name = 'Irena' 
OR first_name = 'Vidya' 
OR first_name = 'Maya'
GROUP BY first_name, gender;

-- Using your query that generates a username for all employees, generate a count of employees with each unique username.
SELECT lower(
concat(
substr(first_name, 1, 1),
substr(last_name, 1,4),
'_',
substr(birth_date, 6, 2),
substr(birth_date, 3,2)))
AS username,
count(*)
FROM employees
GROUP BY username;

-- From your previous query, are there any duplicate usernames? What is the highest number of times a username shows up? Bonus: How many duplicate usernames are there?
SELECT lower(
concat(
substr(first_name, 1, 1),
substr(last_name, 1,4),
'_',
substr(birth_date, 6, 2),
substr(birth_date, 3,2)))
AS username,
count(*) as cnt
FROM employees
GROUP BY username
HAVING 
ORDER BY cnt;
