-- Homework 2: https://www.w3resource.com/sql-exercises/sql-boolean-operators.php


-- 1. Customers with Grade > 100
--create table customer (
--	customer_id INT PRIMARY KEY
--	,cust_name varchar(100) NOT NULL
--	,city varchar (50) NOT NULL
--	,grade INT
--	,salesman_id INT NOT NULL
--	)


--INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id) VALUES
--(3002, 'Nick Rimando', 'New York', 100, 5001),
--(3007, 'Brad Davis', 'New York', 200, 5001),
--(3005, 'Graham Zusi', 'California', 200, 5002),
--(3008, 'Julian Green', 'London', 300, 5002),
--(3004, 'Fabian Johnson', 'Paris', 300, 5006),
--(3009, 'Geoff Cameron', 'Berlin', 100, 5003),
--(3003, 'Jozy Altidor', 'Moscow', 200, 5007),
--(3001, 'Brad Guzan', 'London', NULL, 5005);

-- Solution
SELECT customer_id, cust_name, city, grade, salesman_id from customer
where grade > 100

-- 2. New York Customers with Grade > 100
select customer_id, cust_name, city, grade, salesman_id from customer
where city = 'New York' and grade >100

--3. New York or Grade > 100
select customer_id, cust_name, city, grade, salesman_id from customer
where city = 'New York' or grade >100


-- 4. New York or Not Grade > 100
select customer_id, cust_name, city, grade, salesman_id from customer
where city = 'New York' or not grade >100


-- 5. Not New York and Not Grade > 100
select customer_id, cust_name, city, grade, salesman_id from customer
where city != 'New York' and not grade >100


-- 6. Exclude Specific Orders

--CREATE TABLE orders (
--    ord_no INT PRIMARY KEY,
--    purch_amt DECIMAL(10,2) NOT NULL,
--    ord_date DATE NOT NULL,
--    customer_id INT NOT NULL,
--    salesman_id INT NOT NULL
--);

--INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
--(70001, 150.50, '2012-10-05', 3005, 5002),
--(70009, 270.65, '2012-09-10', 3001, 5005),
--(70002, 65.26, '2012-10-05', 3002, 5001),
--(70004, 110.50, '2012-08-17', 3009, 5003),
--(70007, 948.50, '2012-09-10', 3005, 5002),
--(70005, 2400.60, '2012-07-27', 3007, 5001),
--(70008, 5760.00, '2012-09-10', 3002, 5001),
--(70010, 1983.43, '2012-10-10', 3004, 5006),
--(70003, 2480.40, '2012-10-10', 3009, 5003),
--(70012, 250.45, '2012-06-27', 3008, 5002),
--(70011, 75.29, '2012-08-17', 3003, 5007),
--(70013, 3045.60, '2012-04-25', 3002, 5001);


-- Solution
select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders
WHERE not ((ord_date = '2012-09-10' and salesman_id > 5005) or purch_amt > 1000.00)


-- 7. Salespeople with Commission Range 0.10-0.12
--CREATE TABLE salesman (
--    salesman_id INT PRIMARY KEY,
--    name VARCHAR(100) NOT NULL,
--    city VARCHAR(50) NOT NULL,
--    commission DECIMAL(4,2) NOT NULL
--);
--INSERT INTO salesman (salesman_id, name, city, commission) VALUES
--(5001, 'James Hoog', 'New York', 0.15),
--(5002, 'Nail Knite', 'Paris', 0.13),
--(5005, 'Pit Alex', 'London', 0.11),
--(5006, 'Mc Lyon', 'Paris', 0.14),
--(5007, 'Paul Adam', 'Rome', 0.13),
--(5003, 'Lauson Hen', 'San Jose', 0.12);


-- solution
select salesman_id, name, city, commission from salesman
where commission > 0.10 and commission < 0.12

--8. Orders with Amount < 200 or Exclusions
select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders
where purch_amt < 200 or not (ord_date >= '2012-02-10' and customer_id < 3009)

-- 9. Conditional Orders Exclusions
select * from orders
where not (ord_date = '2012-08-17' or customer_id > 3005 and purch_amt<1000.00)

-- 10. Orders with Achieved Percentage > 50%
select 
	ord_no
	,purch_amt
	,((purch_amt / 6000) * 100) AS 'achieved%'
	,(100 - (purch_amt / 6000) * 100) AS 'unachieved%'
from 
	orders
where (purch_amt / 6000) * 100 > 50


--11. Employees with Last Name Dosni or Mardy
select emp_idno, emp_fname, emp_lname, emp_dept from emp_details
where EMP_LNAME = 'Dosni' or EMP_LNAME = 'Mardy'

-- 12. Employees in Department 47 or 63
select emp_idno, emp_fname, emp_lname, emp_dept from emp_details
where EMP_DEPT = 47 or EMP_DEPT = 63

done :)

