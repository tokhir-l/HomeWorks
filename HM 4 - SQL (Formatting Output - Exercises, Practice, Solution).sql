-- Homework 4: https://www.w3resource.com/sql-exercises/sql-fromatting-output-exercises.php

/* 1. From the following table, write a SQL query to select all the salespeople. 
Return salesman_id, name, city, commission with the percent sign (%). 
Sample table: salesman */

select salesman_id, name, city, '%' as 'percent', commission*100 as commission from salesman

select salesman_id, name, city, concat(commission, '%') as commission from salesman

/*2. From the following table, write a SQL query to find the number of orders booked for each day. 
Return the result in a format like "For 2001-10-10 there are 15 orders".". 
Sample table: orders */

select 
  ' For', 
  ord_date, 
  ', there are ',  -- shu joyda vergul qo'ymagan ekanman boshda, ancha vaqt nima erro ekan deb count ni o'zgartrb yotman (
  COUNT(ord_no), 
  'orders.' 
from 
  orders 
group by 
  ord_date


-- 