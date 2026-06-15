
--Q1 Find all employees with their department names. Include employees without departments. (Expected: 25 rows)

SELECT * FROM departments;

SELECT emp.emp_id,emp.emp_name,emp.email,dep.dept_name from employees emp 
LEFT JOIN departments dep ON emp.dept_id = dep.dept_id
GROUP BY emp.emp_id;

--Q2 Find departments that have no employees.

SELECT dep.dept_id,dep.dept_name  from departments dep
LEFT JOIN employees emp on dep.dept_id = emp.dept_id
where emp.emp_id is NULL;


SELECT * FROM departments d 
WHERE not EXISTS (
    SELECT 1 from employees e
    where e.dept_id = d.dept_id
)

--Q3 Total Salary expenditure per department

SELECT d.dept_id, d.dept_name,
       count(e.emp_id) as employee_count,
       sum(e.salary) as total_salary,
       round(avg(e.salary),2) as avg_salary
from departments d LEFT JOIN employees e ON d.dept_id=e.dept_id 
GROUP BY d.dept_id, d.dept_name
ORDER BY total_salary DESC;

--Q4 Departments where avg salary > 80000

SELECT d.dept_id, d.dept_name,
    round(avg(salary),2) as avg_salary,
    count(e.emp_id) as employee_count
    from departments d
inner JOIN employees e on d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
having avg(salary) > 80000;       

--Q5 Highest paid employee in each department

SELECT d.dept_id, d.dept_name, max(e.salary) as highest_paid from departments d
inner join employees e on d.dept_id = e.dept_id 
GROUP BY d.dept_id, d.dept_name
ORDER by max(salary) DESC ;

-- # Using window function

SELECT * from (
    SELECT e.emp_id,e.emp_name,e.salary , d.dept_name,
    ROW_NUMBER() OVER(PARTITION BY d.dept_id ORDER BY e.salary DESC) as rn 
    from employees e inner join departments d on e.dept_id = d.dept_id ) t  
where rn = 1;