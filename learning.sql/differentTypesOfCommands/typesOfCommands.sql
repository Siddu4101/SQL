/*DDL: Data Definition Language helps to create or update or destroy the table structures*/

/*CREATE*/
-- create a simple table
CREATE TABLE IF NOT EXISTS persons(
id INT NOT NULL, --u can pass the PRIMARY KEY to make this primary key if u want to avoid the below constaint extra line
person_name VARCHAR(20) NOT NULL,
birth_date DATE,
phone VARCHAR(15),
CONSTRAINT pk_persons PRIMARY KEY (id)
);


/*ALTER:*/

--add new column email to the above table

ALTER TABLE persons ADD COLUMN email VARCHAR(20);

--make the email column as not null
ALTER TABLE persons ALTER COLUMN email SET NOT NULL ;

--remove the phone column from the table
ALTER TABLE persons DROP COLUMN phone;


/*DROP:*/
DROP TABLE persons;



/*DML:(Data Manipulation Language)*/

/*INSERT*/

--1. insert via insert statements with values

INSERT INTO customers(id,first_name,country,score)
VALUES
(6,'Thanh', 'Paris', 300),
(7,'Bayero', 'Paris', 1000);

--we can avoid the col names if we are following the order of the col with all the col values
INSERT INTO customers
VALUES (8,'Teo', 'Paris', 200);

-- if u want to skip some columns while insertion(should be NULL aloud cols) u can mention the column names foe which u want to insert
INSERT INTO customers (id,first_name)
VALUES (9, 'Francine');


--2. insert from another table as a select query
--here the source and destination datatype must match to insert no need of exact match of the col names
INSERT INTO  persons(id, person_name, birth_date, phone)
SELECT id, first_name, NULL, '123-456-789' FROM customers;

/*UPDATE*/
--update the customer 9 country to France and the score to 800
UPDATE customers SET country = 'France', score=800
WHERE id = 9; --make sure to add where clause else it updates all row

/*DELETE*/
--delete rows from the customer which have id > 5
DELETE FROM customers WHERE id > 5; --if we miss the where clause it deletes all the rows

--delete all rows u can use DELETE without any WHERE clause but it takes more time compared to TRUNCATE
TRUNCATE persons;

/*NOTE: why TRUNCATE is better than DELETE ?
DELETE: Removes rows one by one Logs each row deletion (WAL logging) can be rolled back row-by-row and we can delete specific scope via where clause
TRUNCATE: Does not delete rows individually deallocates the entire table data pages minimal logging but it can't do selective scope deletion it removes whole data
 */