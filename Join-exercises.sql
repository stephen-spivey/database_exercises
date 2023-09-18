-- Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
-- CMD+SHIFT+RETURN: returns multiple tabs to view multiple queries
-- ****** HIGHLIGHT THE QUERIES YOU WANT TO OPEN TABS FOR
SELECT *
FROM users;

SELECT *
FROM roles;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.
SELECT *
FROM users as u
-- Joining matching observations ONLY
INNER JOIN roles as r
ON u.role_id = r.id;

SELECT *
FROM users as u
-- all LEFT table observations
-- and matching RIGHT rows, expecting NULLs on non-matching
LEFT JOIN roles as r
ON u.role_id = r.id;

SELECT *
FROM users as u
-- all RIGHT tabke observations
-- and matching LEFT rows, expecting NULLs on non-matching
RIGHT JOIN roles as r
ON u.role_id = r.id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.
SELECT r.`name` as role_name
	,count(u.`name`) as role_count
FROM users as u
-- want all roles listed
RIGHT JOIN roles as r
ON r.id = u.role_id
GROUP BY r.`name`;


-- Employees Database
USE employees;
-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name 
-- of the current manager for that department.
SELECT d.dept_name AS 'Department Manager'  -- departments.dept_name, employees.first_name, employees.last_name
	,concat(e.first_name,e.last_name) 
FROM departments as d
INNER JOIN dept_manager as dm
ON dm.dept_no = d.dept_no
INNER JOIN employees as e
ON e.emp_no = dm.emp_no
WHERE dm.to_date >= NOW();

-- Find the name of all departments currently managed by women.
SELECT 
	gender
    ,d.dept_name as 'Department Name'
	,concat(e.first_name,' ',e.last_name) as 'Department Manager'
from departments as d
INNER JOIN dept_manager as dm
INNER JOIN employees as e
 ON e.emp_no = dm.emp_no
 WHERE dm.to_date >= now()
 and e.gender = 'F'
 order by d.dept_name ASC;


-- Find the current titles of employees currently working in the Customer Service department.
select * from departments; -- 'd009' =. cust serv.

select 
	t.title
	,count(t.title) as Count
from titles as t
inner join employees as e
	on e.emp_no = t.emp_no
inner join dept_emp as de
	on de.emp_no = e.emp_no
where de.to_date > curdate()
	AND t.to_date > curdate()
    AND de.dept_no = 'd009'
group by t.title
order by t.title 
;

-- Find the current salary of all current managers.
select -- *
	d.dept_name as 'Department Name'
    ,concat(e.first_name, ' ', e.last_name) as 'Name'
from departments as d
inner join dept_manager as dm
	on dm.dept_no = d.dept_no
inner join employees as e
	on e.emp_no = dm.emp_no
inner join salaries as s
	on s.emp_no = e.emp_no
where dm.to_date >= now() -- filter for current managers
	and s.to_date >curdate() -- filter for current salary
order by d.dept_name
;

-- Find the number of current employees in each department.
select -- *
	d.dept_no
	,d.dept_name
    ,count(*) as num_employees
from dept_emp as de
-- start with all observations from DE table
-- and matching depts observations
LEFT JOIN departments as d
	on d.dept_no = de.dept_no
where de.to_date > curdate()
group by d.dept_name
order by d.dept_no
;


-- Which department has the highest average salary? Hint: Use current not historic information.
select -- * 
	d.dept_name
    , concat( '$ ', round(avg(s.salary),2)) as average_salary
from salaries as s
-- only want for the name so UNNECESSARY
LEFT JOIN employees as e -- want to keep all salaries observations
	ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de -- will keep only MATCHING observations between Employees and Dept_emp
	on de.emp_no = s.emp_no
INNER JOIN departments as d
	on d.dept_no = de.dept_no
WHERE de.to_date > CURDATE()
	AND s.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY avg(s.salary) DESC
LIMIT 1
;

-- Who is the highest paid employee in the Marketing department?
select -- *
	e.first_name
    ,e.last_name
from salaries as s
LEFT JOIN employees as e -- want to keep all salaries observations; 
	ON e.emp_no = s.emp_no
INNER JOIN dept_emp as de -- will keep only MATCHING observations
	ON de.emp_no = e.emp_no
INNER JOIN departments as d  -- will keep only MATCHING observations
	ON d.dept_no = de.dept_no
WHERE d.dept_name = 'marketing'
	AND de.to_date > NOW() -- currently employed
    AND s.to_date > NOW() -- current salary
ORDER BY s.salary DESC
LIMIT 1
;
-- Which current department manager has the highest salary?
select -- *
	e.first_name
    ,e.last_name
    ,s.salary
    ,d.dept_name
from employees as e 
INNER JOIN dept_manager dm
	ON dm.emp_no = e.emp_no
LEFT JOIN salaries as s
	ON s.emp_no = e.emp_no
INNER JOIN departments as d
	ON d.dept_no = dm.dept_no
WHERE dm.to_date > NOW()
	AND s.to_date > NOW()
ORDER BY s.salary DESC
LIMIT 1
;

-- Determine the average salary for each department. Use all salary information and round your results.
select -- *
	d.dept_name
    ,ROUND(avg(s.salary)) AS average_salary
from salaries as s
LEFT JOIN dept_emp as de
	ON de.emp_no = s.emp_no
INNER JOIN departments as d
	ON d.dept_no = de.dept_no
GROUP BY d.dept_name
ORDER BY ROUND(avg(s.salary)) DESC
;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.




