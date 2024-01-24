use sakila;
# Challenge 1
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

#Challenge 2
# Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
#1.1 The total number of films that have been released.
select count(release_year) from sakila.film;

#1.2 The number of films for each rating.
select rating, count(*) as film_amount from sakila.film group by rating;

#1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
#This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
select rating, count(*) as film_amount from sakila.film group by rating order by film_amount desc;

#Using the film table, determine:
#2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
#Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
select rating, count(*) as film_amount, round(avg(length),2) as mean_film_duration from sakila.film group by rating order by mean_film_duration desc;

#2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select rating, count(*) as film_amount, round(avg(length),2) as mean_film_duration from sakila.film group by rating having mean_film_duration>120 order by mean_film_duration desc ;