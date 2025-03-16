-- Easy:
--1.
SELECT EmployeeID, EmployeeName, Salary,
       ROW_NUMBER() OVER (ORDER BY Salary) AS RowNum
FROM Employees;

--2. 
SELECT ProductID, ProductName, Price,
       RANK() OVER (ORDER BY Price DESC) AS PriceRank
FROM Products;

--3.
SELECT EmployeeID, EmployeeName, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

--4.
SELECT EmployeeID, EmployeeName, Salary, DepartmentID,
       LEAD(Salary) OVER (PARTITION BY DepartmentID ORDER BY Salary) AS NextSalary
FROM Employees;


--5.
SELECT SalesID, EmployeeID, SalesAmount,
       ROW_NUMBER() OVER (ORDER BY SalesDate) AS OrderNumber
FROM Sales;


--6.
SELECT EmployeeID, EmployeeName, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees
WHERE RANK() OVER (ORDER BY Salary DESC) <= 2;


--7
SELECT EmployeeID, EmployeeName, Salary,
       LAG(Salary) OVER (ORDER BY Salary) AS PreviousSalary
FROM Employees;


--8
SELECT EmployeeID, EmployeeName, Salary,
       NTILE(4) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Employees;


--9
SELECT EmployeeID, EmployeeName, Salary, DepartmentID,
       ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DeptRowNum
FROM Employees;


--10
SELECT ProductID, ProductName, Price,
       DENSE_RANK() OVER (ORDER BY Price ASC) AS PriceRank
FROM Products;


