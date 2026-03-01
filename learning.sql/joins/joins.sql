/*BASIC JOINS*/

/*1. No Join: just return the data from each table individually*/

SELECT *
FROM customers;

SELECT *
FROM orders;

/*2. Inner Join: brings the data which is common in both */
--select all the customers how hav atleast 1 order made
SELECT c.first_name, o.order_id ,o.sales
FROM customers c
JOIN orders o ON c.id = o.customer_id; --by default the join INNER u can mention it explicitely

/*3. Left Join: brings all the data from the left and matching data from right and if no match NULL for those right table col*/
--get all the customers who may or may not have any order
SELECT c.first_name, o.order_id, o.sales
FROM customers c
LEFT JOIN orders o
ON c.id  = o.customer_id;

/*4. Right Join: brings all the data from the right and matching data from left and if no match NULL for those left table col*/
--get all the orders who may or may present in customer
SELECT c.first_name, o.order_id, o.sales
FROM customers c
RIGHT JOIN orders o
ON c.id  = o.customer_id;

/*5. Full Join: gets all the data from both the tables if record is not matching it will be NULL*/
--get all the customers adnd orders even if there is no match
SELECT c.first_name,o.order_id, o.sales
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id ;

/*ADVANCE JOINS*/
--NOTE: for anti joins we don't have any special keyword we need to adjust the where clause with basic left or right or full joins

/*1.Left Anti Join: the data which is not matching with the right table*/
--get all the customers who don't have any orders
SELECT c.first_name, o.order_id, o.sales
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL; --all the left table data where right table don't have entry

/*2.Right Anti Join: the data which is not matching with the left table*/
--get all the orders which don't have valid customers in customers table
SELECT c.first_name, o.order_id, o.sales
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id  IS NULL; --all the right table data where left table don't have entry

/*3. Full Anti Join: the data which is either not matching with each other*/
--det all the customers and the orders which don't have corresponding valid entry in other
SELECT c.first_name, o.order_id, o.sales
FROM customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id  IS NULL OR c.id IS NULL;

/*4. Cross/Cartetian Join: The join which joins each entry with each entry in another table*/

SELECT c.first_name, o.order_id, o.sales
FROM customers c
CROSS JOIN orders o ; --this joins don't need any matching key

--multijoin example
/*Q: Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product,
and employee details with fieldsOrder ID, Customer's name, Product name, Sales, Price, Sales person's name */

SELECT so.order_id, sc.firstname customer_name, sp.product, so.sales, sp.price, se.first_name sales_person  FROM sales_orders so
LEFT JOIN sales_customers sc ON sc.customer_id = so.customer_id
LEFT JOIN sales_products sp ON sp.product_id = so.product_id
LEFT JOIN sales_employee se ON se.employee_id = so.sales_person_id


/* SET OPERATIONS*/
--1. UNION: all the distinct rows from both the selects

--Q: Combine the data from the employee and customers of sales considering no duplicates
-- we have 2 rows duplicated Kevin and Mary with same id and name in both the tables now in the result we will have single entry
SELECT sc.firstname name ,sc.customer_id  id -- the col names comes from the first select
FROM sales_customers sc --can have extra clauses like join, where, group by etc... in each select

UNION -- UNION by default remoed the duplicate rows

SELECT se.first_name , se.employee_id --datatype must be compatible and number of col must match and position of both selects too
FROM sales_employee se

ORDER BY id; --order by should be used only once that too at the end


--2. UNION ALL: all rows including the duplicates from both the selects
--Q: Combine the data from the employee and customers of sales including the duplicates
-- we have 2 rows duplicated Kevin and Mary with same id and name in both the tables now in the result we will dupicate entry too

SELECT sc.firstname name ,sc.customer_id  id
FROM sales_customers sc

UNION ALL-- UNION ALL keeps all rows including duplicates

SELECT se.first_name , se.employee_id
FROM sales_employee se

--NOTE: UNION ALL is faster than the UNION as it don't removes the duplicate


--3. EXCEPT:(minus(-)) returns the distinct rows result from the first select which are not present in second select

--select all the customers who are not the employees at the same time
--kevin and mary are employees along with customers so they have removed
SELECT sc.firstname name ,sc.customer_id  id
FROM sales_customers sc

EXCEPT -- EXCEPT keeps only from first which are not present in second

SELECT se.first_name , se.employee_id
FROM sales_employee se

--NOTE: here order does matters the first select minus second one so u will get the different results when u inverse them

--4. INTERSECT:(opposite of EXCEPT) here it returns distinct data which is common

--select customers who are employees at the same time
-- kevin and mary are the only 2 who are both customers and employees at the same time
SELECT sc.firstname name ,sc.customer_id  id
FROM sales_customers sc

INTERSECT -- INTERSECT keeps the common rows between 2 selects but result will be distinct

SELECT se.first_name , se.employee_id
FROM sales_employee se

--NOTE: we have EXCEPT ALL and INTERSECT ALL to not much used but they are helpful when u have the duplicate data in first and second select
-- based on the number of times duplicated in between these 2 selects it removes(minus) the entries
--EX: EXCEPT ALL: count based first select count - second select count (if second select count is greater result is 0 rows)
(
  SELECT 1
  UNION ALL
  SELECT 1
  UNION ALL
  SELECT 1
)
EXCEPT ALL
(
  SELECT 1
  UNION ALL
  SELECT 1
); --gives single 1 as result as used the paranthesis else gives three 1 as it evaluates left to right(3 time once - 2 time once = 1 time once)

SELECT 1
UNION ALL
SELECT 1
UNION ALL
SELECT 1
EXCEPT ALL
SELECT 1
UNION ALL
SELECT 1; --gives three 1's ( 3 times once - 1 time once + 1 time once = 3)

--EX: INTERSECT ALL: based on count keeps the MIN(count from the both the select)
(SELECT 1
UNION ALL
SELECT 1
UNION ALL
SELECT 1)

INTERSECT ALL

(SELECT 1
UNION ALL
SELECT 1);--keeps 2 once as (min(3,2) =  2)


SELECT 1
UNION ALL
SELECT 1
UNION ALL
SELECT 1
INTERSECT ALL
SELECT 1
UNION ALL
SELECT 1;-- gives 4 once as INTERSECT ALL has precedence ( 1 intesect all 1 = 1 + then rest 3 union = 4 times 1's)




