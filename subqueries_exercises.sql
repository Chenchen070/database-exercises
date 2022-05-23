use employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query
select * from employees
	join dept_emp using (emp_no)
where hire_date in (select hire_date from employees
where emp_no = 101010)
and to_date > now();

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
select * from titles
where emp_no in (select emp_no from employees
where first_name = 'Aamod')
and to_date > now();

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
select emp_no from dept_emp
where to_date < now();

select count(*) from employees
where emp_no in (select emp_no from dept_emp
where to_date < now());
-- 85108

-- 4 Find all the current department managers that are female. List their names in a comment in your code.
select emp_no from dept_manager
where to_date > now();

select first_name, last_name from employees
where emp_no in (select emp_no from dept_manager
where to_date > now())
and gender = 'F';
-- 'Isamu', 'Legleitner'
-- 'Karsten', 'Sigstam'
-- 'Leon', 'DasSarma'
-- 'Hilary', 'Kambil' 

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
select avg(salary) from salaries
where to_date < now();
-- 63054.4341

select * from employees
	join salaries using (emp_no)
where salary > (select avg(salary) from salaries
where to_date < now())
and to_date > now()
order by salary asc;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary?
select max(salary) from salaries
where to_date > now();
-- highest 158220.

select count(*) as total, 
(count(*)/(select count(*)from salaries
							where to_date > now())* 100) as percent_of_total
from salaries
where salary > (select max(salary) - stddev(s.salary)
				from salaries as s)
and to_date > now();



