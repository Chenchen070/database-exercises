use employees;

-- 2
select count(distinct(title))
from employees.titles;

select distinct title from titles;
-- 7

-- 3
select distinct(last_name) from employees
where last_name like 'e%e'
group by last_name;
-- 'Erde','Eldridge','Etalle','Erie','Erbe'
-- 'e__e'

-- 4
select distinct concat(first_name, last_name) from employees
where last_name like 'e%e';

select first_name, last_name from employees
where last_name like '%e%'
group by first_name, last_name;

-- 846

-- 5
select distinct(last_name) from employees
where last_name like '%q%' and last_name not like '%qu%';
-- Chleq, Lindqvist, Qiwen

-- 6
select last_name, count(last_name) from employees
group by last_name;

-- 7 
select gender, count(*) from employees
where first_name in ('Irena', 'Vidya', 'Maya')
group by gender;
-- 'M', '441' ; 'F', '268'

-- 8
select 
	lower(
			concat(
				substr(first_name,1,1),
				substr(last_name,1,4),
                '_',
                substr(birth_date,6,2),
                substr(birth_date,3,2)
                )
			) as username, 
	count(*) as count_of_username
 from employees
 group by username
 having count_of_username > 1;
 

