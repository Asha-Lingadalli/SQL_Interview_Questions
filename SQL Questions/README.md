
# SQL Joins with NULLs and Duplicates — Example Walkthrough

This document demonstrates how **INNER JOIN**, **LEFT JOIN**, **RIGHT JOIN**, and **FULL OUTER JOIN** work when the tables contain **duplicates and NULL values**.

---

## 📌 Table Setup

```sql
CREATE TABLE Table1 (value INT);

INSERT INTO Table1 (value) VALUES
(1), (1), (1),   -- 3 ones
(2), (2),        -- 2 twos
(NULL), (NULL),  -- 2 nulls
(3),             -- 1 three
(1), (1), (1), (1), (1);  -- 5 more ones

CREATE TABLE Table2 (value INT);

INSERT INTO Table2 (value) VALUES
(2),             -- 1 two
(2), (2),        -- 2 more twos
(NULL), (NULL),  -- 2 nulls
(4),             -- 1 four
(5),             -- 1 five
(6);             -- 1 six
```

### Data in **Table1**
```
1, 1, 1, 2, 2, NULL, NULL, 3, 1, 1, 1, 1, 1
```
(13 rows total)

### Data in **Table2**
```
2, 2, 2, NULL, NULL, 4, 5, 6
```
(8 rows total)

---

## 🔹 INNER JOIN

```sql
SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
INNER JOIN Table2 b
    ON a.value = b.value;
```

- Matches only **common values** (ignores NULL).  
- **Multiplication rule**: (# occurrences in Table1) × (# occurrences in Table2).

| Table1_value | Table2_value |
|--------------|--------------|
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| 5 | 5 |

✅ **Total = 11 rows**

---

## 🔹 LEFT JOIN

```sql
SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
LEFT JOIN Table2 b
    ON a.value = b.value;
```

- Keeps **all rows from Table1**.  
- Unmatched Table1 rows → `Table2_value = NULL`.  
- NULLs from Table1 never match.

| Table1_value | Table2_value |
|--------------|--------------|
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| NULL | NULL |
| NULL | NULL |
| 3 | NULL |
| 5 | 5 |

✅ **Total = 14 rows**

---

## 🔹 RIGHT JOIN

```sql
SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
RIGHT JOIN Table2 b
    ON a.value = b.value;
```

- Keeps **all rows from Table2**.  
- Unmatched Table2 rows → `Table1_value = NULL`.  
- NULLs from Table2 never match.

| Table1_value | Table2_value |
|--------------|--------------|
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| NULL | NULL |
| NULL | NULL |
| 5 | 5 |
| NULL | 4 |
| NULL | 6 |

✅ **Total = 15 rows**

---

## 🔹 FULL OUTER JOIN

```sql
SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
FULL OUTER JOIN Table2 b
    ON a.value = b.value;
```

- Keeps **all rows from both tables**.  
- Unmatched rows appear with NULLs on the other side.  
- NULLs never match each other.

| Table1_value | Table2_value |
|--------------|--------------|
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 1 | 1 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| 2 | 2 |
| 5 | 5 |
| NULL | NULL |
| NULL | NULL |
| 3 | NULL |
| NULL | 4 |
| NULL | 6 |

✅ **Total = 16 rows**

---

## 📝 Key Takeaways

- **INNER JOIN** → only matching rows, NULL never matches.  
- **LEFT JOIN** → all rows from left, unmatched → NULL on right.  
- **RIGHT JOIN** → all rows from right, unmatched → NULL on left.  
- **FULL OUTER JOIN** → all rows from both, unmatched → NULLs.  
- **Duplicates multiply matches** (`#left × #right`).  
- **NULL never equals NULL** in SQL joins.  

---

🚀 This example is a classic **SQL interview question** used to test your understanding of joins, duplicates, and NULL handling.
