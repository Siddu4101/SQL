# 🗂️ SQL Command Types: DDL, DML


---
Queries: [Types of Commands](./typesOfCommands.sql)

## DDL — Data Definition Language 🧱
Defines and changes database structures like tables and columns.

### CREATE — make a table ➕
```sql
-- Create a simple table (id as PRIMARY KEY)
CREATE TABLE IF NOT EXISTS persons (
  id INT NOT NULL, -- you can inline PRIMARY KEY here if you prefer and remove below constraint
  person_name VARCHAR(20) NOT NULL,
  birth_date DATE,
  phone VARCHAR(15),
  CONSTRAINT pk_persons PRIMARY KEY (id)
);
```

### ALTER — change a table ✏️
```sql
-- Add a new column 'email'
ALTER TABLE persons ADD COLUMN email VARCHAR(20);

-- Make 'email' NOT NULL
ALTER TABLE persons ALTER COLUMN email SET NOT NULL;

-- Remove 'phone' column
ALTER TABLE persons DROP COLUMN phone;
```

### DROP — remove a table 🗑️
```sql
-- Drop the table completely
DROP TABLE persons;
```

---

## DML — Data Manipulation Language 🧪
Inserts, updates, and deletes data in tables.

### INSERT — add rows ➕
```sql
-- 1) Insert explicit values with column list
INSERT INTO customers (id, first_name, country, score)
VALUES
  (6, 'Thanh', 'Paris', 300),
  (7, 'Bayero', 'Paris', 1000);

-- 2) We can avoid the col names if we are following the order of the col in the table with all the col values
INSERT INTO customers
VALUES (8, 'Teo', 'Paris', 200);

-- 3) Insert partial columns (others must allow NULL or have defaults)
INSERT INTO customers (id, first_name)
VALUES (9, 'Francine');
```

### INSERT FROM SELECT — copy from another table 📋➡️📋
```sql
-- Source and destination data types must be compatible no need of column name match
INSERT INTO persons (id, person_name, birth_date, phone)
SELECT id, first_name, NULL, '123-456-789'
FROM customers;
```

### UPDATE — modify existing rows 🛠️
```sql
-- Update customer 9 to France and score 800
UPDATE customers
SET country = 'France', score = 800
WHERE id = 9; -- Always use WHERE, or all rows will be updated
```

### DELETE — remove rows 🧹
```sql
-- Delete customers where id > 5
DELETE FROM customers
WHERE id > 5; -- Without WHERE, all rows are deleted
```

### TRUNCATE — fast full table cleanup ⚡
```sql
-- Quickly remove all rows from 'persons'
TRUNCATE persons;
```

> 🔥 Note: Why TRUNCATE can be faster than DELETE?
> - DELETE: removes row-by-row, logs each deletion (WAL), can be selective via WHERE, and is fully transactional.
> - TRUNCATE: deallocates table data pages, minimal logging, cannot be selective (affects the whole table). 
