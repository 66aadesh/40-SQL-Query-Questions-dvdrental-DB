--Q11: - Retrieve the film ID, title, and rating of all films in the "Documentary" category.
SELECT * FROM film

SELECT * FROM category

SELECT * FROM film_category

SELECT film.film_id, film.title, film.rating
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON category.category_id = film_category.category_id
WHERE category.name = 'Documentary'

--Q12: - Retrieve the customer ID, first name, and last name of customers who have rented the film with the title "Chamber Italian."
SELECT * FROM film
WHERE film.title = 'Chamber Italian'

SELECT * FROM customer

SELECT * FROM rental

SELECT * FROM inventory

SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'Chamber Italian'

--Q13: - Retrieve the rental ID, customer ID, and staff ID of rentals where the customer and staff have the same first name.
SELECT * FROM rental
SELECT * FROM staff
SELECT * FROM customer

SELECT rental.rental_id, rental.customer_id, rental.staff_id
FROM rental
JOIN staff ON rental.staff_id = staff.staff_id
JOIN customer ON rental.customer_id = customer.customer_id
WHERE staff.first_name = customer.first_name

--Q14: - Retrieve the film ID, title, and rental rate of films that have not been rented yet.
SELECT * FROM FILM
WHERE RENTAL_DURATION = '0'

--A FILM THAT HAS NOT BEEN RENTED YET, DOES NOT EXIST.
--ALL FILMS HAVE BEEN RENTED AT LEAST ONCE.

--Q15: - Retrieve the customer ID, first name, and last name of customers who have rented at least 10 films.
SELECT * FROM RENTAL
WHERE CUSTOMER_ID = '12'

SELECT CUSTOMER.CUSTOMER_ID, CUSTOMER.FIRST_NAME, CUSTOMER.LAST_NAME, COUNT(RENTAL.CUSTOMER_ID) AS NUMBER_OF_RENTAL
FROM CUSTOMER
JOIN RENTAL ON RENTAL.CUSTOMER_ID = CUSTOMER.CUSTOMER_ID
GROUP BY CUSTOMER.CUSTOMER_ID
HAVING COUNT(RENTAL.RENTAL_ID) >= '10'

SELECT COUNT(CUSTOMER_ID) FROM RENTAL
WHERE CUSTOMER_ID = '87'

--Q16: - Retrieve the film ID, title, and rental rate of the top 10 most expensive films.
SELECT * FROM film

SELECT FILM_ID, TITLE, RENTAL_RATE
FROM FILM
ORDER BY RENTAL_RATE DESC
LIMIT 10

--Q17: - Retrieve the customer ID, first name, and last name of customers who have rented films from all categories.
--METHOD-1
SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film_category AS fc ON i.film_id = fc.film_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT fc.category_id) = (SELECT COUNT(*) FROM category);
--METHOD-2
SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
WHERE (
    SELECT COUNT(DISTINCT fc.category_id)
    FROM rental AS r
    JOIN inventory AS i ON r.inventory_id = i.inventory_id
    JOIN film_category AS fc ON i.film_id = fc.film_id
    WHERE r.customer_id = c.customer_id
) = (SELECT COUNT(*) FROM category);

--Q18: - Retrieve the rental ID, customer ID, and rental date of rentals made on weekends.
--VERY IMPORTAN TO EXTRACT DAY OF THE WEEK.
--METHOD-1
SELECT RENTAL.RENTAL_ID, RENTAL.CUSTOMER_ID, extract(dow from RENTAL.RENTAL_DATE) as Day_of_week 
FROM RENTAL
GROUP BY RENTAL.RENTAL_ID
HAVING extract(dow from RENTAL.RENTAL_DATE) = '4' OR extract(dow from RENTAL.RENTAL_DATE) = '5'
OR extract(dow from RENTAL.RENTAL_DATE) = '6'
--METHOD-2
SELECT RENTAL.RENTAL_ID, RENTAL.CUSTOMER_ID, RENTAL.RENTAL_DATE
FROM RENTAL
WHERE extract(dow from RENTAL.RENTAL_DATE) = 0 OR extract(dow from RENTAL.RENTAL_DATE) = 6;

--Q19: - Retrieve the film ID, title, and replacement cost of films with a replacement cost greater than the average replacement cost.
SELECT * FROM FILM

SELECT F.FILM_ID, F.TITLE, F.REPLACEMENT_COST
FROM FILM AS F
GROUP BY F.FILM_ID
HAVING F.REPLACEMENT_COST = AVG(F.REPLACEMENT_COST)

SELECT film_id, title, replacement_cost
FROM films
WHERE replacement_cost > (
    SELECT AVG(replacement_cost)
    FROM films
)

--Q20: - Retrieve the customer ID, first name, and last name of customers who have not rented any films.

SELECT * FROM customer

SELECT * FROM rental

SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
LEFT JOIN rental AS r ON c.customer_id = r.customer_id
WHERE r.customer_id IS NULL;
