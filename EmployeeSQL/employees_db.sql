CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR
);

CREATE TABLE dept_emp (
	emp_no int,
	dept_no VARCHAR,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no int PRIMARY KEY,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE titles (
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR
);

CREATE TABLE employees (
	emp_no int PRIMARY KEY,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

CREATE TABLE salaries (
	emp_no int PRIMARY KEY,
	salary money,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- 1. List the employee number, last name, first name, sex, and salary of each employee
SELECT emp_no AS "Employee Number", last_name AS "Last Name", first_name AS "First Name", sex AS "Sex",
(SELECT salary AS "Salary"
	FROM salaries
	WHERE employees.emp_no = salaries.emp_no)
FROM employees;


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
-- REFERENCED STACKOVERFLOW #42269987 for casting as string
SELECT first_name AS "First Name", last_name AS "Last Name", hire_date AS "Hire Date" 
FROM employees
WHERE CAST(hire_date AS VARCHAR) LIKE '1986%';


-- 3. List the manager of each department along with their department number, department name, 
--    employee number, last name, and first name.
SELECT dept_no AS "Department Number",
(SELECT departments.dept_name AS "Department Name"
	FROM departments
	WHERE dept_manager.dept_no = departments.dept_no),
		emp_no AS "Employee Number", 
		(SELECT employees.first_name AS "First Name"
			FROM employees
			WHERE dept_manager.emp_no = employees.emp_no),
			(SELECT employees.last_name AS "Last Name"
				FROM employees
				WHERE dept_manager.emp_no = employees.emp_no)
FROM dept_manager;


-- 4. List the department number for each employee along with that employee's employee number, 
--    last name, first name, and department name
SELECT dept_no AS "Department Number", emp_no As "Employee Number",
(SELECT last_name AS "Last Name"
	FROM employees
	WHERE dept_emp.emp_no = employees.emp_no),
	(SELECT first_name AS "First Name"
		FROM employees
		WHERE dept_emp.emp_no = employees.emp_no),
		(SELECT dept_name AS "Department Name"
			FROM departments
			WHERE dept_emp.dept_no = departments.dept_no)
FROM dept_emp;

-- 5. List first name, last name and sex of each employee whose first name is Hercules and whose
--    last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- 6. List each employee in the Sales department, inclduing their employee number, last name, and first name.
SELECT emp_no AS "Employee Number", last_name AS "Last Name", first_name AS "First Name"
FROM employees
WHERE emp_no IN(
	SELECT emp_no 
	FROM dept_emp
	WHERE dept_no IN(
		SELECT dept_no 
		FROM departments
		WHERE dept_name = 'Sales'
	)
);

SELECT * FROM dept_emp
-- 7. List each employee in the Sales and Development Departments, including their employee number,
--    last name, first name, and department name.
SELECT emp_no AS "Employee Number"
FROM dept_emp
WHERE dept_no IN(
	SELECT dept_no 
	FROM departments
	WHERE dept_name = 'Sales' OR dept_name = 'Development')