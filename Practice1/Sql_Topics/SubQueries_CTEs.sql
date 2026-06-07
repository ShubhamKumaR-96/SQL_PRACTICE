show tables;
SELECT * from superstore_orders LIMIT 10;

-- # Find those customer who have orders_value greater than avg sales values (Use Sub Query)

SELECT order_id ,count(Order_ID) as total_cnt_orders from superstore_orders
GROUP BY Order_id having sum(Sales) >
 (SELECT avg(sales_agg.orders_sales) as avg_order_val from
(SELECT order_id , sum(sales) as orders_sales from superstore_orders
GROUP BY order_id) as sales_agg) LIMIT 10;

SELECT * FROM Department;
SELECT * FROM Employee;


--  Find employee whose  salary > Avg salary

SELECT name,salary from employee where salary > (SELECT Avg(salary) from employee)

-- Find employees salary and company average both

SELECT name,salary,(SELECT avg(salary) from employee) as company_avg,
salary - (SELECT avg(salary) from employee) as diff_from_avg from employee;



show databases;
