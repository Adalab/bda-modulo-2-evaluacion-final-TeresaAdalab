# Evaluación Módulo 2

_Ejercicio de Evaluación del Módulo 2_

## Base de datos 🚀
Para esta evaluación usamos  la BBDD Sakila  que simula una tienda de alquiler de películas. Contiene las siguientes tablas:
* film (películas).
* actor (actores).
* customer (clientes).
* rental (alquileres).
* category (categorías).

Estas tablas contienen información sobre películas, actores, clientes, alquileres y más, y se utilizan para realizar consultas y análisis de datos en el contexto de una tienda de alquiler de películas.


### Desarrollo de Ejercicio 🔧

_la evalución se compone de 25 ejercicios, 23 de los cuales son obligatorios y 2 ellos son bonus_

1. Nombres de las películas sin que aparezcan duplicados.
```
SELECT DISTINCT title as "film_name"
FROM film;

```
2.Nombres de películas que tengan una clasificación de "PG-13"

En primer lugar vamos a usar "DESCRIBE" para saber el contenido y la estructura de la tabla  y seleccionar los  5 primeros registros
Usamos la clausula "Where" para filtar aquellas peliculas cuyo rating es PG-13.

3. Título y la descripción de  películas que contengan "amazing".
4. Título de  las películas con duración mayor a 120 minutos.
5.  Nombres  de todos los actores.
6.  Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
7.  Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
8.  Título de las películas en la tabla film que no sean ni "R" ni "PG-13" en su clasificación
9.  Cantidad total de películas en cada clasificación  y muestra su clasificación
10. Cantidad total de películas alquiladas por cada cliente, con id_cliente, nombre, apellido y cantidad de peliculas alquiladas
11. Cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
12. Promedio de duración de las películas para cada clasificación de la tabla film y  muestra la clasificación junto con el promedio de duración.
13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
14. Título de  las películas que contengan la palabra "dog" o "cat" en su descripción
15. Actor o actriz que no apareca en ninguna película en la tabla film_actor.
16. Título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
17. Título de todas las películas que son de la misma categoría que "Family".
18. Muestra  nombre y apellido de los actores que aparecen en más de 10 películas.
19. Encuentra el título  películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
20. Categorías de películas con un promedio de duración superior a 120 mins y  muestra el nombre de la categoría junto con el promedio de duración.
21.Actores que ha actuado en al menos de 5 peliculas.
22. Películas que fueron alquiladas por más de 5 días.
23. Nombre y apellido actores que no han actuado en ninguna pelicula de Horror, mediante una subconsulta
24. Encuentra el título de las películas que son comedias y tienen una duración mayor 180 minutos en la tabla film
25. Actores que han actuado juntos en al menos una película, con nombre apellidos y número de peliculas

## Autor ✒️

* **Teresa García**  -(https://github.com/TeresaAdalab)

## Software Utilizado 📋

El trabajo se ha desarrollado mediente el uso de My SQL Workbench

```
USE sakila;
SHOW TABLES;
```

