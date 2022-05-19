use employees;

-- 2
select * from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name;
-- first row of the results : Irena Reutenauer
-- last row of the results: Vidya Simmen

-- 3
select * from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name, last_name;
-- first row : Irena Acton
-- last row : Vidya Zweizig

-- 4
select * from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by last_name, first_name;
-- first row : Irena Acton
-- last row : Maya Zyda

-- 5
select * from employees
where last_name like 'E%' and last_name like '%E'
order by emp_no;
-- 899
-- 'e%e'
-- first : '10021', 'Ramzi', 'Erde'
-- last : '499648', 'Tadahiro', 'Erde'

-- 6
select * from employees
where last_name like 'E%' and last_name like '%E'
order by hire_date desc;
-- 899
-- 'e%e'
-- newest : Teiji Eldridge
-- oldest : SErgi Erde

-- 7
select * from employees
where hire_date like '199%' and birth_date like '%12-25'
order by birth_date asc, hire_date desc;
-- 362
-- oldest employee who was hired last : Khun Bernini
-- youngest employee who was hired first : Douadi Pettis

