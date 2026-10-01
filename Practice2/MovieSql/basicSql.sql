Show tables;

SELECT * FROM movies_db_1;

SELECT * from movies_db_1 WHERE title like '%Avenger%';
SELECT release_year FROM movies_db_1 WHERE title = 'The Godfather';

SELECT DISTINCT * FROM movies_db_1 WHERE industry = 'Bollywood';

SELECT * FROM movies_db_1 ORDER by release_year desc;
SELECT * FROM movies_db_1 WHERE release_year = 2022;
SELECT * FROM movies_db_1 WHERE release_year > 2020;
SELECT * FROM movies_db_1 WHERE release_year = 2020 and imdb_rating > 8;

SELECT * FROM movies_db_1 WHERE studio IN ('Marvel Studios','Hombale Films');

SELECT title, release_year FROM movies_db_1 WHERE title like '%THOR%';

SELECT * FROM movies_db_1 WHERE studio != 'Marvel Studios';




SELECT count(*) as total_movies_released FROM movies_db_1 WHERE release_year BETWEEN 2015 and 2022;

SELECT min(release_year) as min_movie,max(release_year) FROM movies_db_1 ;

SELECT release_year,count(*) as total_movies_released FROM movies_db_1 GROUP BY release_year
ORDER BY release_year DESC;


SELECT release_year,count(*) as total_movies_released FROM movies_db_1 GROUP BY release_year
HAVING total_movies_released > 2
ORDER BY release_year DESC;
SELECT MONTHName(curDATE());

SELECT * FROM actors;

SELECT *, YEAR(curDate())-birth_year as Age FROM actors;