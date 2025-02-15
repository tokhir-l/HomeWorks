--create database sqlmidterm
--go
--use sqlmidterm



--PUZZLE 1:
/*
USING THE SalesCustomer TABLE BELOW,
FIND THE TOTAL SALES AS A Total_Sales COLUMN FOR
CUSTOMERS WHO PAID MORE THAN 200000 IN TOTAL.
*/

--CREATE TABLE [dbo].[SalesCustomer](
--	[CustomerID] [int] NOT NULL,
--	[Sales] [money] NULL
--) 

--INSERT [dbo].[SalesCustomer] ([CustomerID], [Sales]) VALUES 
--(30118, 36878.2723),(30118, 27290.9456),(30118, 40248.2376),(30118, 49576.7444),
--(30118, 43214.8509),(30118, 36830.6141),(30118, 35194.5141),(30118, 44437.3562),
--(30117, 68826.1277),(30117, 82495.6988),(30117, 86193.0846),(30117, 88730.5249),
--(30117, 106618.264),(30117, 88479.4098),(30117, 112859.9318),(30117, 97424.9805),
--(30117, 62770.1045),(30117, 61426.8586),(30117, 49116.1883),(30117, 14860.6446),
--(30116, 47520.5830),(30116, 55317.9431),(30116, 51390.8958),(30116, 57441.8455),
--(30115, 757.0030),(30115, 213.0271),(30115, 1650.7273),(30115, 757.0030),
--(30115, 861.7436),(30115, 2069.7699),(30115, 2949.1326),(30115, 775.4107),
--(30114, 641.7458),(30114, 201.2336),(30114, 4510.4959),(30114, 3315.8040),
--(30114, 516.5278),(30114, 986.2091),(30114, 392.1097),(30114, 2570.9074)

--SOLUTION:
select CustomerID, sum(sales) as 'Total_Sales' from SalesCustomer
group by CustomerID
having sum(Sales) > 200000  

--PUZZLE 2:
/*
USING THE Students TABLE BELOW,
FIND THE NAME OF THE STUDENT WHO GOT
HIGHEST NUMBER OF GRADE "A" WHEN COUNTED.
THE OUTPUT SHOULD CONTAIN ONLY THE NAME OF THE STUDENT.
*/

--CREATE TABLE [dbo].[Students](
--	[Name] [varchar](100),
--	[Subject] [varchar](100),
--	[Grade] [char](1)
--) 

--INSERT [dbo].[Students] ([Name], [Subject], [Grade]) VALUES
--('Josh', 'Physics', 'A'),('Josh', 'Accounting', 'A'),('Josh', 'IT', 'A'),
--('Josh', 'Math', 'C'),('Karen', 'Physics', 'A'),('Karen', 'Accounting', 'B'),
--('Karen', 'IT', 'A'),('Patric', 'Physics', 'A'),('Patric', 'Accounting', 'B'),
--('Patric', 'IT', 'C')

--SOLUTION:
select Name from Students
where grade = 'A'
group by name
order by count(*) desc
OFFSET 0 rows fetch next 1 row only



--PUZZLE 3:
/*
USING THE OnlineSales and DealerSales TABLES BELOW,
WRITE A SQL QUERY TO GET THE OUTPUT BELOW.
WHEN FINDING THE TOTAL SALES CONSIDER PRICE NOT THE COST.

 ----------------------------------------------------------------------------------------------
|ProductID  | Name               | Online_Total          | Dealer_Total          | Total_Sales |
|-----------|--------------------|-----------------------| ----------------------| ------------|
|101        | Toyota Camry       | 600000                | 510000                | 1110000	   |
|102        | Toyota Corolla     | 529000                | 713000                | 1242000	   |
|103        | Toyota RAV4        | 468000                | 0                     | 468000	   |
|104        | Toyota GR86        | 330000                | 0                     | 330000	   |
|105        | Toyota Highlander  | 0                     | 588000                | 588000	   |
|106        | Toyota Crown       | 0                     | 224000                | 224000	   |
 ----------------------------------------------------------------------------------------------
*/

CREATE TABLE [dbo].[OnlineSales](
	[ProductID] int,
	[Name] varchar(100),
	[Cost] float,
	[Price] float,
	[Quantity] int
) 

CREATE TABLE [dbo].[DealerSales](
	[ProductID] int,
	[Name] varchar(100),
	[Cost] float,
	[Price] float,
	[Quantity] int
) 

INSERT [dbo].[OnlineSales] ([ProductID], [Name], [Cost], [Price], [Quantity]) VALUES
(101,'Toyota Camry',20000,30000,20),(102,'Toyota Corolla',15000,23000,23),
(103,'Toyota RAV4',25000,36000,13),(104,'Toyota GR86',27000,33000,10)

INSERT [dbo].[DealerSales] ([ProductID], [Name], [Cost], [Price], [Quantity]) VALUES
(101,'Toyota Camry',20000,30000,17),(102,'Toyota Corolla',15000,23000,31),
(105,'Toyota Highlander',30000,42000,14),(106,'Toyota Crown',22000,32000,7)

---SOLUTION:
select coalesce(o.ProductID,d.ProductID) ProductID, coalesce(o.name, d.name) Name, 
coalesce(sum(o.Price*o.Quantity),0) Online_Total, 
coalesce(sum(d.Price * d.Quantity),0) Dealer_Total, 
(coalesce(sum(o.Price*o.Quantity),0)+coalesce(sum(d.Price * d.Quantity),0) )as Total_Sales from OnlineSales o
full join DealerSales d
	on d.ProductID = o.ProductID
group by o.ProductID, d.ProductID, o.name, d.name
order by 1


--PUZZLE 4:
/*
USING THE Employee TABLE BELOW,
WRITE A SQL QUERY TO SHOW RIGHT NEXT EACH EMPLOYEE
THEIR MANAGER'S NAME, IF THERE IS NO MANAGER FOR 
A GIVEN EMPLOYEE THEN SHOW "No Manager".
*/

CREATE TABLE Employee (
	[ID] int,
	[Name] varchar(50),
	[ManagerID] int
)

insert into Employee([ID], [Name], [ManagerID]) values 
(1,'Great Boss',null),(2,'First Deputy of Boss',1),
(3,'Second Deputy of Boss',1),(4,'First Deputy Assistant',2),
(5,'Second Deputy Assistant',3),(6,'First Deputy Assistant shadow',4)

--SOLUTION:
	select  e.Name, COALESCE(m.Name, 'No Manager') Manager_Name
	from Employee e
	left join Employee m
	on e.ManagerID=m.ID
	

