-- CREATE DATABASE Joins;
-- use Joins;
SHOW tables;


-- Q1 List all employees with their department name


SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM orders;

SELECT e.name,e.dept_id from employees e 
INNER JOIN departments d ON d.dept_id = e.dept_id;

-- Q Show ALL employees including those with no department

SELECT e.name,e.dept_id from employees e
LEFT JOIN departments d on e.dept_id = d.dept_id;

-- Show all departments including those with no employees

SELECT d.dept_name, e.name FROM departments d 
LEFT JOIN employees e ON d.dept_id = e.dept_id;

# Find employees who have NOT placed any orders

SELECT e.name from employees e 
LEFT Join orders o on  e.emp_id = o.emp_id
where o.order_id is null;


-- # Find orders placed by non-existent employees (orphan records)
SELECT o.order_id, e.name FROM orders o 
LEFT JOIN employees e on e.emp_id = o.emp_id
WHERE e.emp_id is NULL;


-- # Get a cartesian product — every employee paired with every department

SELECT e.emp_id, e.name,e.dept_id, dept_name from employees e
cross JOIN
departments;


-- Show all employees with their order amounts. Include employees with no  orders.

SELECT e.emp_id, e.name,COALESCE(sum(o.amount),0) as ordered_val from employees e 
LEFT JOIN orders o ON o.emp_id = e.emp_id
GROUP BY e.emp_id,e.name;
