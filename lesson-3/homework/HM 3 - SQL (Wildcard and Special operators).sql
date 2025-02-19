-- Homework 3: https://www.w3resource.com/sql-exercises/sql-wildcard-special-operators.php


-- 1. Salespeople from Paris or Rome
select salesman_id, name, city, commission from salesman
where city = 'Paris' or city = 'Rome'

-- 2. Salespeople in Paris or Rome
select salesman_id, name, city, commission from salesman
where city = 'Paris' or city = 'Rome'

-- 3. Salespeople Not in Paris or Rome
select salesman_id, name, city, commission from salesman
where not (city = 'Paris' or city = 'Rome')

-- 4. Customers with Specific IDs
select customer_id, cust_name, city, grade, salesman_id from customer
where customer_id in (3007, 3008, 3009);

select customer_id, cust_name, city, grade, salesman_id from customer
where customer_id = 3007 or customer_id = 3008 or customer_id = 3009;

-- 5. Salespeople with Commission 0.12-0.14
SELECT	salesman_id, name, city, commission FROM salesman
where commission between 0.12 and 0.14;

--6. Orders Between 500-4000 Excluding Specific Amounts
select 
  ord_no, 
  purch_amt, 
  ord_date, 
  customer_id, 
  salesman_id 
from 
  orders 
where 
  (
    purch_amt between 500 
    and 4000
  ) 
  and (
    purch_amt != 948.50 
    and purch_amt != 1983.43
  );
-- used code beautifier site to make the code above like that: https://codebeautify.org/sqlformatter


-- 7. Salespeople with Names N-O Range
select salesman_id, name, city, commission from salesman
where name between 'A' and 'L'

SELECT salesman_id, name, city, commission
FROM salesman
WHERE name LIKE 'B%'
   OR name LIKE 'C%'
   OR name LIKE 'D%'
   OR name LIKE 'E%'
   OR name LIKE 'F%'
   OR name LIKE 'G%'
   OR name LIKE 'H%'
   OR name LIKE 'I%'
   OR name LIKE 'J%'
   OR name LIKE 'K%';

-- 8. Salespeople with Names Not A-M Range
select salesman_id, name, city, commission from salesman
where name not between 'A' and 'M'

-- Customers with Names Starting with B
select customer_id, cust_name, city, grade, salesman_id from customer
where cust_name like 'B%'


--10. Customers with Names Ending with N
select customer_id, cust_name, city, grade, salesman_id from customer
where cust_name like '%n'


--11. Salespeople Name Starts 'N' with Fourth 'L'
select salesman_id, name, city, commission from salesman
where name like 'N%' and name like '___l%'

--12. Rows with Underscore Character
--CREATE TABLE testtable (
--    col1 VARCHAR(255)
--);

--INSERT INTO testtable (col1) VALUES
--('A001/DJ-402\\44_/100/2015'),
--('A001_\\DJ-402\\44_/100/2015'),
--('A001_DJ-402-2014-2015'),
--('A002_DJ-401-2014-2015'),
--('A001/DJ_401'),
--('A001/DJ_402\\44'),
--('A001/DJ_402\\44\\2015'),
--('A001/DJ-402%45\\2015/200'),
--('A001/DJ_402\\45\\2015%100'),
--('A001/DJ_402%45\\2015/300'),
--('A001/DJ-402\\44');

select * from testtable 
where col1 like '%/_%' escape '/'

-- 13. Rows Without Underscore Character
select * from testtable 
where col1 not like '%/_%' escape '/'

-- 14. Rows with Forward Slash Character
select * from testtable 
where col1 like '%1/%' escape '1'

-- 15. Rows Without Forward Slash Character
select * from testtable 
where col1 not like '%1/%' escape '1'

-- 16. Rows with '_/' String
select * from testtable 
where col1 like '%1_1/%' escape '1'

-- 17. Rows Without '_/' String
select * from testtable 
where col1 not like '%1_1/%' escape '1'

-- 18. Rows with Percent Character
select * from testtable 
where col1 like '%1%%' escape '1'

--19. Rows Without Percent Character
select * from testtable 
where col1 not like '%1%%' escape '1'

--20. Customers Without Grade
select customer_id, cust_name, city, grade, salesman_id from customer
where grade is null;

-- 21. Customers With Grade
select customer_id, cust_name, city, grade, salesman_id from customer
where grade is not null;

--22. Employees with Last Name Starting 'D'
select emp_idno, emp_fname, emp_lname, emp_dept from emp_details
where emp_lname like 'D%'

-- completed :)