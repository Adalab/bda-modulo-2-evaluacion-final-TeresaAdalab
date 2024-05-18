-- Introducción y uso de la base de datos
USE sakila;
/*
Muestra las tablas que tiene la base de datos de sakila.
*/
SHOW TABLES;

-- Ejercicio 1: Nombres de las películas sin que aparezcan duplicados.
/*
Hemos creado un alias "flim_name y hemos usado DISTINCT 
que nos ha ayudado a eliminar los duplicados para tener solo un titulo de la pelicula
*/
SELECT DISTINCT title as "flim_name"
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

-- Ejercicio 10:  Cantidad total de películas alquiladas por cada cliente, con id_cliente, nombre, apellido y cantidad de peliculas alquiladas
/*
Estamos utilizando COUNT() para contar el número de alquileres (rental_id) de  cada cliente 
con la creación de un alias total_rentals
"INNER JOIN", estamos uniendo la tabla rental (que tiene información sobre los alquileres) con la tabla customer con las 
 filas de la tabla rental mediante el uso del  customer_id
Hemos optado por usar un "INNER JOIN" en lugar "LEFT JOIN" porque estamos buscando solo aquellos que son coincidentes en ambas tablas
Para sacar aquellos clientes que no alquilado nada habría que usar un "LEFT_JOIN"
Por úlitmo, hemos usado "GROUP BY" para agrupar las filas que contienen los mismos valores, de esta forma solo podremos ver un cliente
*/


SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- Ejercicio 11:  cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres
/*
En la primera hemos creado un alias category name para asignar un valor a esta columna
A continuación contamos el número de alquileres mediante COUNT y creamos para ello el alias "Total_rentals"
Estamos seleccionado la tabla rental mediante un alias (r)
	**INNER JOIN inventory i ON r.inventory_id = i.inventory_id, estamos uniendo con la tabla inventario con la tabla flim mediante el flim_id
	**INNER JOIN film f ON i.film_id = f.film_id; Unimos la tabla flim con la tabla inventario mediante el flim_id
	**INNER JOIN film_category fc ON f.film_id = fc.film_id; Unimos la tabla categoria de las peliculas(flim_category) con la tabla flim category mediante flim_id.
	**INNER JOIN category c ON fc.category_id = c.category_id; Unimos las filas de la tabla film_category con las filas de la tabla category basándote en el category_id
GROUP BY: Aqui hemos agrupado las filas que contienen los mismos valores en una sola columna
ORDER BY: Despúes lo hemos ordendo los resultados de menor a mayor mediante el campo total_rental (total alquileres)
*/

SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_rentals DESC;

-- Ejercicio 12:  Promedio de duración de las películas para cada clasificación de la tabla flim y  muestra la clasificación junto con el promedio de duración.
/*
AVG(length) AS avg_duration: Mediante esta sentencia calculamos el valor medio de la duración (length) de las películas para cada clasificación
Y le añadimos el alias avg duration y lo hemos redondeado mediante ROUND
GROUP BY para agruparlo por los resultados de rating
*/

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating;


