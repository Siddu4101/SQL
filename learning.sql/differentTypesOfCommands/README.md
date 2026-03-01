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

### SOME IMPORTANT POINTS

> ⚡ **Why is `TRUNCATE` often faster than `DELETE`?**
> - **`DELETE`** 🧹
>   - Removes rows **one by one**.
>   - Logs **each row deletion** in the Write-Ahead Log (WAL).
>   - Can be **selective** using a `WHERE` clause.
>   - Fully **transactional** (can be rolled back) in most databases.
>
> - **`TRUNCATE`** 🪓
>   - **Deallocates whole data pages** instead of deleting row-by-row.
>   - Basically **resets metadata** (like storage pages and identity/sequence restart).
>   - Uses **minimal logging**.
>   - **Not selective** – it always affects the **entire table**.
>
> 🧩 **Why is `TRUNCATE` considered DDL, not DML?**
> - Even though it **removes data**, `TRUNCATE` works by **manipulating table metadata** (data pages, sequences, etc.).
> - Because it changes the **structure/metadata** level rather than operating row-by-row, it is classified as **DDL** (Data Definition Language), not DML.
>
> 🧾 **Transactional behavior in different databases**
> - In many databases like **MySQL** and **Oracle**, most **DDL statements** are:
>   - **Auto-committed** / not part of a transaction, and
>   - Generally **not rollbackable** (non-transactional).
>
> - In **PostgreSQL**, almost all **DDL is transactional**:
>   - DDL like `TRUNCATE`, `CREATE TABLE`, `ALTER TABLE`, `DROP TABLE`, `INSERT`, `UPDATE`, `DELETE`, etc., can be part of a transaction and **rolled back**.
>   - Some cluster-level commands are exceptions (not fully transactional), for example:
>     - `VACUUM`
>     - `CREATE DATABASE` / `DROP DATABASE`
>     - `CREATE TABLESPACE` / `DROP TABLESPACE`
>
> 💡 **Rule of thumb (PostgreSQL)**
> - If the command is **database-level** (operating inside a single database), it is **usually transactional**.
> - If it is **cluster-level** (affecting the whole server/cluster), it may **not be fully transactional**.
