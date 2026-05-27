SHOW tables;
SELECT *
from device_logs;
SELECT *
from users;
SELECT *
from employees;
SELECT *
from user_logins;
-- Question 1: Consecutive User Activity / Login Streaks (Advanced Pattern)
-- 1. Problem Statement
-- The Product Analytics team wants to find "Loyal Users". A loyal user is defined as someone who logged into the platform for at least 2 consecutive days. Write an optimized SQL query using CTEs to find the user_id of all such users.
with rankedLogins as (
    SELECT user_id,
        login_date,
        LAG(login_date, 1) OVER(
            PARTITION BY user_id
            ORDER BY login_date ASC
        ) as previous_login
    from user_logins
)
SELECT DISTINCT user_id
from rankedLogins
WHERE datediff(login_date, previous_login) = 2;
-- Q2 You have a table of employee records. Write a query to find all employees from the "Sales" department who earn more than 50,000 per month, ordered by their salary in descending order.
SELECT *
from employees
where department = 'Sales'
    AND salary > 50000
ORDER BY salary DESC;
-- Q3 Find the total salary expense and average salary for each department. Also show the count of employees in each department. Order by total salary expense in descending order.
SELECT department,
    sum(salary) as total_expense,
    avg(salary) as avg_salary_of_depart,
    count(*) as total_emp
from employees
GROUP BY department
ORDER BY total_expense DESC;
-- Q4  Question
-- Find all departments where the total salary expense is greater than 150,000, but exclude any employees who earn less than 45,000. Show the department, total salary, average salary, and employee count. Order by average salary in descending order.
SELECT department,
    sum(salary) as total_expense,
    avg(salary) as avg_salary,
    count(*) as total_emp
from employees
where salary >= 45000
GROUP BY department
having sum(salary) > 150000
ORDER BY avg_salary DESC;
-- Q5- You have two tables: employees and departments. Find the name of each employee, their salary, and the department name they work in. Only show employees who have a valid department assigned.
SELECT e.emp_name,
    d.dept_name,
    e.salary
from employees1 e
    INNER JOIN departments d on e.dept_id = d.dept_id;
-- Q6 📋 Question
-- Find all departments and show how many employees work in each department. If a department has no employees, still show the department name with employee count as 0. Also show the department's budget.
SELECT d.dept_name,
    count(e.emp_id) as total_emp,
    d.budget
from departments d
    LEFT JOIN employees1 e on d.dept_id = e.dept_id
GROUP BY d.dept_id,
    d.dept_name
ORDER by total_emp DESC;
-- Q7  Find all employees and all departments. Show which employees are assigned to which departments. If an employee has no department or a department has no employees, still show them with NULL values.
(
    SELECT e.emp_name,
        e.salary,
        d.dept_name
    FROM employees1 e
        LEFT JOIN departments d on e.dept_id = d.dept_id
)
union
(
    SELECT e.emp_name,
        e.salary,
        d.dept_name
    from departments d
        LEFT join employees1 e on d.dept_id = e.dept_id
) -- Variation 1: सिर्फ unmatched records दिखाओ
(
    SELECT e.emp_name,
        e.salary,
        d.dept_name
    from employees1 e
        LEFT join departments d on e.dept_id = d.dept_id
    where d.dept_id is NULL
)
union
(
    SELECT e.emp_name,
        e.salary,
        d.dept_name
    from employees1 e
        LEFT join departments d on e.dept_id = d.dept_id
    where e.emp_id is NULL
) -- Find all employees who are NOT assigned to any department. Show their name, salary, and department (which will be NULL).
(
    SELECT e.emp_name,
        e.salary,
        d.dept_name
    FROM employees1 e
        LEFT JOIN departments d on e.dept_id = d.dept_id
    where d.dept_name is NULL
)
SELECT *
from employees1
SELECT *
from departments;
-- Find the name and salary of employees who earn more than the average salary of their department.
SELECT DISTINCT e.emp_name,
    e.salary,
    d.dept_name,
    dept_avg.avg_salary
from employees1 e
    INNER JOIN departments d on e.dept_id = d.dept_id
    INNER JOIN (
        SELECT dept_id,
            avg(salary) as avg_salary
        from employees1
        GROUP BY dept_id
    ) as dept_avg on e.dept_id = dept_avg.dept_id
where e.salary > dept_avg.avg_salary
order by d.dept_name,
    e.salary DESC;
-- # Using window function
SELECT DISTINCT e.emp_name,
    e.salary,
    d.dept_name,
    round(avg(e.salary) OVER(PARTITION BY d.dept_id), 2) as avg_salary_by_depart
from employees1 e
    INNER JOIN departments d ON e.dept_id = d.dept_id
WHERE e.salary > (
        SELECT avg(salary) as avg_salary
        from employees1 e2
        where e2.dept_id = e.dept_id
    )
ORDER BY d.dept_name,
    e.salary DESC;
-- # Using CTE
with dept_avg_salary as (
    SELECT dept_id,
        avg(salary) as avg_salary
    from employees1
    GROUP BY dept_id
)
SELECT e.emp_name,
    e.salary,
    d.dept_name,
    da.avg_salary
from employees1 e
    INNER join departments d on e.dept_id = d.dept_id
    INNER join dept_avg_salary da on e.dept_id = da.dept_id
where e.salary > da.avg_salary
ORDER BY d.dept_name,
    e.salary DESC;
-- 🔧 Advanced Variations:
-- Variation 1: Top earner हर department में
SELECT DISTINCT e.emp_name,
    e.salary,
    d.dept_name
from employees1 e
    INNER join departments d on e.dept_id = d.dept_id
where e.salary = (
        SELECT max(salary) as max_salary
        from employees1 e2
        where e2.dept_id = e.dept_id
    )
ORDER BY d.dept_name;
Variation 2: Salary rank हर department में
SELECT e.emp_name,
    e.salary,
    d.dept_name,
    ROW_NUMBER() OVER(
        PARTITION by d.dept_id
        order by e.salary DESC
    ) as rank_no
from employees1 e
    INNER join departments d on e.dept_id = d.dept_id
ORDER BY d.dept_name,
    rank_no;
-- Variation 3: Departments का average_salary > overall average
-- Find those departments whose average salary is greater than the overall average salary of all employees in the company."
SELECT d.dept_name,
    avg(e.salary) as avg_salary
from employees1 e
    INNER JOIN departments d on e.dept_id = d.dept_id
GROUP BY d.dept_id,
    d.dept_name
having avg(e.salary) > (
        SELECT avg(salary)
        from employees1
    )
ORDER BY avg_salary DESC;