#Use the join_example_db. Select all the records from both the users and roles tables.
SHOW DATABASES;
USE join_example_db;
SELECT *
FROM users;
SELECT *
FROM roles;

#Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles ON roles.id = users.role_id;
SELECT *
FROM users 
LEFT JOIN roles ON roles.id = users.role_id;
SELECT * 
FROM users
RIGHT JOIN roles ON roles.id = users.role_id;

#Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name, COUNT(role_id)
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.id;

#Use the employees database.
SHOW DATABASES;
USE employees;

#Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT dept_name, CONCAT(first_name, ' ', last_name) AS department_manager
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no
JOIN employees AS e ON e.emp_no = dm.emp_no 
					AND dm.to_date > curdate()
ORDER BY dept_name;

#Find the name of all departments currently managed by women.
SELECT dept_name, CONCAT(first_name, ' ', last_name) AS department_manager
FROM departments AS d
JOIN dept_manager AS dm ON d.dept_no = dm.dept_no 
JOIN employees AS e ON e.emp_no = dm.emp_no 
					AND dm.to_date > curdate() 
					AND gender = 'F'
ORDER BY dept_name;

#Find the current titles of employees currently working in the Customer Service department.
SELECT title, COUNT(*)
FROM dept_emp
JOIN titles ON dept_emp.emp_no = titles.emp_no 
			AND dept_no = 'd009' 	
			AND titles.to_date > curdate() 
			AND dept_emp.to_date > curdate()
GROUP BY title;

#Find the current salary of all current managers.
SELECT dept_name, CONCAT(first_name, ' ', last_name) as full_name, salary
FROM dept_manager AS dm 
JOIN salaries AS s ON dm.emp_no = s.emp_no 
					AND s.to_date > curdate() 
					AND dm.to_date > curdate()
JOIN departments AS d ON dm.dept_no = d.dept_no
JOIN employees AS e ON dm.emp_no = e.emp_no
ORDER BY dept_name;

#Find the number of employees in each department.
SELECT d.dept_no, dept_name, COUNT(emp_no)
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no 
					  AND de.to_date > curdate()
GROUP BY d.dept_no;

#Which department has the highest average salary? Hint: Use current not historic information.
SELECT dept_name, AVG(salary) as average_salary
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no 
					AND s.to_date > curdate() 
					AND de.to_date > curdate()
JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

#Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name, MAX(salary) AS salary
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no 
					AND dept_no = 'd001' 	
					AND s.to_date > curdate() 
					AND de.to_date > curdate()
JOIN employees AS e ON de.emp_no = e.emp_no
GROUP BY de.emp_no
ORDER BY salary DESC
LIMIT 1;

#Which current department manager has the highest salary?
SELECT first_name, last_name, salary, dept_name
FROM dept_manager AS dm
JOIN salaries AS s ON dm.emp_no = s.emp_no 
					AND dm.to_date > curdate() 
					AND s.to_date > curdate()
JOIN employees AS e ON dm.emp_no = e.emp_no
JOIN departments AS d ON dm.dept_no = d.dept_no 
ORDER BY salary DESC
LIMIT 1;

#Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(first_name, ' ', last_name) AS employee_name, dept_name, dm.emp_no
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no 
					  AND to_date > curdate()
JOIN employees AS e ON de.emp_no = e.emp_no
LEFT JOIN dept_manager AS dm ON de.dept_no = dm.dept_no 
							 AND dm.to_date > curdate();

#Find the highest paid employee in each department
SELECT s.emp_no, salary, dept_name
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
ORDER BY dept_name;

