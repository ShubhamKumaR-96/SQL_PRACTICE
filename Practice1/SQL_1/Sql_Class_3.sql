
create database A_1;
USE A_1;
SHOW databases;
USE subquery;

SHOW tables;
SELECT * FROM customers;

--Q21 --Write an SQL query to report the customer_id and customer_name of
-- customers who have spent at
-- --least $100 in each month of June and July 2020.
-- --Return the result table in any order

-- # First approach 
SELECT * FROM orders;

SELECT o.customer_id, c.name from customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN product p on p.product_id = o.product_id
GROUP BY o.customer_id,c.name
HAVING (
    sum(CASE WHEN month(order_date) = 6 THEN o.quantity * p.price ELSE 0 END) >= 100
    and
    sum(CASE WHEN month(order_date) = 7 THEN o.quantity * p.price ELSE 0 END) >=100
);