--11
SELECT ProductID, ProductName, Price,
       AVG(Price) OVER (ORDER BY Price ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Products;


--12
SELECT EmployeeID, EmployeeName, Salary,
       LEAD(Salary) OVER (ORDER BY Salary) AS NextEmployeeSalary
FROM Employees;


--13
SELECT SalesID, EmployeeID, SalesAmount,
       SUM(SalesAmount) OVER (ORDER BY SalesDate) AS CumulativeSales
FROM Sales;


--14
SELECT ProductID, ProductName, Price
FROM (SELECT ProductID, ProductName, Price,
             ROW_NUMBER() OVER (ORDER BY Price DESC) AS RankNum
      FROM Products) Ranked
WHERE RankNum <= 5;


--15
SELECT EmployeeID,
       SUM(SalesAmount) OVER (PARTITION BY EmployeeID) AS TotalSalesPerEmployee
FROM Sales;


--16
SELECT SalesID, EmployeeID, SalesAmount,
       RANK() OVER (ORDER BY SalesAmount DESC) AS OrderRank
FROM Sales;


--17
SELECT ProductID, SalesAmount,
       SalesAmount * 100.0 / SUM(SalesAmount) OVER () AS SalesPercentage
FROM Sales;


--18
SELECT SalesID, SalesDate,
       LEAD(SalesDate) OVER (ORDER BY SalesDate) AS NextOrderDate
FROM Sales;


--19
SELECT EmployeeID, EmployeeName, Salary,
       NTILE(3) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Employees;


--20
SELECT EmployeeID, EmployeeName,
       ROW_NUMBER() OVER (ORDER BY EmployeeID DESC) AS RecentHireRank
FROM Employees;


--Medium

--1
SELECT EmployeeID, EmployeeName, Salary
FROM (
    SELECT EmployeeID, EmployeeName, Salary,
           DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) t
WHERE SalaryRank = 2;


--2
SELECT CustomerID, OrderID, OrderAmount,
       SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeOrderAmount
FROM Orders;


--3
SELECT EmployeeID, EmployeeName, Salary,
       LAG(Salary) OVER (ORDER BY Salary) AS PreviousSalary,
       LEAD(Salary) OVER (ORDER BY Salary) AS NextSalary
FROM Employees;


--4
SELECT EmployeeID, EmployeeName, DepartmentID, Salary,
       RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM Employees;


--5
SELECT ProductID, ProductName, SalesAmount,
       SalesAmount * 100.0 / SUM(SalesAmount) OVER () AS SalesPercentage
FROM Sales;


--6
SELECT EmployeeID, EmployeeName, Salary,
       Salary - LAG(Salary) OVER (ORDER BY Salary) AS SalaryDifference
FROM Employees;


--7
SELECT EmployeeID, EmployeeName, DepartmentID, Salary
FROM (
    SELECT EmployeeID, EmployeeName, DepartmentID, Salary,
           DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS Rank
    FROM Employees
) t
WHERE Rank <= 3;


--8
SELECT EmployeeID, EmployeeName, Salary,
       AVG(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Employees;


--9
SELECT ProductID, ProductName, CategoryID, SalesAmount
FROM (
    SELECT ProductID, ProductName, CategoryID, SalesAmount,
           RANK() OVER (PARTITION BY CategoryID ORDER BY SalesAmount DESC) AS SalesRank
    FROM Sales
) t
WHERE SalesRank = 1;


--10
SELECT CustomerID, OrderID, OrderDate, OrderAmount,
       SUM(OrderAmount) OVER (PARTITION BY CustomerID, MONTH(OrderDate) ORDER BY OrderDate) AS RunningTotal
FROM Orders;


--11
SELECT ProductID, ProductName, CategoryID, Price
FROM (
    SELECT ProductID, ProductName, CategoryID, Price,
           DENSE_RANK() OVER (PARTITION BY CategoryID ORDER BY Price DESC) AS PriceRank
    FROM Products
) t
WHERE PriceRank = 2;


--12
SELECT CustomerID, OrderID, OrderDate,
       COUNT(OrderID) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeCount
FROM Orders;


--13
SELECT EmployeeID, EmployeeName, DepartmentID, Salary
FROM (
    SELECT EmployeeID, EmployeeName, DepartmentID, Salary,
           AVG(Salary) OVER (PARTITION BY DepartmentID) AS DeptAvgSalary
    FROM Employees
) t
WHERE Salary > DeptAvgSalary;


--14
SELECT CustomerID, OrderID, OrderDate
FROM (
    SELECT CustomerID, OrderID, OrderDate,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS OrderRank
    FROM Orders
) t
WHERE OrderRank = 3;


--15
SELECT EmployeeID, EmployeeName, Salary,
       (Salary - LAG(Salary) OVER (ORDER BY Salary)) * 100.0 / LAG(Salary) OVER (ORDER BY Salary) AS PercentageChange
FROM Employees;


--16
SELECT CustomerID, OrderID, OrderDate, OrderAmount,
       SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeSum
FROM Orders;

--17
SELECT CustomerID, OrderID, OrderDate
FROM (
    SELECT CustomerID, OrderID, OrderDate,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate DESC) AS OrderRank
    FROM Orders
) t
WHERE OrderRank = 3;


--18
SELECT EmployeeID, EmployeeName, DepartmentID, HireDate,
       RANK() OVER (PARTITION BY DepartmentID ORDER BY HireDate) AS HireRank
FROM Employees;


--19
SELECT EmployeeID, EmployeeName, DepartmentID, Salary
FROM (
    SELECT EmployeeID, EmployeeName, DepartmentID, Salary,
           DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) t
WHERE SalaryRank = 3;


--20
SELECT OrderID, CustomerID, OrderDate,
       LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) - OrderDate AS DateDifference
FROM Orders;


--Difficult
--1
WITH ProductRanking AS (
    SELECT ProductID, ProductName, SUM(SalesAmount) AS TotalSales,
           RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank,
           PERCENT_RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS PercentRank
    FROM Sales
    GROUP BY ProductID, ProductName
)
SELECT ProductID, ProductName, TotalSales, SalesRank
FROM ProductRanking
WHERE PercentRank > 0.10; -- Excludes the top 10%


--2
SELECT EmployeeID, EmployeeName, HireDate,
       ROW_NUMBER() OVER (ORDER BY HireDate) AS RowNum
FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5;


--3
SELECT EmployeeID, EmployeeName, Salary,
       NTILE(10) OVER (ORDER BY Salary DESC) AS SalaryGroup
FROM Employees;


--4
SELECT EmployeeID, SaleID, SalesAmount,
       LEAD(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SalesDate) AS NextSalesAmount
FROM Sales;


--5
SELECT ProductID, ProductName, CategoryID, Price,
       AVG(Price) OVER (PARTITION BY CategoryID) AS AvgCategoryPrice
FROM Products;


