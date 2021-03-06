use join_example_db;

select * from roles;
select * from users;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
left JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- 3
SELECT count(users.name AS user_name), roles.name AS role_name
FROM users
JOIN roles ON users.role_id = roles.id
group by role_name;

-- 1
use employees;
-- 2
SELECT d.dept_name AS 'Department Name', 
	concat(first_name, ' ', last_name) as 'Department Manager'
FROM employees as e
JOIN dept_manager as de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
order by d.dept_name asc;

-- 3 Find the name of all departments currently managed by women.
SELECT d.dept_name AS 'Department Name', 
	concat(first_name, ' ', last_name) as 'Department Manager'
FROM employees as e
JOIN dept_manager as de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' and gender = 'F'
order by d.dept_name asc;

-- 4 Find the current titles of employees currently working in the Customer Service department.
select title as 'Title', count(*) as Count from titles as t
	join dept_emp as de
	on de.emp_no = t.emp_no
		join departments as d
			on d.dept_no = de.dept_no
	where t.to_date = '9999-01-01' 
    and dept_name = 'Customer Service'
group by title
order by title asc;


-- 5 Find the current salary of all current managers.
SELECT d.dept_name AS 'Department Name', 
	concat(first_name, ' ', last_name) as 'Name',
    salary
FROM employees as e
JOIN dept_manager as de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
join salaries as s
  on s.emp_no = e.emp_no
WHERE de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
order by d.dept_name asc;

-- 6 Find the number of current employees in each department.
select d.dept_no as dept_no, dept_name, count(emp_no) as num_employees
from departments as d
	join dept_emp as de
		on d.dept_no = de.dept_no
where de.to_date = '9999-01-01'
group by dept_no, dept_name
order by dept_no;

-- 7 Which department has the highest average salary? Hint: Use current not historic information.
select dept_name, AVG(salary) as average_salary 
from salaries as s
	join dept_emp as de
		on de.emp_no = s.emp_no
	join departments as d
		on d.dept_no = de.dept_no
where de.to_date = '9999-01-01'
group by dept_name
order by average_salary desc
limit 1;
    
-- 8 Who is the highest paid employee in the Marketing department?
select first_name, last_name, salary from employees as e
	join salaries as s
		on s.emp_no = e.emp_no
	join dept_emp as de
		on de.emp_no = e.emp_no
    join departments as d
		on d.dept_no = de.dept_no
where dept_name = 'Marketing'
order by salary desc
limit 1;

-- 9 Which current department manager has the highest salary?
select first_name, last_name, salary, dept_name
from employees as e
	join salaries as s
		on s.emp_no = e.emp_no
    join dept_manager as de
		on de.emp_no = e.emp_no
    join departments as d
		on d.dept_no = de.dept_no
where de.to_date = '9999-01-01'
order by salary desc
limit 1;

-- 10 Determine the average salary for each department. Use all salary information and round your results.
select dept_name, avg(salary) as average_salary 
from salaries as s
	join dept_emp as de
		on de.emp_no = s.emp_no
    join departments as d
		on d.dept_no = de.dept_no
group by dept_name
order by average_salary desc;

-- 11 Find the names of all current employees, their department name, and their current manager's name.
    
SELECT
	CONCAT(e.first_name, " ", e.last_name) AS "Employee NAME",
	d.dept_name AS "Department NAME",
	mn.manager_name AS "Manager NAME"
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
LEFT JOIN
	(SELECT
		CONCAT(e.first_name, " ", e.last_name) AS manager_name, dm.dept_no
		FROM dept_manager AS dm
		JOIN employees AS e ON e.emp_no = dm.emp_no
		WHERE dm.to_date > NOW()) AS mn ON mn.dept_no = de.dept_no
WHERE de.to_date > NOW();

-- 12 Find the highest paid employee in each department
 
SELECT 
 	CONCAT(e.first_name,' ',e.last_name) AS "Employee NAME", 
 	d.dept_name AS "Department NAME",
 	ms.max_salary_by_department AS "Salary"
 FROM employees e
 JOIN dept_emp de ON de.emp_no = e.emp_no
 JOIN departments d ON de.dept_no = d.dept_no 
 JOIN salaries s ON e.emp_no = s.emp_no
 JOIN (
 	SELECT
 		MAX(s.salary) AS "max_salary_by_department",
 		d.dept_name 
	FROM salaries AS s
	JOIN employees AS e ON e.emp_no = s.emp_no
	JOIN dept_emp AS de ON de.emp_no = e.emp_no
	JOIN departments AS d ON d.dept_no = de.dept_no
	GROUP BY d.dept_name
		) AS ms ON ms.dept_name = d.dept_name AND ms.max_salary_by_department = s.salary
 WHERE de.to_date > NOW() AND s.to_date > NOW();
