-- CREATE departments TABLE
CREATE TABLE departments (
	dept_no VARCHAR(255) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(255) NOT NULL
);

-- CREATE dept_emp TABLE, NEED COMPOSITE KEY SINCE NEITHER COLUMN IS UNIQUE
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(255) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

-- CREATE dept_manager TABLE
CREATE TABLE dept_manager (
	dept_no VARCHAR(255) NOT NULL,
	emp_no INT PRIMARY KEY NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

-- CREATE titles TABLE
CREATE TABLE titles (
	title_id VARCHAR(255) PRIMARY KEY NOT NULL,
	title VARCHAR(255) NOT NULL
);

-- CREATE employees TABLE
CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(255) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	sex VARCHAR(255) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

-- CREATE salaries TABLE
CREATE TABLE salaries (
	emp_no INT PRIMARY KEY NOT NULL,
	salary money NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);