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

