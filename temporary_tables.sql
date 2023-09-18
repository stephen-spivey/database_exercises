select database();
use tobias_2308;
-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, 
-- last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your 
-- own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a 
-- database that you can only read.
create temporary table employees_with_departments(
	select
		first_name
        , last_name
        , dept_name
	from employees.employees as e
    join employees.dept_emp as de
		on de.emp_no = e.emp_no
	join employees.departments as d
		on d.dept_no = de.dept_no
	where to_date > now()
    );

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name 
-- and last name columns.
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);
select *
from employees_with_departments;

-- Update the table so that the full_name column contains the correct data.
Update employees_with_departments
	set full_name = concat(first_name, ' ', last_name);

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;
select *
from employees_with_departments;
-- What is another way you could have ended up with this same table?
-- ANS: in Select statement

-- Create a temporary table based on the payment table from the sakila database.
create temporary table sak_pay as (
	select * from sakila.payment);

    
-- 2. Write the SQL necessary to transform the amount 
-- column such that it is stored as an integer 
-- representing the number of cents of the payment. 
-- For example, 1.99 should become 199.
select * from sak_pay;

describe sak_pay;


ALTER TABLE sak_pay
MODIFY amount int;

-- making those changes to our integer values 
update sak_pay
set amount = amount * 100;





-- an alternative solution utilizing the cast function
create temporary table sak_pay as (
	select
		payment_id
        ,customer_id
        ,staff_id
        ,rental_id
        ,cast(amount as decimal)
		,payment_date
        ,last_update
	FROM sakila.payment);
	

-- 3. Go back to the employees database. 
-- Find out how the current average pay in each 
-- department compares to the overall current pay 
-- for everyone at the company. For this comparison, 
-- you will calculate the z-score for each salary. 
-- In terms of salary, what is the best department 
-- right now to work for? The worst?

drop table dept_avgs;


select database();
use employees;

-- 2 part question we want to pull avg salary for each 
-- department first then make our z-score calucaltions

-- step 1:
SELECT 
	-- just dept names and avg salaries
	dept_name,
    AVG(salary) AS dept_avg
FROM 
	-- departments from employees schema
	departments d
JOIN dept_emp de
	-- link dept_no to dept_emp
	USING(dept_no)
JOIN salaries s
	-- link emp_no to salaries
	USING(emp_no)
WHERE 
	-- current employees salaries in active departments
	de.to_date > NOW()
	AND 
    s.to_date > NOW()
-- aggregate based on department
GROUP BY dept_name;


drop table dept_avgs;
/*
ERROR HANDLING!
when creating our table recieved a DATA TRUNCATED error for our
dept_avg column. Problem was our column values were too large. Strange behavior!
Solution was to CAST() this column to a decimal with 10 digits places by default 
and the error was resolved
*/

create temporary table dept_avgs (
SELECT 
	-- just dept names and avg salaries
	dept_name,
    cast(AVG(salary) as decimal) AS dept_avg -- casting our column to handle weird error
FROM 
	-- departments from employees schema
	departments d
JOIN dept_emp de
	-- link dept_no to dept_emp
	USING(dept_no)
JOIN salaries s
	-- link emp_no to salaries
	USING(emp_no)
WHERE 
	-- current employees salaries in active departments
	de.to_date > NOW()
	AND 
    s.to_date > NOW()
-- aggregate based on department
GROUP BY dept_name
);



/*
want to add 3 initially empty columns that will hold 
values for our overall average, overall standard deviation,
and zscores
*/

select * from dept_avgs;

alter table dept_avgs
add sample_mean float; -- could add single columns

alter table dept_avgs
add stand_dev float, -- could add multipl columns with a comma
add zscore float;


drop table metrics; -- for dropping and fixing things

/*
now that we have our empty columns
we want to add values into those columns
we can create another Temp table 
to do this update our dept_avgs table with values 
form our metrics table

theses two values will be constants 
(same value for all rows)
*/
create temporary table metrics (
select 
	cast(avg(salary) as decimal) as sample_means, -- calculates overall average
    stddev(salary) as stdv						-- caluclates overall stddv
from salaries
where to_date > now()
);


-- insert values into our newly created empty columns
-- lets start with sample_mean

-- updates empty values into our sample mean constant pulled from the metrics table
update dept_avgs
	set sample_mean = (select sample_means from metrics);
    
update dept_avgs
	set stand_dev = (select stdv from metrics);
    
update dept_avgs
	set zscore = ((dept_avg-sample_mean)/stand_dev);


-- which departments were the best or the worst?
select * from metrics;
select * from dept_avgs
	order by zscore desc;
    
/*
In terms of salary, Sales is the best department 
and Human Resources is the worst

In terms of z-score,
all values appear to be relativley 
close to the average but I would say 
Sales department is the worst on average  since its furthest from 0
and Research is the best since its closest to 0 
*/