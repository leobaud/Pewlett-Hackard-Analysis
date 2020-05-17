-- Creating tables for departments
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

-- Creating employees table
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

-- Creating Managers table
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- Creating department employees table
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

-- Creating salaries table
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

-- Creating titles table
CREATE TABLE titles (
  	emp_no INT NOT NULL,
  	titles VARCHAR NOT NULL,
  	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM departments;

SELECT * FROM dept_manager;

SELECT * FROM employees;

SELECT * FROM dept_emp;

SELECT * FROM salaries;

SELECT * FROM titles;

--FIRST DELIVERABLE

-- Retirement eligibility
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
 
-- Check the table
SELECT * FROM retirement_info;
 
 --Current employees
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
-- Check the table
SELECT * FROM current_emp;

--Getting employees titles and salaries
SELECT tl.emp_no, 
	tl.titles,
	tl.from_date,
	tl.to_date,
	s.salary
INTO titles_salaries
FROM titles as tl
LEFT JOIN salaries as s
ON tl.emp_no = s.emp_no;
-- Check the table
SELECT * FROM titles_salaries;

-- Getting eligible retirement employees with titles and salaries
SELECT ce.emp_no,
		ce.first_name,
		ce.last_name,
		ts.titles,
		ts.from_date,
		ts.to_date,
		ts.salary
INTO retire_emp_titles
FROM current_emp AS ce
INNER JOIN titles_salaries AS ts
ON ce.emp_no = ts.emp_no;

-- Check the table
SELECT * FROM retire_emp_titles;


-- Partition the data to show only most recent title per employee
SELECT emp_no,
 first_name,
 last_name,
 titles, 
 salary
 
INTO retire_emp_current_title
FROM
(SELECT emp_no,
 first_name,
 last_name,
 titles,
 salary, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
FROM retire_emp_titles as rt
 ) tmp WHERE rn = 1
ORDER BY emp_no;
-- Check the table
SELECT * FROM retire_emp_current_title;

-- Employee count by title
SELECT COUNT(ct.titles), ct.titles
INTO count_per_title
FROM retire_emp_current_title as ct
GROUP BY ct.titles
ORDER BY count desc;
-- Check the table
SELECT * FROM count_per_title;

--SECOND DELIVERABLE

-- Eligible employees for mentorship

SELECT emp_no, first_name, last_name
INTO eligible_info
FROM employees
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT * FROM eligible_info;

-- Current employees
SELECT ei.emp_no,
	ei.first_name,
	ei.last_name,
tl.to_date
INTO current_emp_mentor
FROM eligible_info as ei
INNER JOIN titles as tl
ON ei.emp_no = tl.emp_no
WHERE tl.to_date = ('9999-01-01');
-- Check the table
SELECT * FROM current_emp_mentor;

-- Mentorship eligibility
SELECT cem.emp_no,
		cem.first_name,
		cem.last_name,
		tl.titles,
		tl.from_date,
		tl.to_date
INTO mentorship_eligible_emp
FROM current_emp_mentor AS cem
INNER JOIN titles AS tl
ON cem.emp_no = tl.emp_no;

-- Check the table
SELECT * FROM mentorship_eligible_emp;

-- Partition the data to show only most recent title per employee
SELECT emp_no,
 first_name,
 last_name,
 titles
 
INTO current_emp_title_for_mentorship
FROM
(SELECT emp_no,
 first_name,
 last_name,
 titles, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
FROM mentorship_eligible_emp as me
 ) tmp WHERE rn = 1
ORDER BY emp_no;
-- Check the table
SELECT * FROM current_emp_title_for_mentorship