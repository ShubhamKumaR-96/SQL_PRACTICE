show databases;

USE zomato_case;
show tables;

SELECT * FROM orders;

UPDATE users
SET 
    name = 'Shubh',
    email = 'Shubh@example.com',
    password = 's29new4'
WHERE user_id = 1;


-- Q1 ->  Return N Random records from users
SELECT * FROM users ORDER BY rand() LIMIT 5;

-- Q2 ->  Find Null Values

SELECT * from orders where restaurant_rating is NOT NULL;

-- Q3 -> Find numbers of orders placed by each customer

SELECT * FROM users;


SELECT u.name, COUNT(*) AS total_orders
FROM orders o
INNER JOIN users u ON u.user_id = o.user_id
GROUP BY u.user_id, u.name;


-- Q4 -> Find restaurant with most number of menu items;

SELECT * from menu;

SELECT rs.r_id, rs.r_name, count(*) as max_menu_items_rs  FROM restaurants rs 
INNER JOIN menu mu on rs.r_id = mu.r_id
GROUP BY rs.r_id,rs.r_name;

-- Q5 -> Find number of votes and avg rating for all restaurants

SELECT * FROM orders;



SELECT o.r_id, r.r_name, 
       COUNT(o.restaurant_rating) AS total_votes, 
       ROUND(AVG(o.restaurant_rating),2) AS avg_rating
FROM orders o
INNER JOIN restaurants r ON o.r_id = r.r_id
WHERE o.order_id IS NOT NULL
GROUP BY o.r_id, r.r_name;



-- Q6 -> Find the food that is being sold at most number of restaurants

SELECT * FROM menu;
SELECT * FROM food;

SELECT f.f_name , count(*) as most_ordered FROM food f 
INNER JOIN menu m on m.f_id = f.f_id
GROUP BY f.f_name ORDER BY most_ordered DESC LIMIT 1;


-- Q7 -> Find restaurants with max revenue in a givem month May

SELECT * FROM orders;
SELECT * FROM restaurants;

SELECT r.r_name, sum(amount) as revenue from orders o 
INNER JOIN restaurants r on o.r_id = r.r_id
WHERE monthname(Date(o.date)) = 'MAY'
GROUP BY r.r_name, Date(o.date) ORDER BY revenue DESC;





