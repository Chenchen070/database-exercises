use employees;

-- 2
select count(first_name) from employees
where first_name in ('Irena', 'Vidya', 'Maya');
-- 709

-- 3
select count(first_name) from employees
where first_name = 'Irena' or first_name ='Vidya' or first_name ='Maya';
-- 709

-- 4
select count(first_name) from employees
where first_name in ('Irena', 'Vidya', 'Maya') and gender = 'M';
-- 441

-- 5
select count(last_name) from employees
where last_name like 'E%';
-- 7330 starts with 'E'

-- 6
select count(last_name) from employees
where last_name like 'E%' or last_name like '%E';
-- 30723 starts or ends with 'E'

select 30723 - 7330;
-- 23393 ends with E, but does not start with E

-- 7
select count(last_name) from employees
where last_name like 'E%' and last_name like '%E';
-- 899 starts and ends with 'E'
select count(last_name) from employees
where last_name like '%E';
-- 24292 ends with 'E'

-- 8
select count(hire_date) from employees
where hire_date like '199%';
-- 135214 hired in the 90s

-- 9
select count(birth_date) from employees
where birth_date like '%12-25';
-- 842 born on Christmas

-- 10
select count(*) from employees
where hire_date like '199%' and birth_date like '%12-25';
-- 362 hired in the 90s and born on Christmas

-- 11
select count(*) from employees
where last_name like '%q%';
-- 1873 with a 'q' in their last name

-- 12
select count(*) from employees
where last_name like '%q%' and last_name not like '%qu%';
-- 547 with a 'q' in their last name but not 'qu'