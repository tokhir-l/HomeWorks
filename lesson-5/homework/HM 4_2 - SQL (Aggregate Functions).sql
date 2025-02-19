-- Homework 4 https://t.me/c/2484909863/260 
https://w3resource.com/sql-exercises/sql-aggregate-functions.php

-- 1.
select sum(purch_amt) 'sum' from orders

-- 2.
select avg(purch_amt) 'avg' from orders

-- 3. 
select count(distinct salesman_id) 'salesman count' from orders

-- 4.
select count(distinct customer_id) 'customer count' from orders

-- 5.
select count(distinct customer_id) 'count' from customer
where grade is not null

select count(all grade) from customer

-- 6.
select max(purch_amt) from orders

-- 7. 
select min(purch_amt) from orders

-- 8.
select city, max(grade) from customer
group by city 

-- 9. 
select customer_id, max(purch_amt) from orders
group by customer_id

-- 10.
select customer_id, ord_date, max(purch_amt) from orders
group by customer_id, ord_date

-- 11.
select salesman_id, max(purch_amt) from orders
where ord_date = '2012-08-17'
group by salesman_id

-- 12.
select customer_id, ord_date, max(purch_amt) from orders
group by customer_id, ord_date
having max(purch_amt) > 2000.00

-- 13.
select customer_id, ord_date, max(purch_amt) from orders
group by customer_id, ord_date
having max(purch_amt) between 2000 and 6000

--14. 
select customer_id, ord_date, max(purch_amt) from orders
group by customer_id, ord_date
having max(purch_amt) in (2000, 3000, 5760, 6000)

-- 15.
select customer_id, max(purch_amt) from orders
group by customer_id 
having customer_id between 3002 and 3007

-- 16. 
select customer_id, max(purch_amt) from orders
group by customer_id 
having customer_id between 3002 and 3007 and 
		max(purch_amt) > 1000

select customer_id, max(purch_amt) from orders
where customer_id between 3002 and 3007 
group by customer_id 
having max(purch_amt) > 1000

-- 17.
select salesman_id, max(purch_amt) from orders
where salesman_id between 5003 and 5008
group by salesman_id

select salesman_id, max(purch_amt) from orders
group by salesman_id
having salesman_id between 5003 and 5008

-- 18.
select count(*) from orders
where ord_date = '2012-08-17'

-- 19. 
select count(salesman_id) from salesman

-- 20.
select ord_date, salesman_id, count(*) from orders
group by ord_date, salesman_id

-- 21.
select avg(pro_price) from item_mast

-- 22.
select count(*) from item_mast
where pro_price >= 350

-- 23.
select avg(pro_price) as 'Average Price', pro_com as 'Company ID' from item_mast
group by pro_com 

-- 24.
select sum(DPT_ALLOTMENT) from emp_department

-- 25.
select emp_dept, count(*) from emp_details
group by emp_dept

-- done:)
