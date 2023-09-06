
-- Open MySQL Workbench and login to the database server
-- Save your work in a file named db_tables_exercises.sql
-- List all the databases
show databases;
-- Write the SQL code necessary to use the albums_db database
USE albums_db;
-- Show the currently selected database
SELECT database();
-- List all tables in the database
SHOW TABLES;
-- Write the SQL code to switch to the employees database
use employees;
-- Show the currently selected database
select database();
-- List all tables in the database
show tables;
-- Explore the employees table. What different data types are present in this table?
describe employees;
-- This table contains int, date, varchar and date data types.employees
-- Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
-- dept_employees, dept_manager, employees, salary, titles
-- Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- departments, dept_emp, dept_manager, employees, title
-- Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- birth_date, hire_date
-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- They are related by dept_emp joiner table, which links the employee to the department.
-- Show the SQL code that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.show databases;
show create table dept_manager;