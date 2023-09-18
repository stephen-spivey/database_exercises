-- Find all the current employees with the same hire date as employee 101010 using a subquery.
USE employees;
SELECT * 
FROM employees
WHERE hire_date = (SELECT hire_date
					FROM employees
					WHERE emp_no = 101010
					);

-- Find all the titles ever held by all current employees with the first name Aamod.
SELECT title
FROM titles as t
WHERE title IN (
	SELECT title
	FROM employees as e
	INNER JOIN titles
	on e.emp_no = t.emp_no
	WHERE first_name = 'Aamod')
    ;

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
-- There are 331,416 employees no longer working for the company.
SELECT count(e.emp_no) 
FROM employees as e
INNER JOIN titles as t
	on t.emp_no = e.emp_no
WHERE e.emp_no IN 
		(SELECT emp_no
		FROM titles
		WHERE to_date < curdate())
		;

-- Find all the current department managers that are female. List their names in a comment in your code.
-- Shirish Ossenbruggen, Krassimir Wegerle, Rosine Cools, Peternela Onuegbe, Rutger Hofmeyr, Sanjoy Quadeer, Tonny Butterworth, Marjo Giarratana, Xiaobin Spinelli
SELECT * 				
FROM employees as e
INNER JOIN dept_manager as dm
on dm.emp_no = e.emp_no
WHERE gender = 'F'
AND to_date > curdate();

-- Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT *			
from employees as e
INNER JOIN salaries as s
on s.emp_no = e.emp_no
WHERE to_date > curdate() and salary > (select avg(salary)
								from salaries);


-- How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate 
-- the standard deviation.) What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

SELECT salary
FROM salaries
WHERE salary BETWEEN (stdev(salary + 
	FROM salaries
	WHERE to_date > NOW()
	ORDER BY salary DESC
	LIMIT 1)
AND
	(SELECT stdev(salary)
	from salaries < 1);