-- Introducción y uso de la base de datos
USE sakila;
/*
Muestra las tablas que tiene la base de datos de sakila.
*/
SHOW TABLES;

-- Ejercicio 1: Nombres de las películas sin que aparezcan duplicados.
/*
Hemos creado un alias "film_name y hemos usado DISTINCT 
que nos ha ayudado a eliminar los duplicados para tener solo un titulo de la pelicula
*/
SELECT DISTINCT title as "film_name"
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

-- Ejercicio 11:  Cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres
/*
En la primera hemos creado un alias category name para asignar un valor a esta columna
A continuación contamos el número de alquileres mediante COUNT y creamos para ello el alias "Total_rentals"
Estamos seleccionado la tabla rental mediante un alias (r)
	**INNER JOIN inventory i ON r.inventory_id = i.inventory_id, estamos uniendo con la tabla inventario con la tabla film mediante el film_id
	**INNER JOIN film f ON i.film_id = f.film_id; Unimos la tabla film con la tabla inventario mediante el film_id
	**INNER JOIN film_category fc ON f.film_id = fc.film_id; Unimos la tabla categoria de las peliculas(film_category) con la tabla film category mediante film_id.
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

-- Ejercicio 12:  Promedio de duración de las películas para cada clasificación de la tabla film y  muestra la clasificación junto con el promedio de duración.
/*
AVG(length) AS avg_duration: Mediante esta sentencia calculamos el valor medio de la duración (length) de las películas para cada clasificación
Y le añadimos el alias avg duration y lo hemos redondeado mediante ROUND
GROUP BY para agruparlo por los resultados de rating
*/

SELECT rating, ROUND(AVG(length), 2) AS avg_duration
FROM film
GROUP BY rating;


-- Ejercicio 13:  Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
/*
Para resolver este ejercicio hemos realizado una subconsulta que nos permite tener el film_id 
y luego otra subconsulta más para tener el actor_id

Primero seleccionamos los campos de nombre y apellidos de la tabla de actores que es la que contiene esta información.
** Subconsulta 1 WHERE actor.actor_id IN, se filtran los resultados de la tabla actor y solo se incluyen los actores que tenga un actor_id dentro de la 
** Subconsulta 2 SELECT film_actor.actor_id. Selecciona el "actor_id" de la film_actor y donde actor film_id coincida con los resultados que el titulo de la pelicula sea Indian Love
** Subconsulta 3:  SELECT film_id. Estamos seleccionado de la tabla film title aquella pelicula cuyo titulo es Indian Love

Es decir usamos varias subconsultas para encontrar primero el film_id de "Indian Love" y luego los actor_id asociados 
Cogemos  los nombres y apellidos de los actores cuyos actor_id coinciden con los obtenidos en la subconsulta.
*/

SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    WHERE film_actor.film_id = (
        SELECT film_id
        FROM film
        WHERE film.title = 'Indian Love'
    )
);

-- Ejercicio 14:Título de  las películas que contengan la palabra "dog" o "cat" en su descripción

/*
Usamos " WHERE description LIKE  OR", para buscar las palabras que en la columna descripcion contenga dog o cat m
*/
SELECT title, description
FROM film
WHERE description LIKE '%dog%'
   OR description LIKE '%cat%';
   
-- Ejercicio 15: Actor o actriz que no apareca en ninguna película en la tabla film_actor.
/*
Seleccionamos los datos del actor de la tabla actor
LEFT JOIN, realizamos una unión entre las tablas film_actor y actor usando el actor_id como id, 
Al usar "LEFT JOIN" incluimos todas las filas de la tabla actor y solo las filas conincidentes de la tabla film_actor.
Si no hay coincidencias, los campos de film_actor serán NULL.
"WHERE " hace un filtro para incluir los valordes donde el actor no aparece en niguna pelicula
*/

SELECT actor.first_name, actor.last_name
FROM actor
LEFT JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_actor.actor_id IS NULL;

