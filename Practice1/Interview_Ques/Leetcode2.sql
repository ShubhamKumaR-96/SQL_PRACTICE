
show tables;

-- 177. Nth Highest Salary
-- Medium
-- Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

-- The query result format is in the following example.


SELECT * from employee;
SELECT * from department;


-- 185. Department Top Three Salaries
-- A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

-- Write a solution to find the employees who are high earners in each of the departments.
-- Return the result table in any order.
-- The result format is in the following example.


SELECT d.name,e.name,e.salary from employee e
join department d on e.department_id = d.id 
where (
    SELECT count(distinct e2.salary) from employee e2
    where e2.department_id =  e.department_id
    and e2.salary > e.salary
) < 3;




SELECT * FROM 