--6
WITH ProductSales AS (
    SELECT ProductID, ProductName, SUM(SalesAmount) AS TotalSales,
           RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM Sales
    GROUP BY ProductID, ProductName
)
SELECT ProductID, ProductName, TotalSales, SalesRank
FROM ProductSales
WHERE SalesRank <= 3;


--7
WITH RankedEmployees AS (
    SELECT EmployeeID, EmployeeName, DepartmentID, Salary,
           ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS Rank
    FROM Employees
)
SELECT EmployeeID, EmployeeName, DepartmentID, Salary
FROM RankedEmployees
WHERE Rank <= 5;


--8
SELECT SaleID, SalesAmount, SalesDate,
       (SalesAmount + 
        COALESCE(LAG(SalesAmount, 1) OVER (ORDER BY SalesDate), 0) +
        COALESCE(LAG(SalesAmount, 2) OVER (ORDER BY SalesDate), 0) +
        COALESCE(LEAD(SalesAmount, 1) OVER (ORDER BY SalesDate), 0) +
        COALESCE(LEAD(SalesAmount, 2) OVER (ORDER BY SalesDate), 0)) / 5 AS MovingAvg
FROM Sales;


--9
WITH RankedSales AS (
    SELECT ProductID, ProductName, SUM(SalesAmount) AS TotalSales,
           DENSE_RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM Sales
    GROUP BY ProductID, ProductName
)
SELECT ProductID, ProductName, TotalSales, SalesRank
FROM RankedSales
WHERE SalesRank <= 5;


--10
SELECT OrderID, CustomerID, OrderAmount,
       NTILE(4) OVER (ORDER BY OrderAmount) AS Quartile
FROM Orders;


--11
SELECT OrderID, CustomerID, OrderDate,
       ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS OrderRank
FROM Orders;


--12
SELECT EmployeeID, EmployeeName, DepartmentID,
       COUNT(*) OVER (PARTITION BY DepartmentID) AS TotalEmployees
FROM Employees;


--13
WITH SalaryRanking AS (
    SELECT EmployeeID, EmployeeName, DepartmentID, Salary,
           RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRankDesc,
           RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary ASC) AS SalaryRankAsc
    FROM Employees
)
SELECT EmployeeID, EmployeeName, DepartmentID, Salary
FROM SalaryRanking
WHERE SalaryRankDesc <= 3 OR SalaryRankAsc <= 3;


--14
SELECT EmployeeID, SaleID, SalesAmount,
       LAG(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SalesDate) AS PrevSalesAmount,
       (SalesAmount - LAG(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SalesDate)) * 100.0 / 
       LAG(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SalesDate) AS PercentageChange
FROM Sales;


--15
SELECT EmployeeID, SaleID, SalesAmount,
       LAG(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SalesDate) AS PrevSalesAmount,
       (SalesAmount - LAG(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SalesDate)) * 100.0 / 
       LAG(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SalesDate) AS PercentageChange
FROM Sales;


--16
SELECT EmployeeID, EmployeeName, Age,
       NTILE(3) OVER (ORDER BY Age) AS AgeGroup
FROM Employees;


--17
WITH SalesRanking AS (
    SELECT EmployeeID, EmployeeName, SUM(SalesAmount) AS TotalSales,
           ROW_NUMBER() OVER (ORDER BY SUM(SalesAmount) DESC) AS Rank
    FROM Sales
    GROUP BY EmployeeID, EmployeeName
)
SELECT EmployeeID, EmployeeName, TotalSales
FROM SalesRanking
WHERE Rank <= 10;


--18
SELECT ProductID, ProductName, Price,
       LEAD(Price) OVER (ORDER BY Price) - Price AS PriceDifference
FROM Products;


--19
SELECT EmployeeID, EmployeeName, PerformanceScore,
       DENSE_RANK() OVER (ORDER BY PerformanceScore DESC) AS PerformanceRank
FROM Employees;


--20
SELECT OrderID, ProductID, SalesAmount,
       LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS PrevSales,
       LEAD(SalesAmount) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS NextSales,
       SalesAmount - LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS DifferenceFromPrevious,
       LEAD(SalesAmount) OVER (PARTITION BY ProductID ORDER BY OrderDate) - SalesAmount AS DifferenceFromNext
FROM Orders;



done :)