-- Ejercicio 16: Título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title, release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- Ejercicio 17: Título de todas las películas que son de la misma categoría que "Family".

/*
Para poder resolver este ejercicio hemos usado una CTE llamada family_category que selecciona el category_id de la 
tabla category donde el nombre sea Family
Despues hemos realizado la consulta donde se ha seleccionado el titulo de las peliculas (title) de la tabla film con el alias f
Mediante el INNER JOIN hemos unido las tablas film y film_category con el film id y filtramos con "WHERE" incluyendo
los resultados  donde category_id esté presente en los resultados de la consulta temporal
Por último tenemos una subconsulta para seleccionar aquellas categorias de producto que son Family

*/


WITH family_category AS (
    SELECT category_id
    FROM category
    WHERE name = 'Family'
)
SELECT f.title
FROM film AS f
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
WHERE fc.category_id IN 
	(SELECT category_id FROM family_category );
    
-- Ejercicio 18: Muestra  nombre y apellido de los actores que aparecen en más de 10 películas.
/*
Creación de una CTE actor_films que cuenta el número de peliculas, tiene una consulta que selecciona el actor_id y usa el 
COUNT para contar el número de peliculas para cada actor (film_count),y agrupamos los resultados GROUP BY por actor_id.
*HAVING COUNT* hemos seleccionado solo los actores que han participado en mas de 10 peliculas.alter
Por último tenemos la consulta final que selecciona el nombre y el apellido de la tabla actores (a)
Creamos un "INNER JOIN" entre nuestra tabla actores y el CTE actor_films mediante el actor_id para unir las filas y asi obtener
el nombre y apellidos de los actores.
*/


WITH actor_films AS (
    SELECT actor_id, COUNT(*) AS film_count
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(*) > 10
)
SELECT a.first_name, a.last_name
FROM actor AS a
INNER JOIN actor_films ON a.actor_id = actor_films.actor_id;

-- Ejercicio 19: Encuentra el título  películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
SELECT*
FROM film

SELECT title, rating, length
FROM film
WHERE rating = 'R' AND length > 120
ORDER BY length DESC ;

-- Ejercicio 20: Categorías de películas con un promedio de duración superior a 120 mins y  muestra el nombre de la categoría junto con el promedio de duración.
/*
Usamos las tablas category, film_category y film que estan relacionadas mediante primary key y foreing keys
Con los "INNER JOIN" unimos las tablas de film_category, category y film 
Calculamos el promedio mediante AVG que es promedio de la duración de cada una de las peliculas en cada categoría.
Lo argupamos por GROUP BY mediante el nombre de la categoria (c.name) ya que necesitamos saber el promedio para cada categoría
Usamos"Having" para filtar los resultados cuya duración es mayor a 120 minutos.
*/

SELECT c.name AS category_name, ROUND(AVG(f.length),2) AS average_duration
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 120;

-- Ejercicio 21: Actores que ha actuado en al menos de 5 peliculas

/*
Seleccionamos el mombre y el apellido de la tabla de actores, esta tabla tiene el alias ac
Unimos las tablas con "INNER JOIN" para tener los datos de la tabla actores y con la tabla de relacion entre
actores y peliculas (film_actor(fa)) para saber que actores participan en las peliculas
Agrupamos con "GROUP BY" por el actor_id de la tabla actores(ac)	
*HAVING COUNT*, Hemos usado el Count para saber las peliculas hay en cada grupo de actores y despues se ha filtrado por 
HAVING para seleccionar solo los que tiene mas de 5
*/

SELECT ac.first_name, ac.last_name, COUNT(*) AS movie_count
FROM actor AS ac
INNER JOIN film_actor AS fa ON ac.actor_id = fa.actor_id
GROUP BY ac.actor_id
HAVING COUNT(*) >= 5;

-- Ejercicio 22:  Películas que fueron alquiladas por más de 5 días.

