# SELECT Query Clauses

In this section, we’ll explore the most common SELECT query clauses with clear examples you can copy and run.

Data source:
- [customerAndOrderInit.sql](./source/customerAndOrderInit.sql)
- A sample database, schema, tables, and dummy data were created using the above script.

---
Queries: [clauses.sql](./clauses.sql) 
## 1) SELECT — choose columns 📋

Select all columns:
```sql
SELECT *
FROM customers;
```

Select specific columns:
```sql
SELECT first_name, country
FROM customers;
```

---

## 2) WHERE — filter rows 🔎

Filter by a condition:
```sql
-- Get first_name of customers from the USA
SELECT first_name
FROM customers
WHERE country = 'USA';
```

---

## 3) ORDER BY — sort results 🔽🔼

Sort ascending by score (default ASC):
```sql
SELECT *
FROM customers
ORDER BY score;
```

Sort descending by id:
```sql
SELECT *
FROM customers
ORDER BY id DESC;
```

Sort by multiple columns (country ASC, then score DESC):
```sql
SELECT *
FROM customers
ORDER BY country ASC, score DESC;
```

---

## 4) GROUP BY — aggregate by columns 📊

Each non-aggregated column in SELECT must appear in GROUP BY.

Total score per country:
```sql
SELECT country, SUM(score) AS total_score
FROM customers
GROUP BY country;
```

Total score and number of customers per country:
```sql
SELECT country, SUM(score) AS total_score, COUNT(id) AS total_customer
FROM customers
GROUP BY country;
```

---

## 5) HAVING — filter aggregated results 🎯

Use HAVING to filter after aggregation (WHERE filters before aggregation).

Countries with total_score > 800:
```sql
SELECT country, SUM(score) AS total_score
FROM customers
GROUP BY country
HAVING SUM(score) > 800;
```

Note:
- WHERE applies before aggregation.
- HAVING applies after aggregation and can reference aggregate functions.

Q: Average score per country, excluding zero scores, and keep only avg > 430:
```sql
SELECT country, AVG(score) AS avg_score
FROM customers
WHERE score <> 0
GROUP BY country
HAVING AVG(score) > 430;
```

---

## 6) DISTINCT — unique values 🧩

Unique country names:
```sql
SELECT DISTINCT country
FROM customers;
```

Unique combinations of country + first_name:
```sql
SELECT DISTINCT country, first_name
FROM customers;
```

Distinct on specific columns (PostgreSQL): pick one row per country, highest score first:

NOTE: also which will do the distinct which are under this bracket and for rest it will pick the first row based on the data ordered
and in ORDER BY the cistinct on columns should match the order and should occur first if u r using the order by
```sql
SELECT DISTINCT ON (country) country, first_name, score
FROM customers
ORDER BY country, score DESC; -- ensures the top (highest score) per country
```

---

## 7) LIMIT — restrict row count ✂️

Top 3 customers by score:
```sql
SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;
```

---

## Tip — static values in SELECT 🧠

Add a literal value as a column:
```sql
SELECT first_name, 'MALE' AS gender
FROM customers; -- gender is a static column here
```
