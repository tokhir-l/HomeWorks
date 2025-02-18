-- Homework 5_2 SQL Joins

--1 
select s.name, c.cust_name, c.city from salesman s, customer c
where c.city=s.city

--2
select o.ord_no, o.purch_amt, c.cust_name, c.city from customer c
join orders o on c.customer_id=o.customer_id
where o.purch_amt between 500 and 2000

--3
select c.cust_name, c.city, s.name, s.commission from customer c
join salesman s on c.salesman_id=s.salesman_id

--4 
select c.cust_name, c.city, s.name, s.commission from customer c
join salesman s on c.salesman_id=s.salesman_id
group by c.cust_name, c.city, s.name, s.commission
having s.commission > 0.12
order by s.name

select c.cust_name, c.city, s.name, s.commission from customer c
join salesman s on c.salesman_id=s.salesman_id
where s.commission > 0.12
order by s.name

--5
select c.cust_name, c.city customerCity, s.name, s.city salesmanCity from customer c
join salesman s on c.salesman_id=s.salesman_id
where c.city!=s.city and s.commission > 0.12

--6
select o.ord_no, o.ord_date, o.purch_amt, c.cust_name customerName, c.grade, s.name salesmanName, s.commission from orders o
join customer c on c.customer_id=o.customer_id
join salesman s on s.salesman_id=c.salesman_id

--7 (task was about natural join. however t-sql doesn't support natural join. So, i used simple inner join)
select * from orders o
join customer c on c.customer_id=o.customer_id
join salesman s on s.salesman_id=c.salesman_id

--8
select c.cust_name customerName, c.city customerCity, s.name salesmanName, s.city salesmanCity from customer c
join salesman s on c.salesman_id=s.salesman_id
order by c.customer_id asc