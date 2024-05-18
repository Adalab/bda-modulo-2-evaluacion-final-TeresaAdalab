-- Introducción y uso de la base de datos
USE sakila;
/*
Muestra las tablas que tiene la base de datos de sakila.
*/
SHOW TABLES;
-- Ejercicio 1: Nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT title as "nombre_peli" 
FROM film;
-- Ejercicio 1: Nombres de las películas sin que aparezcan duplicados.