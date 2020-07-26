#Find all the employees with the same hire date as employee 101010 using a sub-query. 
#69 rows
#Hire date is 10/22/1990
SHOW DATABASES;
USE employees;

SELECT first_name, last_name
FROM employees
WHERE hire_date IN (
				   SELECT hire_date 
				   FROM employees
				   WHERE emp_no = '101010'
				   );

#Find all the titles held by all employees with the first name Aamod.
#314 total titles, 6 unique titles
SELECT title
FROM titles
WHERE emp_no IN (
				SELECT emp_no
				FROM employees
				WHERE first_name = 'Aamod'
				);
	
SELECT title
FROM titles
WHERE emp_no IN (
				SELECT emp_no
				FROM employees
				WHERE first_name = 'Aamod'
				)	
GROUP BY title;

#How many people in the employees table are no longer working for the company?
SELECT (COUNT(DISTINCT emp_no)-(SELECT COUNT(DISTINCT emp_no)
							   FROM dept_emp
							   WHERE to_date > now()
							   )
		) as people_no_longer_working_for_company
FROM employees;
	
	/*  #85,108 is how many people LEFT a department
		SELECT DISTINCT emp_no
		FROM dept_emp
		WHERE to_date < now();
		#240,124 is how many employees are CURRENTLY IN a department
		SELECT DISTINCT emp_no
		FROM dept_emp
		WHERE to_date > now();
		#300,0024 is TOTAL number of employees
		SELECT DISTINCT emp_no
		from dept_emp; */

#Find all the current department managers that are female.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
				SELECT emp_no
				FROM dept_manager
				WHERE to_date > now()
				)
	AND gender = 'F';
		     
#Find all the employees that currently have a higher than average salary. avg=63810
#154543 rows in total.
SELECT first_name, last_name, salary
FROM salaries
JOIN employees ON employees.emp_no = salaries.emp_no
WHERE to_date > now() 	
	AND salary>(SELECT AVG(salary)
				FROM salaries);

#How many current salaries are within 1 standard deviation of the highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
#78 salaries
SELECT COUNT(salary) AS salaries_within_one_stddev
FROM salaries
WHERE to_date > now() 
	AND salary>(
		(SELECT MAX(salary) FROM salaries)-(SELECT STDDEV(salary) FROM salaries)
				);

SELECT (SELECT COUNT(salary)
		FROM salaries
		WHERE to_date > now() 
			AND salary>((SELECT MAX(salary) FROM salaries)-(SELECT STDDEV(salary)FROM salaries)
				    	)
		)/COUNT(DISTINCT emp_no)*100 AS percent_of_all_salaries
FROM salaries;


				
#Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
WHERE dept_no IN 
				(SELECT DISTINCT dept_no
				FROM dept_manager
				WHERE emp_no IN (
								SELECT emp_no
								FROM employees
    							WHERE gender = 'F'
    							)
					AND to_date > now()
				);
		
		/*  SELECT emp_no
			FROM employees
			WHERE gender = 'F';

			SELECT DISTINCT dept_no
			FROM dept_manager
			WHERE emp_no IN
						(SELECT emp_no
						FROM employees
						WHERE gender = 'F')
				AND to_date > now(); */
		
#Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
				SELECT emp_no
				FROM salaries
				WHERE salary = (
							   SELECT MAX(salary)
							   FROM salaries
							   )
				);
				
#Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
WHERE dept_no IN (
				 SELECT dept_no
				 FROM dept_emp
				 WHERE emp_no IN (
				 				 SELECT emp_no
				 				 FROM salaries
								 WHERE salary = (
								 				SELECT MAX(salary)
								 				FROM salaries
								 				)
								  )
				  );
				