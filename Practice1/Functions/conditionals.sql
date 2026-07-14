show databases;

use con_fun;

SELECT * FROM employees;

SELECT salary,
    if(salary > 50000,"High","Medium") as salary_category FROM employees;

SELECT experience, if(experience > 5, 'Experienced','Fresher') as EMP_EXP FROM employees;    

SELECT salary, if(salary is not NULL,'Avialable','missing') as sa FROM employees;


SELECT emp_name,salary,if(salary >= 90000,'Excellent',if(salary >= 70000,'Good',"Average")) as SA FROM employees;


SELECT emp_name,salary,
    CASE 
    WHEN salary >= 90000 THEN 'Excellent'
    WHEN salary >= 70000 THEN 'Good'
    ELSE 'Average'
    END as 'Salary_Category'
FROM employees;
    

performance_score >= 90  → Excellent
performance_score >= 80  → Good
performance_score >= 70  → Average
Otherwise                → Poor


SELECT emp_name,performance_score,
    if(performance_score >= 90,'Excellent', if(performance_score >= 80,'Good',if(performance_score >= 70,'Average','Poor'))) as performace_category FROM employees;

SELECT emp_name,performance_score,
    CASE 
    WHEN performance_score >= 90 THEN 'Excellent'
    WHEN performance_score >= 80 THEN 'Good'
    WHEN performance_score >= 70 THEN 'Average'
    ELSE 'Poor'
    END as 'Performance_Category'
FROM employees;    