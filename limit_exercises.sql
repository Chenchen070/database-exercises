use employees;

-- 3
select * from employees
where hire_date like '199%' and birth_date like '%12-25'
order by hire_date limit 5;
-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

-- 4
select * from employees
where hire_date like '199%' and birth_date like '%12-25'
order by hire_date limit 5 offset 45;
-- offset = (limit * pageNumber) - limit