/* Resolucion 1. Mediante una  CTE: 
Hemos creado una CTE large_rental que va a contener una subconsulta que selecciona los film_id de las peliculas con mas de 5 dias
Con SELECT DISTINCT solo aparece una sola vez film_id de la tabla inventory
"INNER JOIN" unimos las tablas de rental con la inventarios mediante el inventory_id
"WHERE DATEDIFF(r.return_date, r.rental_date) > 5" filtra los registros para incluir solo aquellos con una diferencia de más de 5 días entre return_date y rental_date
Despues de la CTE hacemos una consulta que selecciona los titulos de la tabla film y filtra las peliculas cuyos film id estan en el film id de la CTE
*/

WITH large_rental AS (
    SELECT DISTINCT i.film_id
    FROM rental AS r
    INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
    WHERE DATEDIFF(r.return_date, r.rental_date) > 5
)
SELECT title
FROM film
WHERE film_id IN (SELECT film_id FROM  large_rental);

/* Resolucion 2. Mediante una  Subconsulta: 
La tabla flim (f) seleccionamos aquellos titulos que sean diferentes mediante un DISTINCT, de esta forma eliminamos los duplicados.
Realizamos un INNER JOIN entre la tabla flim (f) e inventory(i) mediante el flim_id e incluimos 
y filtramos para incluir los registros donde inventory_id esten en la subconsulta que hemos creado.
En la subconsulta  SELECT r.inventory_id, seleccionamos los inventory_id de la tabla rental (r) y filtramos aquellos registros
cuya diferencia entre el rental_date y el return_date sea mayor que 5 usando DATEDIFF
*/



SELECT DISTINCT f.title
FROM film AS f
INNER JOIN inventory AS i ON f.film_id = i.film_id
WHERE i.inventory_id IN (
    SELECT r.inventory_id
    FROM rental AS r
    WHERE DATEDIFF(r.return_date, r.rental_date) > 5
);

-- Ejercicio 23: Nombre y apellido actores que no han actuado en ninguna pelicula de Horror, mediante una subconsulta

/*
Seleccionamos los campos first_name y last_name de la tabla actor que tiene el alias alter
Hacemos un filtro de los actores mediante WHERE y NOT IN tomando como referencia la subconsulta
En la subconsulta seleccionamos los actor_id de la tabla film actor (fa)
Usamos un INNER JOIN entre la tabla de film category (fc) y film actor (fa) por el film_id de ambas.
Despues creamos otro INNER JOIN entre la tabla category (c) y film category (fc) por category_id de ambas
Y con el WHERE filtramos donde la categoria sea Horror
*/

SELECT a.first_name, a.last_name
FROM actor AS a
WHERE a.actor_id NOT IN (
    SELECT fa.actor_id
    FROM film_actor AS fa
    INNER JOIN film_category AS fc ON fa.film_id = fc.film_id
    INNER JOIN category AS c ON fc.category_id = c.category_id
    WHERE c.name = 'Horror'
);

-- Ejercicio 24: Encuentra el título de las películas que son comedias y tienen una duración mayor 180 minutos en la tabla film
/*
Hemos creado una CTE que se llama Comedias
En la cual hay una consulta que selecciona los film_id de la tabla film category
Despues hay una subconsulta que selecciona el category_id de la tabla category donde el nombre sea Comedia
En la siguiente parte del código hemos seleccionado de la tabla film los titulos que este dentro de los resultados de la CTE
En esta parte de la subconsulta seleccionamos los flim_id de la CTE y agregamos la condicion mediante AND y que length sea mayor a 180
*/

WITH Comedias AS (
    SELECT film_id
    FROM film_category
    WHERE category_id IN (
        SELECT category_id
        FROM category
        WHERE name = 'Comedy'
    )
)

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM Comedias
) AND length > 180;

-- Ejercicio 25: Actores que han actuado juntos en al menos una película, con nombre apellidos y número de peliculas

