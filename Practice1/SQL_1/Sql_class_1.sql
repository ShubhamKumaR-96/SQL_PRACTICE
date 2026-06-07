
SHOW databases;
use assign1;
show tables;

SELECT * FROM station;

--Q1. Query a list of CITY names from STATION for cities that have an
-- even ID number. Print the results in any order, but exclude duplicates
-- from the answer.

SELECT DISTINCT(city) as city_name FROM station where id % 2 = 0
ORDER BY city_name ASC;

-- Q2. Find the difference between the total number of CITY entries in the table and the number of
-- distinct CITY entries in the table.

SELECT count(*) as total_cities, count(DISTINCT city) as unique_city,
count(*) - count(DISTINCT city) as total_diff_city from station;

SELECT 
    COUNT(city) AS total_city,
    COUNT(DISTINCT city) AS unique_city,
    COUNT(city) - COUNT(DISTINCT city) AS total_diff
FROM station;


-- Q3. Query the two cities in STATION with the shortest and longest CITY names, as well as their
-- respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
-- largest city, choose the one that comes first when ordered alphabetically

(SELECT city,length(city) as longest_city from station ORDER BY length(city) DESC, CITY ASC LIMIT 1)
union all
(SELECT city, length(city) as shortest_city
from station ORDER BY length(CITY) ASC, CITY ASC  LIMIT 1);

-- Q4. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result
-- cannot contain duplicates.

SELECT DISTINCT city FROM station WHERE city like 'a%' or city like 'e%' or City like 'i%' or City like 'o%' or City like 'u%';

-- 2nd way using regexp

SELECT DISTINCT city FROM station where city regexp '^[aeiou]';

-- Q5. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot
-- contain duplicates.

SELECT DISTINCT city FROM station where city regexp '[aeiou]$';


-- Q6. Query the list of CITY names from STATION that do not start with vowels. Your result cannot
-- contain duplicates

SELECT DISTINCT city FROM station where city regexp '^[^aeiou]';

Q7. Query the list of CITY names from STATION that do not end with vowels. Your result cannot
contain duplicates.

SELECT DISTINCT city FROM station where city regexp '[^aeiou]$';

-- Q8. Query the list of CITY names from STATION that either do not start with vowels or do not end
-- with vowels. Your result cannot contain duplicates.

(SELECT DISTINCT city FROM station where city regexp '^[^aeiou]')
union
(SELECT DISTINCT city FROM station where city regexp '[^aeiou]$');


-- Q9. Query the list of CITY names from STATION that do not start with vowels and do not end with
-- vowels. Your result cannot contain duplicates.

SELECT DISTINCT city FROM station where city regexp '^[^aeiou]' and city regexp '[^aeiou]$';


-- Q10 Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
-- between 2019-01-01 and 2019-03-31 inclusive.

-- Ist way
SELECT p.product_id,p.product_name FROM sales s 
INNER JOIN product p ON p.product_id = s.product_id 
GROUP BY p.product_id,p.product_name
HAVING min(sale_date) >= '2019-01-01'
and max(sale_date) <= '2019-03-31';

-- 2nd way

SELECT p.product_id, p.product_name FROM product p 
WHERE p.product_id not in (
    SELECT product_id from sales 
    WHERE sale_date < '2019-01-01' or sale_date > '2019-03-31'
)