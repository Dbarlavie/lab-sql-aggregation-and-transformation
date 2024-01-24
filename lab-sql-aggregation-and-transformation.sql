use sakila;
#You need to use SQL built-in functions to gain insights relating to the duration of movies:
#1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select film_id, length from sakila.film ORDER BY length; 
select max(length) as max_duration from sakila.film ;
select min(length) as min_duration from sakila.film ;

#1.2. Express the average movie duration in hours and minutes. Don't use decimals.
#Hint: Look for floor and round functions.
#You need to gain insights related to rental dates:
SELECT FLOOR(AVG(length)/60) AS hours, ROUND(AVG(length) - FLOOR(AVG(length)/60)*60) AS minutes FROM sakila.film;

# 2.1 Calculate the number of days that the company has been operating.
#Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
select rental_date from sakila.rental;
select DATEDIFF(max(rental_date),min(rental_date)) as num_ops from sakila.rental;

#2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select *, CONCAT(DATE_FORMAT(rental_date,'%M'))AS 'rental_month', DAYname(rental_date) AS 'rental_day_of_week' from sakila.rental limit 20;

#3. You need to ensure that customers can easily access information about the movie collection. 
# To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. 
#Sort the results of the film title in ascending order.

select title,rental_duration from sakila.film where ifnull( rental_duration, 'Not Available') order by title asc;

#Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
#Hint: Look for the IFNULL() function.