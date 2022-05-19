-- Copy the order by exercise and save it as functions_exercises.sql.

-- Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
use employees;

select concat(first_name, last_name) as full_name from employees
where last_name like '%E' and last_name like 'E%';

-- Convert the names produced in your last query to all uppercase.
select upper(concat(first_name, last_name)) as full_name from employees
where last_name like '%E' and last_name like 'E%';

-- Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
select *, datediff(now(), hire_date) as days from employees
where hire_date like '199%' and birth_date like '%12-25';

-- Find the smallest and largest current salary from the salaries table.
select min(salary) from employees.salaries;
-- 38623
select max(salary) from employees.salaries;
-- 158220