/*
Usamos SELECT CONCAT(a1.first_name, ' ', a1.last_name) tanto para actor 1 como para actor para concatenar el nombre y apellido de cada uno de los actores de las peliculas
COUNT(*) AS movies_together: Aquí contamos el número de filas en el conjunto de resultados mediante el alias movies_together.

FROM film_actor AS fa: Aquí estamos seleccionando la tabla film_actor y asignándole un alias (fa1 /fa2)
De esta forma unimos la informacion sobre las pelicula con los actores que han actuado y asi poder extrear los actores que han trabajdo juntos. 

JOIN con actor (a1) y actor (a2): Se unen las tablas actor dos veces para obtener la información de los actores en cada par. Utilizamos los alias a1 y a2 para distinguir entre los dos actores en cada par.

Agregación y conteo: Contamos el número de películas en las que cada par de actores ha actuado juntos. Agrupamos los resultados por los nombres de los actores.

Ordenación: Ordenamos los resultados en orden descendente según el número de películas en las que los actores han actuado juntos.






explicame esta parte del codigo SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2,
    COUNT(*) AS movies_together
FROM 
ChatGPT
Claro, esta parte del código se encarga de seleccionar y concatenar los nombres y apellidos de los actores y contar el número de películas en las que han actuado juntos. Veamos en detalle:

SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS actor1: En esta línea, estamos utilizando la función CONCAT para combinar el first_name y el last_name del primer actor (a1) y así formar su nombre completo. Usamos un espacio en blanco entre el nombre y el apellido para separarlos. El alias actor1 se asigna al resultado concatenado.

SELECT CONCAT(a2.first_name, ' ', a2.last_name) AS actor2: De manera similar, esta línea concatena el first_name y el last_name del segundo actor (a2) para formar su nombre completo. El alias actor2 se asigna al resultado.

COUNT(*) AS movies_together: Aquí contamos el número de filas en el conjunto de resultados. Cada fila representa una película en la que los dos actores han actuado juntos. Por lo tanto, el recuento nos da el número total de películas en las que los actores han trabajado juntos. Este recuento se etiqueta con el alias movies_together.

En resumen, esta parte del código selecciona los nombres completos de los dos actores y cuenta el número de películas en las que han actuado juntos. El resultado final será una lista de pares de actores junto con la cantidad de películas en las que han trabajado juntos.

explicame esta parte del codigo FROM 
    film_actor AS fa1
JOIN 
    film_actor AS fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN 
    actor AS a1 ON fa1.actor_id = a1.actor_id
JOIN 
    actor AS a2 ON fa2.actor_id = a2.actor_id
ChatGPT
Claro, esta parte del código se encarga de realizar las uniones necesarias entre las tablas film_actor y actor para obtener la información sobre los actores y las películas en las que han actuado juntos. Veamos en detalle:

FROM film_actor AS fa1: Aquí estamos seleccionando la tabla film_actor y asignándole un alias fa1. Esto nos permite hacer referencia a esta tabla con el alias fa1 en el resto de la consulta.

JOIN film_actor AS fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id: Estamos realizando un JOIN de la tabla film_actor consigo misma utilizando un segundo alias fa2. La condición fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id asegura que obtengamos todos los pares únicos de actores que han actuado juntos en al menos una película. La parte fa1.actor_id < fa2.actor_id garantiza que cada par de actores se cuente solo una vez y evita duplicados.

JOIN con actor (a1) y actor (a2): Se unen las tablas actor dos veces para obtener la información de los actores en cada par mediante los alias a1 y a2

Agrupamos los resultados por los nombres de los actores por GROUP BY
ORDER BY  Ordenamos los resultados en orden descendente según el número de películas 

*/




SELECT 
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2,
    COUNT(*) AS movies_together
FROM 
    film_actor AS fa1
JOIN 
    film_actor AS fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
JOIN 
    actor AS a1 ON fa1.actor_id = a1.actor_id
JOIN 
    actor AS a2 ON fa2.actor_id = a2.actor_id
GROUP BY 
    actor1, actor2
ORDER BY 
    movies_together DESC;