/*Filtering the Data*/

/*
 Here we have 5 types
 1. Comparison operator (=, != or <>, >, <, >=, <=)
 2. Logical operator(AND, OR, NOT)
 3. Range operator(BETWEEN)
 4. Membership comparison (IN, NOT IN)
 5. Matching operator(LIKE with %(any match) _(specific number of letters match))
 * */

/*1. Comparison*/
SELECT * FROM customers  WHERE score <> 900;

/*2. Logical*/
SELECT * FROM customers WHERE score <> 900 AND country <> 'Germany';

/*3. Range*/
SELECT * FROM customers WHERE score BETWEEN 0 AND 500;

/*4. Membership*/
SELECT * FROM customers WHERE score NOT IN (900, 350);

/*5. LIKE*/
-- select name where we have 3rd character as 'i' and and rest can be any number of chars
SELECT * FROM customers WHERE first_name LIKE '__r%';

/*NOTE: ILIKE postgres supports case ignorant like command*/
SELECT * FROM customers WHERE first_name LIKE 'mar%'; --no result
SELECT * FROM customers WHERE first_name ILIKE 'mar%'; --2 rows Maria and Martin