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
SELECT  first_name, last_name
FROM actor;
