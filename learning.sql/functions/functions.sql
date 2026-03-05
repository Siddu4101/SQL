/*SQL FUNCTIONS*/

--1.single row functions
--a.String functions
--i. CONCAT: to combine multiple string values into one single value

-- get the full names of the sales customers
SELECT concat(sc.firstname, ' ', sc.lastname) full_name FROM sales_customers sc;

--u can also use the doublle pipe(||) to do this but if any value is null whole result becomes null and don't have the auto type conversion
--so prefered to use the concat() method
SELECT sc.firstname ||' '|| sc.lastname  full_name FROM sales_customers sc;

--ii. UPPER: converts any case string to UPPER case

-- print the first_name of all customers in capital letters
SELECT upper(firstname) FROM sales_customers sc ;

--iii. LOWER: converts any case string to LOWER case

-- print the first_name of all customers in small letters
SELECT lower(firstname) FROM sales_customers sc ;

--iv.TRIM: Removes the only the trialling and leading space from the string

--identify the customers who have trialling or the leading space in firstname
SELECT first_name FROM customers c
WHERE c.first_name <> trim(c.first_name);--john has the leading space in his name

--v. REPLACE: to replace a perticular substring with some other string

--replace the '-' by '/' in the phone number
SELECT '123-456-789' phone_number, REPLACE('123-456-789', '-','/') replaced_phone_number;--123/456/789
--for multi character replacement
SELECT '123-456-789' phone_number, REPLACE('123-456-789', '789','00') replaced_phone_number; --123-456-00
--note: u can use the replace for remove also via new char as empty string
SELECT '123-456-789' phone_number, REPLACE('123-456-789', '-','') replaced_phone_number; --123456789

--vi. LENGTH: returns the length of the col can be applied to string, and bytea for others u need casting..
SELECT length('abcde'::bytea);
SELECT length('abcde');
SELECT length(text('20251231'::date));--casting is needed here

--vii. LEFT: extracts the substring starting from left to number of characters mentiond

--get the first 3 char from thr fistname of the sales customers
SELECT firstname, left(firstname,3) FROM sales_customers sc ;

--viii. RIGHT: extracts the substring starting from right to number of characters mentiond

--get the last 3 char from thr fistname of the sales customers
SELECT firstname, right(firstname,3) FROM sales_customers sc ;

--ix: SUBSTRING: to get the specific substring from a string which takes start position and the number
-- of characters u need from there(invlusie for both start and number of characters needed)

--get the substring from position 2 to next 3 characters from sales customers first_name
SELECT sc.firstname , substring(sc.firstname, 2, 3) FROM sales_customers sc ;

--get the substring from position 2 to end of the firstname
SELECT sc.firstname, substring(sc.firstname,2,length(firstname)-2+1) FROM sales_customers sc ;--even u can just keep the length(firstname) as if u give greater number it is not issue

--b. Number funtions:

--i: ROUND: which will round the number to specific decimal points

SELECT 3.516 number,
round(3.516, 2) number_round_2_decimal,--3.52
round(3.516, 1) number_round_1_decimal,--3.5
round(3.516) number_round_0_decimal;--4

--ii. ABS: absolute value of any number negates the negative to positive

SELECT -10 negative_num,
abs(-10) absolute_number;


--c. Date and Time functions

--i. extract date and time components: to extract the respective part from a date or datetime
SELECT so.creation_time,
extract(DAY FROM so.creation_time) AS DAY,
extract(MONTH FROM so.creation_time) AS MONTH,
extract(YEAR FROM so.creation_time) AS YEAR,
extract(HOUR FROM so.creation_time) AS HOUR,
extract(MINUTE FROM so.creation_time) AS MINUTE,
extract(SECOND FROM so.creation_time) AS SECOND
FROM sales_orders so;

--ii. date_part(compoent_to_be_extracted, actual_datetime): this can do the same think which is done by extract but can provide
--some extra info like week, quarter, etc...

