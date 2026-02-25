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


