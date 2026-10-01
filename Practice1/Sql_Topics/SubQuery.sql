
use subquery;

SHOW tables;

-- # Find all the customers who have not placed even a single order 


SELECT * FROM customers 
WHERE cust_id NOT IN (SELECT cust_id FROM orders);

SELECT c.* FROM customers c LEFT JOIN orders o on c.cust_id = o.cust_id
WHERE o.cust_id IS NULL;

SELECT * FROM employees;
SELECT * FROM departments;

-- Find Employee earning above company average salary;

SELECT emp_id,name,salary FROM employees  WHERE salary > 
(SELECT round(avg(salary),2) as avg_salary from employees  )


-- # Add avg_salary column so that we can see salary and avg_salary

SELECT emp_id, name, salary, comp_avg_salary.avg_salary from employees e1
cross JOIN (
    SELECT round(avg(salary),2) as avg_salary from employees
) comp_avg_salary
WHERE e1.salary > comp_avg_salary.avg_salary;


-- Q2 Find the highest paid employee

SELECT emp_id, name,salary from employees
WHERE salary = (
    SELECT max(salary) from employees
)

-- Q3 Find employees earning exactly the average

SELECT emp_id, name from employees
WHERE salary = (
    SELECT round(avg(salary),2) from employees
)

-- Q4 Show each employee's salary along with companay average

SELECT emp_id,name,salary, (SELECT round(avg(salary),2) from employees) as comp_avg_salary from employees;

--#Q4 Find employee earning more than the minimum salary

-- Showing only salary > min(salary)
SELECT emp_id, name,salary
from employees WHERE salary > (
    SELECT min(salary) from employees
 )

-- Showing salary with min_salary after comparison
 SELECT emp_id, name,salary,min_salary_.min_salary
from employees e1 cross JOIN (
    SELECT min(salary) as min_salary from employees
 ) min_salary_
 WHERE e1.salary > min_salary_.min_salary;

 -- Q5 Find the total_salary paid by company

 SELECT sum(salary) as total_salary_paid from employees;

 --Q6 Find employee hired most recently

 SELECT emp_id,name,city,hire_date from employees 
 ORDER BY hire_date desc
 limit 1 ;

-- # Optimized way to large dataset

SELECT emp_id, name, hire_date FROM employees
WHERE hire_date =  (SELECT max(hire_date) from employees)

--Q6 Find the oldest employee

SELECT emp_id, name, age FROM employees
WHERE age =  (SELECT max(age) from employees)


-- Q7 Find difference b/w min and max salary

SELECT (max(salary) - min(salary)) as diff_salary from employees;


-- Q8 Find employee with salary above 80000
SELECT emp_id, name, salary from employees
WHERE salary > 80000;


--- Level 2 subquery with in OPERATOR --
-- ========================================

-- Q1 Find employee who working in new_york 
SELECT emp_id,name,city from employees
WHERE city = 'New York';

--Q2 Find department that have employees

SELECT dept_id,dept_name FROM departments 
WHERE dept_id in (
    SELECT dept_id from employees
 )

--Q3 Find product that have been ordered

SELECT * FROM Products;
SELECT * FROM Orders;

SELECT prod_name from Products
WHERE prod_id in ( 
    SELECT distinct prod_id from Orders
)

--Q4 Find customer who orders electronics products

SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Products;

SELECT cust_name from customers
WHERE cust_id in (
    SELECT cust_id from Orders
    WHERE prod_id in (
        SELECT prod_id from products 
        WHERE category = "Electronics"
     )
 )

-- # Using JOIN

SELECT distinct c.cust_name FROM customers c INNER JOIN orders o 
on c.cust_id = o.cust_id INNER JOIN products p on
p.prod_id = o.prod_id
WHERE p.category = "Electronics";



-- Q5 Find student enrolled in any course

SELECT * from students;
SELECT * from courses;
SELECT * from Enrollments;

SELECT student_id, student_name, enrollment_year from students
WHERE student_id in (
    SELECT student_id from Enrollments
    WHERE course_id in (
        SELECT course_id FROM Courses
     )
 )

SELECT distinct s.student_name from students s 
INNER JOIN Enrollments e on s.student_id = e.student_id
INNER JOIN courses c on c.course_id = e.course_id;



-- Q6 Find course that have students

SELECT course_name from Courses
WHERE course_id in (
    SELECT course_id from Enrollments
 )






















-- ============================================================
-- VERIFICATION QUERIES
-- ============================================================
SELECT 'Tables Created Successfully!' AS Status;
SELECT 'Departments' AS TableName, COUNT(*) AS RowCount FROM Departments
UNION ALL SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL SELECT 'Products', COUNT(*) FROM Products
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL SELECT 'Students', COUNT(*) FROM Students
UNION ALL SELECT 'Courses', COUNT(*) FROM Courses
UNION ALL SELECT 'Enrollments', COUNT(*) FROM Enrollments
UNION ALL SELECT 'Sales', COUNT(*) FROM Sales
UNION ALL SELECT 'Projects', COUNT(*) FROM Projects
UNION ALL SELECT 'Project_Assignments', COUNT(*) FROM Project_Assignments
UNION ALL SELECT 'Salary_History', COUNT(*) FROM Salary_History;
