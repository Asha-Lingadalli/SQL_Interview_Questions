Q2)select * from customer_orders

-- Drop table if exists (optional, for re-runs)
DROP TABLE IF EXISTS customer_orders;

-- Create table
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO customer_orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 101, '2025-09-01', 250.00),
(2, 102, '2025-09-02', 180.00),
(3, 103, '2025-09-02', 300.00),   -- same date as order_id 2
(4, 101, '2025-09-03', 150.00),   -- same customer_id as order_id 1
(5, 104, '2025-09-03', 220.00),   -- same date as order_id 4
(6, 105, '2025-09-04', 500.00),
(7, 102, '2025-09-05', 175.00),   -- repeat customer_id 102
(8, 106, '2025-09-05', 400.00),   -- same date as order_id 7
(9, 107, '2025-09-06', 320.00),
(10, 103, '2025-09-06', 280.00);  -- repeat customer_id 103

select * from customer_orders

--Q)Find new and repeatitive customers
-- order_date,new_customer_count,repeat_customer_count
-- "2025-09-01",1,0
-- 2025-09-02,2,0
-- "2025-09-03",1,1
-- "2025-09-04",1,0
-- "2025-09-05",1,1
-- "2025-09-06",1,1

--when was first order date happened by customer first customer
with first_visit as(
select customer_id, min(order_date) as first_visit_date 
from customer_orders
group by customer_id)

select co.order_date,
sum(case when co.order_date=fv.first_visit_date then 1 else 0 end) as first_visit_flag,
sum(case when co.order_date!=fv.first_visit_date then 1 else 0 end) as repeat_visit_flag
from customer_orders as co
inner join first_visit fv on co.customer_id =fv.customer_id
group by co.order_date;

--Output:

Order_date   first_visit_flag  repeat_visit_flag
"2025-09-04"	1	            0
"2025-09-02"	2	            0
"2025-09-05"	1	            1
"2025-09-03"	1	            1
"2025-09-06"	1	            1
"2025-09-01"	1	            0