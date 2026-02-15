/*1. SELECT : to select the fields from the table*/

--Ex: select all the columns from the table(*)
SELECT *
FROM customers;

--select the firstname and country from the table
SELECT first_name, country
FROM customers;


/*2. WHERE: to filter the data based on some condiation*/

--EX: get the first_name who are from the USA
SELECT first_name
FROM customers
WHERE country='USA'

/*3. ORDER BY: to get the ordered/sorted result based on one or multiple columns in ASC or DESC order*/

--show the customers in asc order by there score
SELECT *
FROM customers
ORDER BY score;--by default it will be in ASC

--show the results in DESC by the id
SELECT *
FROM customers
ORDER BY id DESC;

--show the customers order by country ASC and then score by DESC if they are from the same country
SELECT *
FROM customers
ORDER BY country ASC, score DESC;

/*4. GROUP BY: This helps to group data by 1 or more column and result u can get with some agreegated function
 but the col u mention in select must appear in the group by clause or it should be a part of the agreegate funtion
 */

--get the total score of each country
SELECT country, sum(score) total_score
FROM customers
GROUP BY country;

--get the total score and the number of people contributed for that score
SELECT country, sum(score) total_score, count(id) total_customer
FROM customers
GROUP BY country;

/*5. HAVING: This is where clause for the aggregated columns like simple where this is used when we have groupby to filter data based on the agreegated col*/

-- get the country and score which total_score >800
SELECT country, sum(score) total_score
FROM customers
GROUP BY country
HAVING sum(score) > 800;

/*
 NOTE: where is used to filter the data before aggregation and having is used to filter after the aggregation on the aggregated columns
*/

-- Q: find the avg score of each country considering country don't have 0 score and return the result which have avg score >430
SELECT country, avg(score) avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING avg(score) >430;

/*6. DISTINCT: This will provides the unique values based on the col you mentioned*/

--get the unique contry names
SELECT DISTINCT country
FROM customers;

-- u can combine multiple col too for unique key here all the first_name+country combination was unique
SELECT DISTINCT country ,first_name
FROM customers;

/*NOTE: u have DISTINCT ON() also which will do the distinct which are under this bracket and for rest it will pick the first row based on the data ordered
 and in ORDER BY the cistinct on columns should match the order and should occur first if u r using the order by*/
SELECT DISTINCT ON (country) country, first_name, score
FROM customers
ORDER BY country, score DESC;--so this will pick the John, Georg and Martin


/*7. LIMIt: helps to get the few rows only in the resulting dataset*/

--get the top 3 scored countires
SELECT *
FROM customers
ORDER BY score DESC LIMIT 3;


/*Tip: you can use static elements also as data like*/

SELECT first_name, 'MALE' AS gender
FROM customers; --gener is a static column here we added