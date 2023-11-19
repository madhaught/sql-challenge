-- List the employee number, last name, first name, sex, and salary of each employee
select employees.emp_no,
	employees.last_name,
	employees.first_name,
	employees.sex,
	salaries.salary
from employees
join salaries on
employees.emp_no = salaries.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986
-- https://commandprompt.com/education/how-to-extract-year-from-date-in-postgresql/#:~:text=Similarly%2C%20to%20extract%20the%20year,the%20given%20timestamp%20or%20interval.
select first_name, last_name, hire_date
from employees
where extract('Year' from hire_date) = 1986;

-- List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name.
select dept_manager.dept_no, 
	departments.dept_name, 
	dept_manager.emp_no, 
	employees.last_name, 
	employees.first_name
from dept_manager
join employees on
dept_manager.emp_no = employees.emp_no
join departments on
dept_manager.dept_no = departments.dept_no
order by dept_no;

-- List the department number for each employee along with that employee’s 
-- employee number, last name, first name, and department name.
select dept_emp.dept_no,
	dept_emp.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
from dept_emp
join employees on
dept_emp.emp_no = employees.emp_no
join departments on
dept_emp.dept_no = departments.dept_no
order by emp_no;

-- List first name, last name, and sex of each employee whose 
-- first name is Hercules and whose last name begins with the letter B.
-- https://www.postgresqltutorial.com/postgresql-string-functions/postgresql-left/#:~:text=Return%20value-,The%20PostgreSQL%20LEFT()%20function%20returns,n%20characters%20in%20a%20string.
select first_name, last_name, sex
from employees
where first_name = 'Hercules' and left(last_name, 1) = 'B';

-- List each employee in the Sales department, including their employee number, last name, and first name.
select emp_no, last_name, first_name
from employees
where emp_no in
(
	select emp_no
	from dept_emp
	where dept_no in
	(
		select dept_no
		from departments
		where dept_name = 'Sales'
	)
);

-- List each employee in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
select dept_emp.emp_no,
	employees.last_name,
	employees.first_name,
	departments.dept_name
from dept_emp
join employees on
dept_emp.emp_no = employees.emp_no
join departments on
dept_emp.dept_no = departments.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
select last_name, count(last_name) as "name count"
from employees
group by last_name
order by "name count" desc;
