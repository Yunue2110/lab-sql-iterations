USE SAKILA;

##Write a query to find what is the total business done by each store.

SELECT* FROM staff;
SELECT*FROM payment;

SELECT s.store_id, sum( p.amount) AS sales_store from staff s
JOIN payment p on s.staff_id = p.staff_id
GROUP BY s.store_id ;

##Convert the previous query into a stored procedure.

DELIMITER //

CREATE PROCEDURE sales_by_store(OUT sales_store float )
BEGIN
    SELECT s.store_id, SUM(p.amount) AS sales_store
    FROM staff s
    JOIN payment p ON s.staff_id = p.staff_id
    GROUP BY s.store_id;
END //

DELIMITER ;
CALL sales_by_store(@sales_store);

##Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.
##Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.


DELIMITER //

CREATE PROCEDURE sales_store(IN store_id_param INT, OUT sales_store FLOAT)
BEGIN
    SELECT SUM(p.amount) INTO sales_store
    FROM staff s
    JOIN payment p ON s.staff_id = p.staff_id
    WHERE s.store_id = store_id_param;
END //

DELIMITER ;

CALL sales_store(1, @sales_store);
SELECT @sales_store;

###In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.

DELIMITER //

CREATE PROCEDURE sales_by_store_with_flag(IN store_id_param INT, OUT sales_store FLOAT, OUT flag VARCHAR(10))
BEGIN
    SELECT SUM(p.amount) INTO sales_store
    FROM staff s
    JOIN payment p ON s.staff_id = p.staff_id
    WHERE s.store_id = store_id_param;
    
    IF sales_store > 30000 THEN
        SET flag = 'green_flag';
    ELSE
        SET flag = 'red_flag';
    END IF;
END //

DELIMITER ;

CALL sales_by_store_with_flag(1, @sales_store, @flag);
SELECT @sales_store, @flag;



