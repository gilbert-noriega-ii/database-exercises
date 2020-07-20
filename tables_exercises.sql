show databases;

# Use database_name
use employees;

select database();

show tables;

# DESCRIBE == Structure in Sequel Pro
describe employees;
describe departments;
describe salaries;

# Show CREATE TABLE == Table Info in Sequel Pro
show create table employees;
 
#Which table(s) do you think contain a numeric type column?
# titles, salaries, employees, dept_manager

#Which table(s) do you think contain a string type column?
#all except salary

#Which table(s) do you think contain a date type column?
#all except department
 
 #What is the relationship between the employees and the departments tables?
 #employees and departments are both tables inside of the employee database. Both tables are used to create another table called dept_emp 
 
 #Show the SQL that created the dept_manager table.
 describe dept_manager;
 
 show create table dept_manager;
 
 #CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1
 