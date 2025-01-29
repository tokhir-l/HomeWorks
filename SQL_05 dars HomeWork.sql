-- 📌Homework📌

-- task 1:

--Create table
--CREATE TABLE [dbo].[TestMultipleZero]
--(
--    [A] [int] NULL,
--    [B] [int] NULL,
--    [C] [int] NULL,
--    [D] [int] NULL
--)
--GO
 
----Insert Data
--INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
--VALUES 
--    (0,0,0,1),
--    (0,0,1,0),
--    (0,1,0,0),
--    (1,0,0,0),
--    (0,0,0,0),
--    (1,1,1,0)

	-- If all the columns having zero value then don't show that row. 
	-- In this case we have to remove the 5th row while selecting data.

-- Solution:
SELECT * FROM [dbo].[TestMultipleZero]  
WHERE A != 0 OR B != 0 OR C != 0 OR D != 0;


-- Task 2:
--CREATE TABLE TESTDuplicateCount ( 
--    ID INT,
--    EmpName VARCHAR(100),
--    EmpDate DATETIME
--) 
----Insert Data 
--INSERT INTO TESTDuplicateCount(ID,EmpName,EmpDate) 
--VALUES
--(1,'Pawan','2014-01-05'),
--(2,'Pawan','2014-03-05'), 
--(3,'Pawan','2014-02-05'), 
--(4,'Manisha','2014-07-05'), 
--(5,'Sharlee','2014-09-05'), 
--(6,'Barry','2014-02-05'), 
--(7,'Jyoti','2014-04-05'), 
--(8,'Jyoti','2014-05-05')


-- In the puzzle we have to find the duplicate values from a duplicate table where duplicate values are more than 1.

-- Solution: 
SELECT EmpName, count(EmpName) as DuplicateCount FROM TESTDuplicateCount
GROUP BY EmpName 
HAVING count(EmpName) > 1;


-- Task 3: 
-- write a query to identify a number is perfect or not ( you can research about perfect number)

???????