use assign1;

SELECT * FROM views;


--Q11 Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.

SELECT DISTINCT author_id as id from views
WHERE author_id = viewer_id
ORDER BY author_id ASC;

-- Q12 Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places

SELECT round(avg(order_date = customer_pref_delivery_date)*100,2)as immediate_order_per FROM delivery ;

--Q13 Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a
-- tie.
SELECT * FROM ads;

select ad_id, i
fNull(round(AVG(CASE WHEN action = "clicked" then 1 WHEN action = "Viewed" then 0 
else null end
)*100,2),0) as ctr FROM ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;


-- Q14 Write an SQL query to find the team size of each of the employees.
-- Return result table in any order

SELECT * FROM employee;

SELECT team_id , count(*) as team_size FROM employee
GROUP BY team_id;

-- # Ist way Sub query

select e.employee_id ,t.team_size from employee e 
join (select team_id , count(*) as team_size from employee GROUP by team_id) t on t.team_id = e.team_id
order by e.employee_id;

-- # Window function

select employee_id, count(*) over(partition by team_id) as team_size from employee
order by employee_id ASC;

-- Q15 Write an SQL query to find the type of weather in each country for November 2019.
-- The type of weather is:
-- ● Cold if the average weather_state is less than or equal 15,
-- ● Hot if the average weather_state is greater than or equal to 25, and
-- ● Warm otherwise.
-- Return result table in any order

SELECT * FROM weather;
SELECT * FROM countries;

SELECT c.country_name , case WHEN AVG(weather_state) <= 15 then "cold"
    WHEN AVG(weather_state) >= 25 then "hot" else "warm" end as weather_type from countries c INNER JOIN weather w ON c.country_id = w.country_id
    WHERE w.day between '2019-11-01' and '2019-11-30'
    GROUP by c.country_name;


--Q16 Write an SQL query to find the average selling price for each product. average_price should be
-- rounded to 2 decimal places.
-- Return the result table in any order.

SELECT * FROM prices;
SELECT * FROM UnitsSold;

SELECT p.product_id, round(sum(un.units*p.price) / sum(un.units),2) as avg_selling_price
FROM unitssold un INNER JOIN prices p ON p.product_id = un.product_id
WHERE un.purchase_date BETWEEN p.start_date and p.end_date
GROUP BY p.product_id;


--Q17 Write an SQL query to report the first login date for each player.
-- Return the result table in any order

SELECT * FROM activity;

SELECT tmp.player_id, tmp.event_date as first_login 
FROM (SELECT *, row_number() over(partition by player_id) as row_num from activity ) as tmp WHERE tmp.row_num = '1';


-- Q18 Write an SQL query to report the device that is first logged in for each player.
-- Return the result table in any order

SELECT tmp.player_id, tmp.device_id FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY player_id) as row_num FROM activity) as tmp WHERE tmp.row_num = 1;

--Q19 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020
-- and their amount.
-- Return result table in any order.

SELECT * FROM products;

SELECT * FROM orders;

SELECT product_name , sum(unit) as unit FROM  products p 
LEFT JOIN orders o on p.product_id = o.product_id
WHERE o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY product_name
HAVING sum(unit) >= 100;

--Q20 Write an SQL query to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
-- '_', period '.', and/or dash '-'. The prefix name must start with a letter.
-- ● The domain is '@leetcode.com'.
-- Return the result table in any order.

SELECT * FROM users;

SELECT * 
FROM users
WHERE REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com');

