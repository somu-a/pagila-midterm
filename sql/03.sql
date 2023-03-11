/*
 * Write a SQL query SELECT query that:
 * List the first and last names of all actors who have appeared in movies in the "Children" category,
 * but that have never appeared in movies in the "Horror" category.
 */

WITH children_actor AS(
    SELECT actor_id
    FROM actor
    JOIN film_actor USING(actor_id)
    JOIN film USING(film_id)
    JOIN film_category USING(film_id)
    JOIN category USING(category_id)
    WHERE category.category_id = 3
),

horror_actor AS (
    SELECT actor_id
    FROM actor
    JOIN film_actor USING(actor_id)
    JOIN film USING(film_id)
    JOIN film_category USING(film_id)
    JOIN category USING(category_id)
    WHERE category.category_id = 11
)

SELECT DISTINCT first_name, last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT * FROM children_actor)
AND actor.actor_id NOT IN (
    SELECT * FROM horror_actor)
ORDER BY last_name;
