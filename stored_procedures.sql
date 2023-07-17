USE sakila;

##n the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. Convert the query into a simple stored procedure. Use the following query:

SELECT*FROM category;
 select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
  
  
drop procedure if exists  get_customers_by_category ;  
 
 DELIMITER //
CREATE PROCEDURE get_customers_by_category( IN name VARCHAR(30) )
BEGIN
    SELECT first_name, last_name, email
    FROM customer
    JOIN rental ON customer.customer_id = rental.customer_id
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON film.film_id = inventory.film_id
    JOIN film_category ON film_category.film_id = film.film_id
    JOIN category ON category.category_id = film_category.category_id
    WHERE CAST( category.name AS BINARY) = ("Action")
    GROUP BY  first_name, last_name, email;
END //
DELIMITER ;

CALL get_customers_by_category ('animation'); 

##Now keep working on the previous stored procedure to make it more dynamic. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre. For eg., it could be action, animation, children, classics, etc.
CALL get_customers_by_category ('ACTION');
CALL get_customers_by_category ('comedy');
CALL get_customers_by_category ('drama');
CALL get_customers_by_category ('family');