SELECT so.creation_time,
date_part('day', so.creation_time) AS  DAY,
date_part('hour', so.creation_time) AS  HOUR,
date_part('week', so.creation_time) AS WEEK,
date_part('quarter', so.creation_time) AS QUARTER
FROM sales_orders so;


--iii. to_char(actual_datetime, compoent_to_be_extracted): this can do the same think which above 2 done but change is here the return datatype
-- is string in above 2 cases it is int which are always numbers here we get names in string ex month-> March
 SELECT so.creation_time,
to_char(so.creation_time,'day') AS DAY,
to_char(so.creation_time, 'month') AS MONTH,
to_char(so.creation_time,'yyyy') AS YEAR,
to_char(so.creation_time, 'hh') AS HOUR,
to_char(so.creation_time, 'q') AS quarter
FROM sales_orders so;

--iv.date_trunc: this will helps to reset part of the datetime example if u choose the minute then after minute things will be reseted
-- if it is time then set to 00 if it is date or month reset to 01 if u set as day whole time component reset to 00
SELECT so.creation_time,
date_trunc('day', so.creation_time) day_date_trunc,
date_trunc('hour', so.creation_time) hour_date_trunc,
date_trunc('month', so.creation_time) month_date_trunc
FROM sales_orders so ;

--get the first day of all the creation dates of that month
SELECT so.creation_time, date_trunc('month', so.creation_time) startOfTheMonth FROM sales_orders so;

--note: This is helpful when u have the data as timestamp level but want to group by day or month ect..
--get the total orders for each month

SELECT count(*), date_trunc('month', so.creation_time) AS month FROM sales_orders so
GROUP BY date_trunc('month', so.creation_time);

--some simple questions
--Q1. number of orders placed for each year
SELECT count(*), EXTRACT(YEAR FROM so.order_date) AS year FROM sales_orders so GROUP BY EXTRACT(YEAR FROM so.order_date);

--Q2. number of orders placed for each month
SELECT count(*), to_char(so.order_date,'month') AS month FROM sales_orders so  GROUP BY to_char( so.order_date,'month');

--Q3. show all the orders that were placed in Feb
SELECT * FROM sales_orders so  WHERE extract(MONTH FROM so.order_date) = 2;

--v. cast: to convert one datatype to another(if it is compatiable)
-- u can use the '::' or the cast method to do that

SELECT cast(123 AS text) AS "number as text",
cast(123 AS int) AS "number as int",
cast('20241231' AS text) AS "date as text",
cast('20241231' AS date) AS "date as date",
so.creation_time,
cast(so.creation_time  AS date) AS "creation time as date"
FROM sales_orders so ;

SELECT 123::text AS "number as text",
123::int AS "number as int",
'20241231'::text AS "date as text",
'20241231'::date AS "date as date",
so.creation_time,
so.creation_time::date "creation time as date"
FROM sales_orders so;

--vi. INTERVAL: used as a datatype for duration of time like 1 day 2 hours etc.. and it can be used for the addition and substraction of date or the time on the
--date or time ot datetime component. and we can do multiple components at once for add ot substract
SELECT so.order_date,
so.order_date - INTERVAL '10 days' AS before_10_days_of_order_date,
so.order_date - INTERVAL '4 hours' AS before_4_hours_of_order_date,
so.order_date + INTERVAL '2 years' AS after_2_years_of_order_date,
so.order_date + INTERVAL '2 days 2 months 2 years' AS after_2_D_2_M_2_Y_of_order_date --multi date additions
FROM sales_orders so;

--vii. AGE: which takes 2 date or time or datetime component to cal the difference
SELECT so.order_date, age(so.order_date, '20251231'::date)order_date_from_2024_EOY FROM sales_orders so;

--Q find the shipping duration of the orders
SELECT so.order_id, so.order_date, age(so.ship_date , so.order_date ) duration_of_the_order FROM sales_orders so;

--Q: get the average order duration for each month
SELECT date_part('month',so.order_date) AS MONTH, avg(age(so.ship_date, so.order_date)) FROM sales_orders so GROUP BY date_part('month',so.order_date);



