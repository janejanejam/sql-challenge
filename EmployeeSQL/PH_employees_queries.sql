--Select tables to view
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
JOIN salaries AS s ON
e.emp_no = s.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE CAST(hire_date AS DATE) BETWEEN '1/1/86' and '12/31/86';

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments AS d
JOIN dept_manager AS dm ON
d.dept_no = dm.dept_no
JOIN employees AS e ON
dm.emp_no = e.emp_no;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON
e.emp_no = de.emp_no
JOIN departments AS d ON
de.dept_no = d.dept_no;

--List first name, last name, and sex for employees whose first name is 
--"Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND
	last_name LIKE 'B%'
ORDER BY last_name;

--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON
e.emp_no = de.emp_no
JOIN departments AS d ON
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales'
ORDER BY e.last_name;

--List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON
e.emp_no = de.emp_no
JOIN departments AS d ON
de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY d.dept_name, e.last_name;

--In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY last_name DESC;