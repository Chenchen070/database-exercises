use employees;

-- boolean match/cast
select dept_name, dept_name = 'Research' as is_research
from departments;

-- if()
-- use this function if you evaluating to a true/false outcome

select dept_name, if (dept_name = 'Research', True, False)
as is_research from departments;

-- case: option one
-- use if you have more than 2 values
-- use if you need more flexibility in your conditional text
select dept_name, 
	case dept_name
		when 'Research' then 1
        else 0
	end as is_research
from departments;

-- case :option two
select dept_name,
case
	when dept_name in ('Marketing','Sales') then 'Money Makers'
    when dept_name like '%research%' or dept_name like '%resources%' then 'People People'
    else 'Others'
end as department_categories
from departments;

-- using case statements to create a pivot table

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

# 3. How many employees (current or previous) were born in each decade?
SELECT 
		CASE 
	WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '1950s'
	WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '1960s'
END AS 'decade_born', Count(*) AS number_of_born
FROM employees
GROUP BY decade_born;

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


