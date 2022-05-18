use employees;

show tables;

-- Which table(s) do you think contain a numeric type column?
-- departments should contain a numeric column;

-- Which table(s) do you think contain a string type column?
-- dept_managemer should contain a string column;

-- Which table(s) do you think contain a date type column?
-- salaries should contain a date column;

-- What is the relationship between the employees and the departments tables?
-- Those two tables are connected by table dept_emp.

SHOW CREATE TABLE dept_manager;

-- 'CREATE TABLE `dept_manager` (
--   `emp_no` int NOT NULL,
--   `dept_no` char(4) NOT NULL,
--   `from_date` date NOT NULL,
--   `to_date` date NOT NULL,
--   PRIMARY KEY (`emp_no`,`dept_no`),
--   KEY `dept_no` (`dept_no`),
--   CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--   CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1'
