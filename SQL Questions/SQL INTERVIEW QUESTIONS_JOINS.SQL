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

--Tell me the output of all the 4 query written using joins

SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
INNER JOIN Table2 b
    ON a.value = b.value;

Table1 values: 1,1,1,2,2,NULL,NULL,3,5
Table2 values: 1,1,2,2,NULL,NULL,4,5,6
Matching values (excluding NULLs):
1 → appears 3 times in Table1, 2 times in Table2 → 3×2 = 6 rows
2 → appears 2 times in Table1, 2 times in Table2 → 2×2 = 4 rows
5 → appears 1 time in Table1, 1 time in Table2 → 1×1 = 1 row
NULLs never match, so no rows for NULL.
3 (Table1 only) and 4,6 (Table2 only) → not include

| Table1\_value | Table2\_value |
| ------------- | ------------- |
| 1             | 1             |
| 1             | 1             |
| 1             | 1             |
| 1             | 1             |
| 1             | 1             |
| 1             | 1             |
| 2             | 2             |
| 2             | 2             |
| 2             | 2             |
| 2             | 2             |
| 5             | 5             |

Total =11 ROWS

SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
LEFT JOIN Table2 b
    ON a.value = b.value;

Table1 values: 1,1,1,2,2,NULL,NULL,3,5
Table2 values: 1,1,2,2,NULL,NULL,4,5,6
LEFT JOIN keeps all rows from Table1.
If Table1 value matches Table2 → show Table2 value.
If Table1 value has no match in Table2 → Table2_value = NULL.
Duplicates multiply for matches.

| Table1\_value | Table2\_value |                                                       |
| ------------- | ------------- | ----------------------------------------------------- |
| 1             | 1             |                                                       |
| 1             | 1             |                                                       |
| 1             | 1             |                                                       |
| 1             | 1             |                                                       |
| 1             | 1             |                                                       |
| 1             | 1             | ← all 6 matches for 1                                 |
| 2             | 2             |                                                       |
| 2             | 2             |                                                       |
| 2             | 2             |                                                       |
| 2             | 2             | ← all 4 matches for 2                                 |
| NULL          | NULL          | ← NULL in Table1, matches none → Table2\_value = NULL |
| NULL          | NULL          | ← same                                                |
| 3             | NULL          | ← no match in Table2                                  |
| 5             | 5             | ← match                                               |

Total = 14 rows


SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
RIGHT JOIN Table2 b
    ON a.value = b.value;

Table1 values: 1,1,1,2,2,NULL,NULL,3,5
Table2 values: 1,1,2,2,NULL,NULL,4,5,6
RIGHT JOIN keeps all rows from Table2.
If Table2 value matches Table1 → show Table1 value.
If Table2 value has no match in Table1 → Table1_value = NULL.
Duplicates multiply for matches.

| Table1\_value | Table2\_value |                                                   |
| ------------- | ------------- | ------------------------------------------------- |
| 1             | 1             |                                                   |
| 1             | 1             |                                                   |
| 1             | 1             |                                                   |
| 1             | 1             |                                                   |
| 1             | 1             |                                                   |
| 1             | 1             | ← 6 rows for 1 (matches Table1)                   |
| 2             | 2             |                                                   |
| 2             | 2             |                                                   |
| 2             | 2             |                                                   |
| 2             | 2             | ← 4 rows for 2                                    |
| NULL          | NULL          | ← NULL in Table2, no match → Table1\_value = NULL |
| NULL          | NULL          | ← same                                            |
| 5             | 5             | ← match                                           |
| NULL          | 4             | ← no match in Table1 → Table1\_value = NULL       |
| NULL          | 6             | ← no match in Table1 → Table1\_value = NULL       |

Total = 15 rows


SELECT a.value AS Table1_value, b.value AS Table2_value
FROM Table1 a
FULL OUTER JOIN Table2 b
    ON a.value = b.value;

Table1 values: 1,1,1,2,2,NULL,NULL,3,5
Table2 values: 1,1,2,2,NULL,NULL,4,5,6
FULL OUTER JOIN keeps all rows from both tables.
Matches multiply if duplicates exist.
Unmatched Table1 rows → Table2_value = NULL
Unmatched Table2 rows → Table1_value = NULL
NULLs never match each other.

| Table1\_value | Table2\_value |                                                         |
| ------------- | ------------- | ------------------------------------------------------- |
| 1             | 1             |                                                         |
| 1             | 1             |                                                         |
| 1             | 1             |                                                         |
| 1             | 1             |                                                         |
| 1             | 1             |                                                         |
| 1             | 1             | ← 6 rows for 1                                          |
| 2             | 2             |                                                         |
| 2             | 2             |                                                         |
| 2             | 2             |                                                         |
| 2             | 2             | ← 4 rows for 2                                          |
| 5             | 5             | ← 1 row for 5                                           |
| NULL          | NULL          | ← NULLs from Table1, not matched → Table2\_value = NULL |
| NULL          | NULL          | ← same                                                  |
| 3             | NULL          | ← 3 from Table1, no match                               |
| NULL          | 4             | ← 4 from Table2, no match                               |
| NULL          | 6             | ← 6 from Table2, no match                               |

Total = 16 rows