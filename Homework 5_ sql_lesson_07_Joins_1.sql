-- SQL_07_Joins1 homework.doc

--Puzzle 1.
--DROP TABLE IF EXISTS #Cart1;
--DROP TABLE IF EXISTS #Cart2;

--CREATE TABLE #Cart1
--(
--    Item  VARCHAR(100) PRIMARY KEY
--);

--CREATE TABLE #Cart2
--(
--    Item  VARCHAR(100) PRIMARY KEY
--);

--INSERT INTO #Cart1 (Item) 
--VALUES ('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');

--INSERT INTO #Cart2 (Item) 
--VALUES ('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');

select * from #Cart1 c1
full join #Cart2 c2 on c1.Item=c2.Item


--Puzzle 2.

--declare @max int = 100, @min int = 1

--create table Nums(numbers int)

--while @min <= @max
--begin
--	insert into Nums
--	values(@min)
--	set @min = @min + 1
--end

--create table Employees(id int, fname varchar(25), lname varchar(25))

--insert into Employees values 
--(1, 'John', 'Doe'),(2, 'Mark' ,'Frazier'),(3,'Jeff', 'Charles')

SELECT e.id, e.fname, e.lname, 
    CASE 
        WHEN e.id % 2 = 0 THEN 6 - n.numbers
        ELSE n.numbers
    END AS value
FROM Employees e
CROSS JOIN Nums n
WHERE n.numbers BETWEEN 1 AND 5
ORDER BY e.id, n.numbers;


--3.
Savol incomplete berilgan. 