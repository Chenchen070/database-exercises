-- exercises:
#1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
use employees;

select emp_no, first_name, last_name, dept_no as 'department number', from_date as 'start date',
to_date as 'end date',
	if (to_date > now(), True, False) as 'is_current_employee'
from dept_emp
	join employees using (emp_no);
    
#2.Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
select concat(first_name,' ', last_name),
	case 
		WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
		WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
		ELSE 'R-Z'
	end as 'alpha_group'
from employees;

# review:
SELECT
    first_name,
    last_name,
    LEFT(last_name, 1) AS first_letter_of_last_name,
    CASE
        WHEN LEFT(last_name, 1) <= 'H' THEN 'A-H'
        WHEN SUBSTR(last_name, 1, 1) <= 'Q' THEN 'I-Q'
        WHEN LEFT(last_name, 1) <= 'Z' THEN 'R-Z'
    END AS alpha_group
FROM employees;

# 3. How many employees (current or previous) were born in each decade?
SELECT 
		CASE 
	WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '1950s'
	WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '1960s'
END AS 'decade_born', Count(*) AS number_of_born
FROM employees
GROUP BY decade_born;

# review:
SELECT
    COUNT(CASE WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN birth_date ELSE NULL END) AS '50s',
    COUNT(CASE WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN birth_date ELSE NULL END) AS '60s'
FROM employees;

-- Another way:
SELECT
    CONCAT(SUBSTR(birth_date, 1, 3), '0') as decade,
    COUNT(*)
FROM employees
GROUP BY decade;

# 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
select distinct case
	when dept_name in ('Research','Development') then 'R&D'
    when dept_name in ('Sales', 'Marketing') then 'Sales & Marketing'
    when dept_name in ('Production', 'Quality Management') then 'Prod & QM'
    when dept_name in ('Finance', 'Human Resources') then 'Finance & HR'
    when dept_name in ('Customer Service') then 'Customer Service'
end as department_group, avg(salary)
from departments
	join dept_emp using (dept_no)
    join salaries using (emp_no)
where dept_emp.to_date > now() and salaries.to_date > now()
group by department_group;

-- #1 but more complicated

SELECT 
	de.emp_no,
	dept_no,
	hire_date,
    from_date,
	to_date,
	IF(to_date > CURDATE(), 1, 0) AS current_employee
FROM dept_emp AS de
JOIN (SELECT 
			emp_no,
			MAX(to_date) AS max_date
		FROM dept_emp
		GROUP BY emp_no) as last_dept 
		ON de.emp_no = last_dept.emp_no
			AND de.to_date = last_dept.max_date
JOIN employees AS e ON e.emp_no = de.emp_no;




