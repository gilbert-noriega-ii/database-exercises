show databases;

use employees;

select database();

show tables;

describe employees;

show create table employees;
 
 #emp_no, birth_date, hire_date
 #first_name, last_name
 #gender
 
 describe departments;
 
 #employees and departments are both tables inside of the employee database
 
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
 