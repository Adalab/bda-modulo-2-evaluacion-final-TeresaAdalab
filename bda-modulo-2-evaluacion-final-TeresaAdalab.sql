-- Introducción y uso de la base de datos
USE sakila;
/*
Muestra las tablas que tiene la base de datos de sakila.
*/
SHOW TABLES;

-- Ejercicio 1: Nombres de las películas sin que aparezcan duplicados.
/*
Hemos creado un alias "nombre_peli" y hemos usado DISTINCT 
que nos ha ayudado a eliminar los duplicados para tener solo un titulo de la pelicula
*/
SELECT DISTINCT title as "nombre_peli" 
FROM film;

-- Ejercicio 2: Nombres de películas que tengan una clasificación de "PG-13.
/*
En primer lugar vamos a usar "DESCRIBE" para saber el contenido y la estructura de la tabla 
y seleccionar los  5 primeros registros
Usamos la clausula "Where" para filtar aquellas peliculas cuyo rating es PG-13.
*/

DESCRIBE film;
SELECT *
FROM film
LIMIT 5;

SELECT title, rating
FROM film
WHERE rating = 'PG-13';

-- Ejercicio 3: Título y la descripción de  películas que contengan "amazing" .

/*
Vamos a usar el operador "LIKE" para saber coincidencias parciales 
y "%" para representar cualquier sentencia de caracteres 
*/

SELECT title, description
FROM film
WHERE description LIKE '% amazing %';

-- Ejercicio 4:  Título de  las películas con duración mayor a 120 minutos.

SELECT title, length
FROM film
WHERE length > 120;

-- Ejercicio 5:  Nombres  de todos los actores.
/*
Hemos usado la tabla actores y seleccionado su nombre y apellidos con un "SELECT"
*/
SELECT  first_name
FROM actor;

-- Ejercicio 6: Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
/*
Hay 2 opciones para poder resolver este ejercicio
1. Usar el operador "LIKE" para saber coincidencias parciales 
y "%" para representar cualquier sentencia de caracteres 
2. Mediante el uso de = que sería una busqueda exacta
*/

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%Gibson%';

SELECT first_name, last_name
FROM actor
WHERE last_name = "Gibson";

-- Ejercicio 7: Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

/*
Hemos usado "WHERE" para filtrar las condiciones de nuestra consulta, 
 Se ha usado el operador "BETWEEN" "AND" para especificar nuestro rango de valores entre 10 y 20 inclusive.
*/

SELECT first_name, last_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

-- Ejercicio 8: Título de las películas en la tabla film que no sean ni "R" ni "PG-13" en su clasificación
/*
Hemos usado "WHERE" para filtrar las condiciones de nuestra consulta, 
 Se ha usado el operador "NOT IN"  para excluir todas aquellas peliculas
 cuya clasificacion es "R" or "P-13"
*/

SELECT title
FROM film
WHERE rating NOT IN ('R', 'PG-13');

-- Ejercicio 9:  Cantidad total de películas en cada clasificación  y muestra su clasificación 
/*
Hemos usado "COUNT" para contabilizar el número de peliculas en cada grupo de rating,
creando un alias "total_peli_rating" 
Después hemos usado la sentencia "GROUP BY" para agrupar las filas en función de varios valores de la columna
*/

SELECT rating, COUNT(*) AS total_peli_rating
FROM film
GROUP BY rating;
