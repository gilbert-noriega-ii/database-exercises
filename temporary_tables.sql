#Create a file named temporary_tables.sql to do your work for this exercise.
SHOW DATABASES;
USE darden_1038;

#Using the example from the lesson, re-create the employees_with_departments table.
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

SELECT *
FROM employees_with_departments;

#Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);
SELECT *
FROM employees_with_departments;

#Update the table so that full name column contains the correct data
UPDATE employees_with_departments 
SET full_name = CONCAT(first_name, ' ', last_name);
SELECT *
FROM employees_with_departments;

#Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
SELECT *
FROM employees_with_departments;

#What is another way you could have ended up with this same table?
#We could have created two temporary tables, one for the full name and the other for emp_no, dept_no and dept_name. after we created both we can combine the two temporary tables

#Create a temporary table based on the payment table from the sakila database.
SHOW DATABASES;
USE darden_1038;

CREATE TEMPORARY TABLE payment AS
SELECT payment_id, customer_id, staff_id, rental_id, amount, payment_date, last_update
FROM sakila.payment;

SELECT *
FROM payment;

#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
DESCRIBE payment;
ALTER TABLE payment
ADD amount_as_int INT(10);
UPDATE payment 
SET amount_as_int = amount*100;
ALTER TABLE payment DROP COLUMN amount;

#Find out how the average pay in each department compares to the overall average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department to work for? The worst?
SHOW DATABASES;
USE darden_1038;
CREATE TEMPORARY TABLE avg_pay AS
SELECT DISTINCT emp_no, dept_no, dept_name, salary, salaries.to_date
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
JOIN employees.salaries USING(emp_no)
WHERE employees.salaries.to_date > curdate();

SELECT *
FROM avg_pay;

CREATE TEMPORARY TABLE dept_avg_salary AS
SELECT dept_name, AVG(salary) as avg_salary
FROM avg_pay
GROUP BY dept_name;

ALTER TABLE dept_avg_salary ADD overall_avg_salary INT(10);
UPDATE dept_avg_salary
SET overall_avg_salary = (
	SELECT AVG(salary)
	FROM employees.salaries
	WHERE employees.salaries.to_date > curdate()
);

ALTER TABLE dept_avg_salary ADD stand_dev INT(10);
UPDATE dept_avg_salary
SET stand_dev = (
	SELECT STDDEV(salary)
	FROM employees.salaries
	WHERE employees.salaries.to_date > curdate()
);


SELECT *
FROM dept_avg_salary;

CREATE TEMPORARY TABLE z_scores AS
SELECT dept_name, (SELECT (avg_salary-overall_avg_salary)/stand_dev) as z_score
FROM dept_avg_salary;

select *
from z_scores;
