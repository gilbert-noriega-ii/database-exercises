#Create a new SQL script named limit_exercises.sql.
#MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

show databases;
use employees;

#List the first 10 distinct last name sorted in descending order.
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

#Find your query for employees born on Christmas and hired in the 90s from order_by_exercises.sql. Update it to find just the first 5 employees
SELECT first_name, last_name
FROM employees
WHERE hire_date LIKE '199%-%-%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5;

#Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results
SELECT first_name, last_name
FROM employees
WHERE hire_date LIKE '199%-%-%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 5 OFFSET 45;

#LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?
#OFFSET can be used to scroll through the number of results on a page. If you have 10 results on a page and you want to scroll to the second page then you can OFFSET by 10 anf you would move to the "second page"