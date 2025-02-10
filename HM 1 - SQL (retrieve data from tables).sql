-- HomeWork 1:  https://www.w3resource.com/sql-exercises/sql-retrieve-from-table.php



CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name NVARCHAR(50),
    city NVARCHAR(50),
    commission DECIMAL(3, 2)
);

SELECT * FROM salesman

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5007, 'Paul Adam', 'Rome', 0.13),
	(5003, 'Lausen Hen', 'San Jose', 0.12);

-- 1. Display All Salespeople
SELECT * FROM salesman

-- 2. Display a Custom String
SELECT 'This is SQL Exercise, Practice and Solution';
PRINT 'This is SQL Exercise, Practice and Solution';

-- 3. Display Three Numbers
SELECT 1, 2, 3;

-- 4. Sum of Two Numbers
SELECT 10+15;

-- 5. Arithmetic Expression Result
SELECT 10+15;
SELECT 10-15;
SELECT 10*15;
SELECT 10/15;

-- 6. Specific Columns of Salespeople
SELECT name, commission FROM salesman;


-- 7. Custom Column Order in Orders
--CREATE TABLE orders (
--    ord_no INT PRIMARY KEY,
--    purch_amt DECIMAL(10, 2),
--    ord_date DATE,
--    customer_id INT,
--    salesman_id INT
--);

--INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
--VALUES
--    (70001, 150.5, '2012-10-05', 3005, 5002),
--    (70009, 270.65, '2012-09-10', 3001, 5005),
--    (70002, 65.26, '2012-10-05', 3002, 5001),
--    (70004, 110.5, '2012-08-17', 3009, 5003),
--    (70007, 948.5, '2012-09-10', 3005, 5002),
--    (70005, 2400.6, '2012-07-27', 3007, 5001),
--    (70008, 5760, '2012-09-10', 3002, 5001),
--    (70010, 1983.43, '2012-10-10', 3004, 5006),
--    (70003, 2480.4, '2012-10-10', 3009, 5003),
--    (70012, 250.45, '2012-06-27', 3008, 5002),
--    (70011, 75.29, '2012-08-17', 3003, 5007),
--    (70013, 3045.6, '2012-04-25', 3002, 5001);

SELECT ord_date, salesman_id, ord_no, purch_amt FROM orders;

-- 8. Unique Salespeople IDs
SELECT DISTINCT salesman_id FROM orders;

-- 9. Salespeople in Paris
SELECT name, city FROM salesman
WHERE city = 'Paris';

-- 10. Customers with Grade 200
--CREATE TABLE customer (
--    customer_id INT PRIMARY KEY,
--    cust_name NVARCHAR(50),
--    city NVARCHAR(50),
--    grade INT NULL,
--    salesman_id INT
--);

