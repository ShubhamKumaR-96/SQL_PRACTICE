SHOW databases;
use windowfn;
SHOW tables;

SELECT * FROM employees;
-- Write a query to assign a unique row number to each employee ordered by salary descending.


SELECT *,  
ROW_NUMBER() OVER(ORDER BY salary DESC) as row_num
from employees;

-- Write a query to rank employees by salary. If two employees have the same salary, they should get the same rank.


SELECT *, RANK() OVER(ORDER BY salary DESC) as rank_num
FROM employees;



