/*
 * You want to watch a movie tonight.
 * But you're superstitious,
 * and don't want anything to do with the letter 'F'.
 *
 * Write a SQL query that lists the titles of all movies that:
 * 1) do not have the letter 'F' in their title,
 * 2) have no actors with the letter 'F' in their names (first or last),
 * 3) have never been rented by a customer with the letter 'F' in their names (first or last).
 * 4) have never been rented by anyone with an 'F' in their address (at the street, city, or country level).
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 */

WITH part_1 AS (
    SELECT title, film_id
    FROM film
    WHERE film.title LIKE '%F%'),

part_2 AS (
    SELECT title FROM film
    JOIN film_actor USING(film_id)
    JOIN actor USING(actor_id)
    WHERE actor.first_name LIKE '%F' OR actor.last_name LIKE '%F%'),

part_3 AS (
    SELECT title from FILM
    JOIN inventory USING(film_id)
    JOIN rental USING(inventory_id)
    JOIN customer USING(customer_id)
    WHERE customer.first_name LIKE '%F%' or customer.last_name LIKE '%F%'),

part_4 AS (
    SELECT title, film_id FROM film
    JOIN inventory USING(film_id)
    JOIN rental USING(inventory_id)
    JOIN customer USING(customer_id)
    JOIN address USING(address_id)
    JOIN city USING (city_id)
    JOIN country USING(country_id)
    WHERE country.country LIKE '%F%'
    OR city.city LIKE '%F%'
    OR address.address LIKE '%F'
    or address.address2 LIKE '%F%')

SELECT DISTINCT title from film
EXCEPT (SELECT title from part_1)
EXCEPT (SELECT title from part_2)
EXCEPT (SELECT title from part_3)
EXCEPT (SELECT title from part_4)
ORDER BY title;



