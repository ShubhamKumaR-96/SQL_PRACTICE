--   Leetcode : 0175. Combine Two Tables

-- Write an SQL query to report the first name, last name, city, and state of each person in the Person table. If the address of a personId is not present in the Address table, report null instead.

-- Return the result table in any order.

select p.firstname,p.lastname,a.city,a.state
from Person p left join Address a on p.personId=a.personId;


CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    manager_id INT NULL
);
 
INSERT INTO Employee VALUES
(1, 'Joe', 70000, 1, NULL),
(2, 'Henry', 80000, 2, 1),
(3, 'Sam', 60000, 2, 1),
(4, 'Max', 90000, 1, NULL),
(5, 'Janet', 69000, 1, 4),
(6, 'Randy', 85000, 1, 4),
(7, 'Will', 70000, 1, NULL);
 
-- ------------------------------------------------------------
-- 2. DEPARTMENT (Basic Join pattern)
-- Covers: Department Highest Salary, Join + GroupBy
-- ------------------------------------------------------------
CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);
 
INSERT INTO Department VALUES
(1, 'IT'),
(2, 'Sales'),
(3, 'HR');
 
-- ------------------------------------------------------------
-- 3. SALARY_LOG (Window Functions pattern)
-- Covers: Rank, Dense_Rank, Nth Highest Salary, Running Total,
-- LAG/LEAD, Consecutive values
-- ------------------------------------------------------------
CREATE TABLE Salary_Log (
    emp_id INT,
    month DATE,
    salary INT
);
 
INSERT INTO Salary_Log VALUES
(1, '2024-01-01', 50000),
(1, '2024-02-01', 52000),
(1, '2024-03-01', 51000),
(2, '2024-01-01', 60000),
(2, '2024-02-01', 62000),
(2, '2024-03-01', 64000),
(3, '2024-01-01', 45000),
(3, '2024-02-01', 45000),
(3, '2024-03-01', 47000);
 
-- ------------------------------------------------------------
-- 4. CUSTOMERS & ORDERS (Multi-table Join pattern)
-- Covers: Customers Who Never Order, Sales Analysis,
-- Aggregation with Join, Rising Temperature style date compare
-- ------------------------------------------------------------
CREATE TABLE Customers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);
 
INSERT INTO Customers VALUES
(1, 'Aman', 'Delhi'),
(2, 'Riya', 'Mumbai'),
(3, 'Kabir', 'Ludhiana'),
(4, 'Simran', 'Chandigarh');
 
CREATE TABLE Orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount INT,
    product_id INT
);
 
INSERT INTO Orders VALUES
(1, 1, '2024-01-05', 500, 1),
(2, 1, '2024-01-10', 700, 2),
(3, 2, '2024-01-15', 300, 1),
(4, 3, '2024-02-01', 1200, 3),
(5, 2, '2024-02-05', 450, 2),
(6, 1, '2024-02-10', 900, 3);
 
-- ------------------------------------------------------------
-- 5. PRODUCTS (Aggregation + Join pattern)
-- Covers: Product Sales Analysis, Group By + Having
-- ------------------------------------------------------------
CREATE TABLE Products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    price INT,
    category VARCHAR(30)
);
 
INSERT INTO Products VALUES
(1, 'Keyboard', 500, 'Electronics'),
(2, 'Mouse', 300, 'Electronics'),
(3, 'Chair', 1200, 'Furniture');
 
-- ------------------------------------------------------------
-- 6. SCORES (Ranking without window functions - older LeetCode style)
-- Covers: Rank Scores, Dense Rank via correlated subquery
-- ------------------------------------------------------------
CREATE TABLE Scores (
    id INT PRIMARY KEY,
    score DECIMAL(3,1)
);
 
INSERT INTO Scores VALUES
(1, 3.5),
(2, 3.65),
(3, 4.0),
(4, 3.85),
(5, 4.0),
(6, 3.65);
 
-- ------------------------------------------------------------
-- 7. LOGINS (Date functions + Consecutive days pattern)
-- Covers: Consecutive Numbers, User Activity, Login Streaks,
-- DATEDIFF, LAG/LEAD on dates
-- ------------------------------------------------------------
CREATE TABLE Logins (
    user_id INT,
    login_date DATE
);
 
INSERT INTO Logins VALUES
(1, '2024-03-01'),
(1, '2024-03-02'),
(1, '2024-03-03'),
(1, '2024-03-05'),
(2, '2024-03-01'),
(2, '2024-03-02'),
(3, '2024-03-01');
 
-- ------------------------------------------------------------
-- 8. STUDENTS_SUBJECTS (Pivot / Cross Join pattern)
-- Covers: Students report by subject, Pivoting rows to columns,
-- Cross Join with distinct list
-- ------------------------------------------------------------
CREATE TABLE Students (
    student_id INT,
    student_name VARCHAR(50)
);
 
INSERT INTO Students VALUES
(1, 'Aman'),
(2, 'Riya');
 
CREATE TABLE Subjects (
    subject_name VARCHAR(50)
);
 
INSERT INTO Subjects VALUES
('Math'), ('Science');
 
CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(50)
);
 
INSERT INTO Examinations VALUES
(1, 'Math'),
(1, 'Math'),
(2, 'Science');
 
-- ------------------------------------------------------------
-- 9. TWEETS / ACTIVITY (String functions + Date trunc pattern)
-- Covers: Invalid Tweets (LENGTH), Active Users Monthly,
-- String functions (SUBSTRING, LENGTH, LIKE)
-- ------------------------------------------------------------
CREATE TABLE Tweets (
    tweet_id INT PRIMARY KEY,
    user_id INT,
    content VARCHAR(200),
    tweet_date DATE
);
 
INSERT INTO Tweets VALUES
(1, 1, 'Learning SQL today', '2024-01-05'),
(2, 1, 'This is a very very very long tweet that exceeds fifteen characters easily', '2024-01-06'),
(3, 2, 'Hi', '2024-01-07');
 
-- ------------------------------------------------------------
-- 10. TRANSACTIONS (Self-referencing + Running balance pattern)
-- Covers: Cumulative Sum, Running Balance, Fraud-detection style
-- correlated subqueries
-- ------------------------------------------------------------
CREATE TABLE Transactions (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_date DATE,
    amount INT   -- positive = credit, negative = debit
);
 
INSERT INTO Transactions VALUES
(1, 101, '2024-01-01', 1000),
(2, 101, '2024-01-05', -200),
(3, 101, '2024-01-10', 500),
(4, 102, '2024-01-02', 2000),
(5, 102, '2024-01-15', -1500);


-- 176. Second Highest Salary
-- Medium

-- Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null

show Tables;
SELECT * FROM employee;

SELECT DISTINCT salary from employee
ORDER BY salary DESC LIMIT 1 offset 1;

SELECT salary as secondHighestSalary
from (
    select salary , Dense_Rank() over(order by salary DESC) as rnk from employee
) t 
where rnk =2
LIMIT 1;



