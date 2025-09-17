# Customer Orders Analysis (SQL Practice)

## 📌 Overview
This project demonstrates how to analyze **customer order behavior** using SQL.  
We create a sample `customer_orders` table, insert data, and write queries to identify **new vs. repeat customers** on each order date.

---

## 🛠️ Topics Covered
- Creating tables (`CREATE TABLE`)
- Dropping tables (`DROP TABLE IF EXISTS`)
- Inserting sample data (`INSERT INTO`)
- Common Table Expressions (**CTEs**)
- Aggregations (`SUM`, `GROUP BY`)
- Conditional aggregation using `CASE WHEN`
- Identifying **new vs. repeat customers**

---

## 📂 Table Schema
**Table: `customer_orders`**

| Column       | Data Type       | Description                       |
|--------------|-----------------|-----------------------------------|
| order_id     | INT (PK)        | Unique order identifier           |
| customer_id  | INT             | Unique customer identifier        |
| order_date   | DATE            | Date of the order                 |
| order_amount | DECIMAL(10,2)   | Total amount of the order         |

---

## 📥 Sample Data
```sql
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 101, '2025-09-01', 250.00),
(2, 102, '2025-09-02', 180.00),
(3, 103, '2025-09-02', 300.00),
(4, 101, '2025-09-03', 150.00),
(5, 104, '2025-09-03', 220.00),
(6, 105, '2025-09-04', 500.00),
(7, 102, '2025-09-05', 175.00),
(8, 106, '2025-09-05', 400.00),
(9, 107, '2025-09-06', 320.00),
(10, 103, '2025-09-06', 280.00);