--INSERT INTO customer (customer_id, cust_name, city, grade, salesman_id)
--VALUES
--    (3002, 'Nick Rimando', 'New York', 100, 5001),
--    (3007, 'Brad Davis', 'New York', 200, 5001),
--    (3005, 'Graham Zusi', 'California', 200, 5002),
--    (3008, 'Julian Green', 'London', 300, 5002),
--    (3004, 'Fabian Johnson', 'Paris', 300, 5006),
--    (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
--    (3003, 'Jozy Altidor', 'Moscow', 200, 5007),
--    (3001, 'Brad Guzan', 'London', NULL, 5005);

SELECT customer_id, cust_name, city, grade, salesman_id FROM customer
WHERE grade = 200;

-- 11. Orders by Salesperson 5001
SELECT ord_no, ord_date, purch_amt FROM orders
WHERE salesman_id = 5001;

-- 12. Nobel Winner of 1970
--CREATE TABLE nobel_win (
--    year INT,
--    subject NVARCHAR(50),
--    winner NVARCHAR(100),
--    country NVARCHAR(50),
--    category NVARCHAR(50)
--);

--INSERT INTO nobel_win (year, subject, winner, country, category)
--VALUES
--    (1970, 'Physics', 'Hannes Alfven', 'Sweden', 'Scientist'),
--    (1970, 'Physics', 'Louis Neel', 'France', 'Scientist'),
--    (1970, 'Chemistry', 'Luis Federico Leloir', 'France', 'Scientist'),
--    (1970, 'Physiology', 'Ulf von Euler', 'Sweden', 'Scientist'),
--    (1970, 'Physiology', 'Bernard Katz', 'Germany', 'Scientist'),
--    (1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist'),
--    (1970, 'Economics', 'Paul Samuelson', 'USA', 'Economist'),
--    (1970, 'Physiology', 'Julius Axelrod', 'USA', 'Scientist'),
--    (1971, 'Physics', 'Dennis Gabor', 'Hungary', 'Scientist'),
--    (1971, 'Chemistry', 'Gerhard Herzberg', 'Germany', 'Scientist'),
--    (1971, 'Peace', 'Willy Brandt', 'Germany', 'Chancellor'),
--    (1971, 'Literature', 'Pablo Neruda', 'Chile', 'Linguist'),
--    (1971, 'Economics', 'Simon Kuznets', 'Russia', 'Economist'),
--    (1978, 'Peace', 'Anwar al-Sadat', 'Egypt', 'President'),
--    (1978, 'Peace', 'Menachem Begin', 'Israel', 'Prime Minister'),
--    (1987, 'Chemistry', 'Donald J. Cram', 'USA', 'Scientist'),
--    (1987, 'Chemistry', 'Jean-Marie Lehn', 'France', 'Scientist'),
--    (1987, 'Physiology', 'Susumu Tonegawa', 'Japan', 'Scientist'),
--    (1987, 'Physics', 'Johannes Georg Bednorz', 'Germany', 'Scientist'),
--    (1987, 'Literature', 'Joseph Brodsky', 'Russia', 'Linguist'),
--    (1987, 'Economics', 'Robert Solow', 'USA', 'Economist'),
--    (1994, 'Economics', 'Reinhard Selten', 'Germany', 'Economist'),
--    (1994, 'Peace', 'Yitzhak Rabin', 'Israel', 'Prime Minister'),
--    (1994, 'Literature', 'Kenzaburo Oe', NULL, 'Linguist');

SELECT year, subject, winner FROM nobel_win
WHERE year = 1970;


-- 13. Literature Winner 1971
SELECT winner FROM nobel_win
WHERE subject = 'Literature' AND year = 1971;


-- 14. Locate Dennis Gabor
SELECT year, subject FROM nobel_win
WHERE winner = 'Dennis Gabor';


-- 15. Physics Winners Since 1950
SELECT winner FROM nobel_win
WHERE subject = 'Physics' AND year >= 1950;


-- 16. Chemistry Winners (1965-1975)
SELECT year, subject, winner, country FROM nobel_win
WHERE winner = 'Chemistry' AND year BETWEEN 1965 and 1975;

SELECT year, subject, winner, country FROM nobel_win
WHERE winner = 'Chemistry' AND year >= 1965 and year <= 1975;

-- 17. Prime Ministers After 1972
-- Solution 1. 
SELECT * FROM nobel_win
WHERE category = 'Prime Minister';

-- Solution 2.
SELECT * FROM nobel_win
WHERE year > 1972 and winner in ('Menachem Begin', 'Yitzhak Rabin')

-- 18. Winners with First Name Louis
--Solution
SELECT year, subject, winner, country, category FROM nobel_win
WHERE winner LIKE 'Louis%';


-- 19. Combine Winners (Physics 1970 & Economics 1971)
-- Solution 
SELECT year, subject, winner, country, category FROM nobel_win
WHERE year = 1970 and subject = 'Physics'
UNION 
SELECT year, subject, winner, country, category FROM nobel_win
WHERE year = 1971 and subject = 'Economics'

-- 20. 1970 Winners Excluding Physiology & Economics
-- Solution
SELECT year, subject, winner, country, category FROM nobel_win
WHERE year = 1970 and subject not in ('Physiology','Economics')

-- 21. Physiology Before 1971 & Peace After 1974
-- Solution
SELECT year, subject, winner, country, category FROM nobel_win
WHERE subject = 'Physiology' and year<1971
UNION 
SELECT year, subject, winner, country, category FROM nobel_win
WHERE subject = 'Peace' and year >= 1974

-- 22. Details of Johannes Georg Bednorz
-- Solution
SELECT year, subject, winner, country, category FROM nobel_win
WHERE winner =  'Johannes Georg Bednorz'

-- 23. Winners Excluding Subjects Starting with P
-- Solution
SELECT year, subject, winner, country, category FROM nobel_win
WHERE subject not like 'P%'
ORDER BY year desc, winner asc;

-- 24. Ordered 1970 Nobel Prize Winners
-- Solution 
SELECT year, subject, winner, country, category FROM nobel_win
where year = 1970 
order by 
CASE when subject in ('Chemistry', 'Economics') then 1
else 0
end asc,
subject, winner;

-- 25. Products in Price Range Rs.200-600
-- Solution
SELECT pro_id, pro_name, pro_price, pro_com FROM item_mast
WHERE pro_price between 200 and 600;

-- 26. Average Price for Manufacturer Code 16
-- Solution
SELECT AVG(pro_price) as avg FROM item_mast
where pro_com = 16

-- 27. Display Item Name and Price
-- Solution
SELECT pro_name as 'Item Name', pro_price as 'Price in Rs.' from item_mast


-- 28. Items with Price >= $250
-- Solution
SELECT pro_name, pro_price FROM item_mast
WHERE pro_price >= 250
order by pro_price desc, pro_name asc;

-- 29. Average Price per Company
SELECT AVG(pro_price), pro_com FROM item_mast
Group by pro_com

-- 30. Cheapest Item
SELECT pro_name, pro_price FROM item_mast
WHERE pro_price = (SELECT MIN(pro_price) FROM item_mast)

-- 31. Unique Employee Last Names
SELECT distinct emp_lname from emp_details

-- 32. Employees with Last Name Snares
SELECT emp_idno, emp_fname, emp_lname, emp_dept from emp_details
where emp_lname = 'Snares'

-- 33. Employees in Department 57
SELECT emp_idno, emp_fname, emp_lname, emp_dept from emp_details
where emp_dept =57


done :)