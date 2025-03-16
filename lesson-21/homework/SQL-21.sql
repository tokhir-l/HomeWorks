-- Task 1: Basic MERGE Operation
MERGE INTO Employees AS e
USING NewEmployees AS ne
ON e.EmployeeID = ne.EmployeeID
WHEN MATCHED THEN
    UPDATE SET e.Name = ne.Name, e.Position = ne.Position, e.Salary = ne.Salary
WHEN NOT MATCHED THEN
    INSERT (EmployeeID, Name, Position, Salary)
    VALUES (ne.EmployeeID, ne.Name, ne.Position, ne.Salary);

-- Task 2: Delete Records with MERGE
MERGE INTO OldProducts AS op
USING CurrentProducts AS cp
ON op.ProductID = cp.ProductID
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Task 3: MERGE with Conditional Updates
MERGE INTO Employees AS e
USING NewSalaryDetails AS ns
ON e.EmployeeID = ns.EmployeeID
WHEN MATCHED AND ns.Salary > e.Salary THEN
    UPDATE SET e.Salary = ns.Salary;

-- Task 4: MERGE with Multiple Conditions
MERGE INTO Orders AS o
USING NewOrders AS no
ON o.OrderID = no.OrderID
WHEN MATCHED AND o.CustomerID = no.CustomerID AND no.OrderAmount > o.OrderAmount THEN
    UPDATE SET o.OrderAmount = no.OrderAmount
WHEN NOT MATCHED THEN
    INSERT (OrderID, CustomerID, OrderAmount)
    VALUES (no.OrderID, no.CustomerID, no.OrderAmount);

-- Task 5: MERGE with Data Validation and Logging
MERGE INTO StudentRecords AS sr
USING (SELECT * FROM NewStudentRecords WHERE Age > 18) AS nsr
ON sr.StudentID = nsr.StudentID
WHEN MATCHED THEN
    UPDATE SET sr.Name = nsr.Name, sr.Age = nsr.Age, sr.Grade = nsr.Grade
WHEN NOT MATCHED THEN
    INSERT (StudentID, Name, Age, Grade)
    VALUES (nsr.StudentID, nsr.Name, nsr.Age, nsr.Grade);

INSERT INTO MergeLog (Action, Timestamp)
SELECT 'Inserted/Updated StudentRecords', GETDATE();

-- View and Function Practice
-- Task 1: Aggregated Sales Summary
CREATE VIEW SalesSummary AS
SELECT CustomerID, SUM(SalesAmount) AS TotalSales, COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID;

-- Task 2: Employee Department Details
CREATE VIEW EmployeeDepartmentDetails AS
SELECT e.EmployeeID, e.Name, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- Task 3: Product Inventory Status
CREATE VIEW InventoryStatus AS
SELECT p.ProductID, p.ProductName, i.QuantityAvailable
FROM Products p
JOIN Inventory i ON p.ProductID = i.ProductID;

-- Task 4: Simple Scalar Function
CREATE FUNCTION fn_GetFullName (@FirstName NVARCHAR(50), @LastName NVARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName;
END;

-- Task 5: Inline Table-Valued Function
CREATE FUNCTION fn_GetHighSales (@Threshold DECIMAL(10,2))
RETURNS TABLE
AS
RETURN (
    SELECT * FROM Sales WHERE SalesAmount > @Threshold
);

-- Task 6: Multi-Statement Table-Valued Function
CREATE FUNCTION fn_GetCustomerStats ()
RETURNS @CustomerStats TABLE (CustomerID INT, TotalSpent DECIMAL(10,2), OrderCount INT)
AS
BEGIN
    INSERT INTO @CustomerStats
    SELECT CustomerID, SUM(SalesAmount), COUNT(OrderID)
    FROM Orders
    GROUP BY CustomerID;
    RETURN;
END;

-- Window Functions in SQL
-- Task 1: Explaining the Importance of Window Functions
-- Window functions improve performance as they avoid extra joins, subqueries, or temporary tables.

-- Task 2: Syntax of Window Functions
-- Cumulative Sales
SELECT CustomerID, OrderID, SalesAmount,
       SUM(SalesAmount) OVER (PARTITION BY CustomerID ORDER BY OrderID) AS CumulativeSales
FROM Orders;

-- Average Salary Per Department
SELECT DepartmentID, EmployeeID, Salary,
       AVG(Salary) OVER (PARTITION BY DepartmentID) AS AvgSalary
FROM Employees;

-- Task 3: Partition By vs Group By
-- Using PARTITION BY
SELECT ProductCategory, ProductID, Revenue,
       SUM(Revenue) OVER (PARTITION BY ProductCategory) AS CumulativeRevenue
FROM Sales;

-- Using GROUP BY
SELECT ProductCategory, SUM(Revenue) AS TotalRevenue
FROM Sales
GROUP BY ProductCategory;

-- Task 4: ROW_NUMBER, RANK, and DENSE_RANK
SELECT StudentID, TestScore,
       ROW_NUMBER() OVER (ORDER BY TestScore DESC) AS RowNum,
       RANK() OVER (ORDER BY TestScore DESC) AS RankNum,
       DENSE_RANK() OVER (ORDER BY TestScore DESC) AS DenseRankNum
FROM Students;

-- Task 5: LEAD and LAG Functions
-- LAG for price change from previous day
SELECT StockID, TradeDate, Price,
       LAG(Price) OVER (PARTITION BY StockID ORDER BY TradeDate) AS PrevPrice,
       Price - LAG(Price) OVER (PARTITION BY StockID ORDER BY TradeDate) AS PriceChange
FROM StockPrices;

-- LEAD for price change to next day
SELECT StockID, TradeDate, Price,
       LEAD(Price) OVER (PARTITION BY StockID ORDER BY TradeDate) AS NextPrice,
       LEAD(Price) OVER (PARTITION BY StockID ORDER BY TradeDate) - Price AS PriceChange
FROM StockPrices;

-- Task 6: NTILE Function
-- Divide customers into quartiles based on spending
SELECT CustomerID, TotalSpent,
       NTILE(4) OVER (ORDER BY TotalSpent DESC) AS Quartile
FROM CustomerSpending;

-- Divide customers into quintiles
SELECT CustomerID, TotalSpent,
       NTILE(5) OVER (ORDER BY TotalSpent DESC) AS Quintile
FROM CustomerSpending;
