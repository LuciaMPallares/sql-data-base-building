--PREGUNTAS DE SELECT Y JOIN
-- 1. ¿Qué cliente se ha llevado x película? (Fran) HECHO
-- 2. ¿Qué películas se corresponde con x género? (Héctor)  HECHO
-- 3. Qué actores salen en x película? (Lucía)  HECHO
-- 4. ¿En qué idioma están las películas? (Marcos)  HECHO

-- PREGUNTAS DE GROUP BY Y ORDER BY 
-- 5. Agrúpame las películas por film_id e inventario
-- con nombre de la película (Fran)  HECHO


-- 6. Agrúpame los actores por actor_id con título
-- de película y ordenalos por género del film. (Lucía)  HECHO

-- PREGUNTAS DE OPERADORES


-- 7. Súmame el número de film por idioma. (Marcos) HECHO
-- 8. hazme una media de los días que las películas
-- han estado alquiladas. (Héctor)  HECHO
-- 9. TOP 20 de las  películas más alquiladas. (Lucía) HECHO
--ÚNICA PREGUNTA DE TABLA DERIVADA

--10. Hazme una suma de films por idiomas y la media
-- de idiomas. (Héctor)  HECHO


-- QUESTION 1

CREATE TABLE clients_films AS 
SELECT r.customer_id AS 'costumer', f.title AS 'title'
FROM films f
INNER JOIN inventories i  ON f.film_id  = i.film_id 
INNER JOIN rentals r ON r.inventory_id  = r.inventory_id ;


-- QUESTION 2

CREATE TABLE films_categories
AS SELECT DISTINCT  (F.title) AS "title",
C.name AS "category" FROM
films F INNER JOIN old_HDDs oh 
ON F.title= oh.title INNER JOIN 
categories C 
ON oh.category_id= C.category_id;


-- QUESTION 3
CREATE TABLE actors_by_movies AS 
SELECT A.first_name,
A.last_name,
F.title 
FROM actors A 
INNER JOIN old_HDDs OH 
ON 
A.last_name = OH.last_name 
INNER JOIN films F 
ON
OH.title = F.title;

-- QUESTION 4

CREATE TABLE  films_languages AS
SELECT F.title, LA.language_id
FROM films F
INNER JOIN languages LA 
ON LA.language_id = F.language_id;

-- QUESTION 5

CREATE TABLE film_inventary_titles AS
SELECT f.film_id AS 
'film_id',
i.inventory_id AS 'Inventory',
f.title AS 'title'
FROM films f 
INNER JOIN inventories i 
ON f.film_id  = i.film_id 
INNER JOIN rentals r 
ON r.inventory_id  = r.inventory_id 
GROUP BY f.film_id;

--QUESTION 6

CREATE TABLE actors_films_by_genres AS 
SELECT  A.actor_id,
A.first_name, 
A.last_name, 
C.name 
FROM actors a 
INNER JOIN old_HDDs OH 
ON A.first_name = OH.first_name 
INNER JOIN categories C 
ON OH.category_id = C.category_id 
ORDER BY C.category_id;

-- QUESTION 7

CREATE TABLE sum_films_languages AS
SELECT COUNT(F.title), L.name  
FROM films F
INNER JOIN languages L 
on F.language_id  = L.language_id 

-- QUESTION 8
CREATE TABLE avg_rentals AS 
SELECT 
title, AVG(rental_duration)
FROM films
GROUP BY title;

-- QUESTION 9

CREATE TABLE top_20_rented_movies AS
SELECT F.title, COUNT(I.film_id) AS count_id
FROM inventories I  INNER JOIN films F
ON I.film_id= F.film_id
GROUP BY F.title 
ORDER BY count_id DESC, F.title
LIMIT 20; 

--QUESTION 10

SELECT AVG(language_avg), 
count_language, 
language_name
FROM
(SELECT COUNT(F.title) AS count_language,
L.language_id  AS language_avg,
L.name AS language_name
FROM
films F INNER JOIN languages L 
ON F.language_id = L.language_id); 




