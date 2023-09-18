-- Write a query that returns all employees, their department number, their start date, their end date, 
-- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. 
-- DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
use employees;

select 
	concat(first_name, ' ', last_name) as full_name,
    dept_no,
    from_date,
    to_date
    , IF(to_date > now(), True, False) as is_current_employee
from
	employees as e
inner join dept_emp as de
	on e.emp_no = de.emp_no
;

-- Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 
-- 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
select 
	first_name,
    last_name
    , case 
		WHEN last_name < 'I' THEN 'A-H'
        WHEN LEFT(last_name,1) <= 'Q' THEN 'I-Q'
        ELSE 'R-Z'
	end as alpha_group
from
	employees
;

-- How many employees (current or previous) were born in each decade?
select 
    COUNT(*)
    , case
		WHEN birth_date like '195%' THEN '50s'
        WHEN birth_date like '196%' THEN '60s'
        else 'Others'
	end as decade_of_birth
from employees
GROUP BY decade_of_birth
;
        
-- What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, 
-- Finance & HR, Customer Service?
select
	CASE 
		WHEN dept_name IN ('Research','Development') THEN 'R&D'
        WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
        WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
        WHEN dept_name IN ('Finance','Human Resources') THEN 'Finance & HR'
        ELSE dept_name 
	END as 'dept_group'
    , ROUND(AVG(salary),2) as avg_sal
from salaries
	join dept_emp
		using (emp_no)
	join departments
		using (dept_no)
where salaries.to_date > now()
	AND dept_emp.to_date > now()
GROUP BY dept_group
;	