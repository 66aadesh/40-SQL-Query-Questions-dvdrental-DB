--Beginner Level:

--Q1: - Retrieve all records from the "customer" table.
SELECT * FROM customer

--Q2: - Retrieve the names of all distinct cities from the "customer" table.
--"cities" column does not exist in "customers" table. 

--Q3: - Retrieve the customer ID, first name, and last name of customers whose last name is "Smith."
SELECT "customer_id", "first_name", "last_name" FROM customer
WHERE "last_name" = 'Smith'

--Q4: - Retrieve the film ID, title, and rental rate of all films.
SELECT * FROM film
SELECT film_id, title, rental_rate FROM film

--Q5: - Retrieve the number of films in each category.
SELECT * FROM category
SELECT * FROM film
SELECT * FROM film_category

SELECT CATEGORY.NAME AS CATEGORY, COUNT(FILM_CATEGORY.FILM_ID) AS NUMBER_OF_FILMS, CATEGORY.CATEGORY_ID
FROM CATEGORY
JOIN FILM_CATEGORY ON FILM_CATEGORY.CATEGORY_ID = CATEGORY.CATEGORY_ID
GROUP BY CATEGORY.CATEGORY_ID
ORDER BY CATEGORY.CATEGORY_ID ASC

--Q6: - Retrieve the film ID, title, and length of all films longer than 120 minutes.
SELECT * FROM film

SELECT "film_id", "title", "length" FROM film
WHERE "length" > '120'

--Q7: - Retrieve the rental ID, rental date, and return date of all rentals.
SELECT * FROM rental

SELECT 	rental_id, rental_date, return_date FROM rental

--Q8: - Retrieve the total number of rentals for each customer.
SELECT * FROM customer
SELECT * FROM rental

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS Number_of_Rentals
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY Number_of_Rentals DESC

--Q9: - Retrieve the rental ID, customer ID, and return date of rentals that are overdue.
SELECT * FROM RENTAL

SELECT * FROM PAYMENT

SELECT * FROM STAFF

SELECT * FROM FILM

SELECT * FROM INVENTORY
--AFTER CHECKING ALL THE TABLES, THE REQUIRED DATA RETRIEVAL IS NOT POSSIBLE AS THERE IS NO COLUMN INDICATING OVERDUE RENTALS.

--Q10: - Retrieve the rental ID, film ID, and rental duration of rentals with a duration of more than 5 days.
SELECT * FROM rental
SELECT * FROM film
SELECT * FROM inventory


SELECT RENTAL.RENTAL_ID, INVENTORY.FILM_ID, (RENTAL.RETURN_DATE - RENTAL.RENTAL_DATE) AS DURATION
FROM RENTAL
JOIN INVENTORY ON INVENTORY.INVENTORY_ID = RENTAL.INVENTORY_ID
WHERE (RENTAL.RETURN_DATE - RENTAL.RENTAL_DATE) >= '5 days'
