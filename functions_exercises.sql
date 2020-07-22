 #Copy the order by exercise and save it as functions_exercises.sql.

SHOW DATABASES;
USE employees;


/*#Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson
#Create a file named where_exercises.sql. Make sure to use the employees database
SHOW DATABASES;
USE employees;

#Find all employees with first names 'Irena', 'Vidya', or 'Maya' — 709 rows (Hint: Use IN)
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

#Find all employees whose last name starts with 'E' — 7,330 rows
SELECT * 
FROM employees
WHERE last_name LIKE 'E%';

#Find all employees hired in the 90s — 135,214 rows
SELECT * 
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';

#Find all employees born on Christmas — 842 rows
SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';

#Find all employees with a 'q' in their last name — 1,873 rows
SELECT *
FROM employees
WHERE last_name LIKE '%q%';

#Update your query for 'Irena', 'Vidya', or 'Maya' to use OR instead of IN — 709 rows
SELECT *
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';

#Add a condition to the previous query to find everybody with those names who is also male — 441 rows
SELECT *
FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
AND gender = 'M';

#Find all employees whose last name starts or ends with 'E' — 30,723 rows
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E';

#Duplicate the previous query and update it to find all employees whose last name starts and ends with 'E' — 899 rows
SELECT *
FROM employees
WHERE last_name LIKE 'E%E';

#Find all employees hired in the 90s and born on Christmas — 362 rows
SELECT *
FROM employees
WHERE hire_date LIKE '199%-%-%'
AND birth_date LIKE '%-12-25';

#Find all employees with a 'q' in their last name but not 'qu' — 547 rows
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
and last_name NOT LIKE '%qu%';


#Modify your first query to order by first name. The first result should be Irena Reutenauer and the last result should be Vidya Simmen
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

#Update the query to order by first name and then last name. The first result should now be Irena Acton and the last should be Vidya Zweizig
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

#Change the order by clause so that you order by last name before first name. Your first result should still be Irena Acton but now the last result should be Maya Zyda
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

#Update your queries for employees with 'E' in their last name to sort the results by their employee number. Your results should not change
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E'
ORDER BY emp_no;

SELECT *
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;

#Now reverse the sort order for both queries
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E'
ORDER BY emp_no DESC;

SELECT *
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no DESC;

#Change the query for employees hired in the 90s and born on Christmas such that the first result is the oldest employee who was hired last. It should be Khun Bernini
SELECT *
FROM employees
WHERE hire_date LIKE '199%-%-%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC; */




#Update your queries for employees whose names start and end with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name,' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;

#Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name,' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'E%E'
ORDER BY emp_no;

#For your query of employees born on Christmas and hired in the 90s, use datediff() to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE())
SELECT DATEDIFF(CURDATE(), birth_date) AS days_with_the_company
FROM employees
WHERE hire_date LIKE '199%-%-%'
AND birth_date LIKE '%-12-25';

#Find the smallest and largest salary from the salaries table.
SELECT MIN(salary) AS smallest_salary, MAX(salary) AS largest_salary
FROM salaries;

#Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), "_", SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) AS username, first_name, last_name, birth_date
FROM employees
LIMIT 10;
