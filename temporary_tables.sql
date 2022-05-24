use employees;

-- 1 Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.
select first_name, last_name, dept_name from employees as e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
where de.to_date > now();

create temporary table kalpana_1819.employees_with_departments as 
select first_name, last_name, dept_name from employees as e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
where de.to_date > now();

use kalpana_1819;

select * from employees_with_departments
limit 10;

-- a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
alter table employees_with_departments add full_name varchar(100);

-- b.Update the table so that full name column contains the correct data
update employees_with_departments set
full_name = concat(first_name,' ',last_name);

-- c. Remove the first_name and last_name columns from the table.
alter table employees_with_departments drop column first_name;

alter table employees_with_departments drop column last_name;

-- d. What is another way you could have ended up with this same table?
use employees;

select concat(first_name, ' ', last_name) as full_name, dept_name from employees as e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
where de.to_date > now();

create temporary table kalpana_1819.employees_with_departments1 as
select concat(first_name, ' ', last_name) as full_name, dept_name from employees as e
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
where de.to_date > now();

use kalpana_1819;
select * from employees_with_departments1;

-- 2. Create a temporary table based on the payment table from the sakila database.Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
use sakila;
select * from payment;

create temporary table kalpana_1819.payment_exercise as select * from payment;

use kalpana_1819;

select * from payment_exercise
limit 10;

ALTER TABLE payment_exercise MODIFY amount DECIMAL(10,0);

update payment_exercise set amount = amount*100;

-- 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
use employees;

# average salary for each department:
select dept_name, avg(salary) as avg_salary from  salaries as s
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
where de.to_date > now()
group by dept_name;

create temporary table kalpana_1819.dept_average_salary as 
select dept_name, avg(salary) as avg_salary from salaries as s
join dept_emp as de using (emp_no)
join departments as d using (dept_no)
where de.to_date > now()
group by dept_name;

use kalpana_1819;

select * from dept_average_salary;
drop table if exists dept_average_salary;

# average salary overall:
select avg(salary) from salaries
where to_date > now();
-- 72012.2359
create temporary table kalpana_1819.avg_overall as 
select avg(salary) from salaries
where to_date > now();

# std salary overall:
use employees;
select std(salary) from salaries
where to_date > now();
-- 17309.95933634675
create temporary table kalpana_1819.std_overall as 
select std(salary) from salaries
where to_date > now();

# z-score:
use kalpana_1819;

select dept_name, ((dept_average_salary.avg_salary - (select * from avg_overall))/
(select * from std_overall)) as z_score
		from dept_average_salary;

select * from dept_average_salary;

# z-score reference:
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;