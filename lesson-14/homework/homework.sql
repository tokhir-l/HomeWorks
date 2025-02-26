-- Easy Tasks

--1.
SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
FROM (SELECT e.EmployeeID, s.SalesAmount
      FROM Employees e
      JOIN Sales s ON e.EmployeeID = s.SalesID) AS DerivedSales
GROUP BY EmployeeID;

--2
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AverageSalary FROM Employees
)
SELECT * FROM AvgSalary;


--3
SELECT ProductID, MAX(SalesAmount) AS HighestSales
FROM (SELECT ProductID, SalesAmount FROM Sales) AS DerivedSales
GROUP BY ProductID;


--4
WITH SalesCount AS (
    SELECT EmployeeID, COUNT(SalesID) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.FirstName, e.LastName
FROM Employees e
JOIN SalesCount s ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 5;


--5
SELECT CustomerID, SUM(TotalPurchase) AS TotalSpent
FROM (SELECT CustomerID, SUM(SalesAmount) AS TotalPurchase FROM Sales GROUP BY CustomerID) AS TopCustomers
ORDER BY TotalSpent DESC
LIMIT 5;


--6
WITH HighSalesProducts AS (
    SELECT ProductID
    FROM Sales
    WHERE SalesAmount > 500
)
SELECT p.ProductName
FROM Products p
JOIN HighSalesProducts hs ON p.ProductID = hs.ProductID;


--7
SELECT CustomerID, COUNT(SalesID) AS TotalOrders
FROM (SELECT CustomerID, SalesID FROM Sales) AS OrderCount
GROUP BY CustomerID;



--8
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT * FROM Employees WHERE Salary > (SELECT AvgSal FROM AvgSalary);



--9
SELECT SUM(SalesAmount) AS TotalProductsSold
FROM (SELECT SalesAmount FROM Sales) AS DerivedSales;



--10
WITH NoSales AS (
    SELECT e.EmployeeID
    FROM Employees e
    LEFT JOIN Sales s ON e.EmployeeID = s.SalesID
    WHERE s.SalesID IS NULL
)
SELECT e.FirstName, e.LastName FROM Employees e JOIN NoSales ns ON e.EmployeeID = ns.EmployeeID;



--11
SELECT Region, SUM(SalesAmount) AS TotalRevenue
FROM (SELECT Region, SalesAmount FROM Sales) AS RevenueByRegion
GROUP BY Region;



--12
WITH EmployeeYears AS (
    SELECT EmployeeID, DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsWorked FROM Employees
)
SELECT * FROM EmployeeYears WHERE YearsWorked > 5;



--13
SELECT CustomerID, COUNT(SalesID) AS TotalOrders
FROM (SELECT CustomerID, SalesID FROM Sales) AS CustomerOrders
GROUP BY CustomerID
HAVING COUNT(SalesID) > 3;



--14
WITH EmployeeSales AS (
    SELECT e.EmployeeID, e.DepartmentID, SUM(s.SalesAmount) AS TotalSales
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.SalesID
    GROUP BY e.EmployeeID, e.DepartmentID
)
SELECT * FROM EmployeeSales WHERE TotalSales = (SELECT MAX(TotalSales) FROM EmployeeSales WHERE DepartmentID = X);



--15
SELECT CustomerID, AVG(SalesAmount) AS AvgOrderValue
FROM (SELECT CustomerID, SalesAmount FROM Sales) AS Orders
GROUP BY CustomerID;



--16
WITH EmployeeCount AS (
    SELECT DepartmentID, COUNT(EmployeeID) AS EmployeeTotal FROM Employees GROUP BY DepartmentID
)
SELECT * FROM EmployeeCount;



--17
SELECT ProductID, SUM(SalesAmount) AS TotalSales
FROM (SELECT ProductID, SalesAmount FROM Sales WHERE SaleDate >= DATEADD(MONTH, -3, GETDATE())) AS LastQuarterSales
GROUP BY ProductID
ORDER BY TotalSales DESC;



--18
WITH HighSales AS (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY EmployeeID
)
SELECT e.FirstName, e.LastName FROM Employees e JOIN HighSales hs ON e.EmployeeID = hs.EmployeeID WHERE hs.TotalSales > 1000;



--19
SELECT CustomerID, COUNT(SalesID) AS OrderCount FROM (SELECT CustomerID, SalesID FROM Sales) AS Orders GROUP BY CustomerID;


--20
WITH LastMonthSales AS (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -1, GETDATE())
    GROUP BY EmployeeID
)
SELECT * FROM LastMonthSales;



-- Medium Tasks

-- 1. Find the top 3 products by total sales amount
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT * FROM ProductSales
ORDER BY TotalSales DESC
FETCH FIRST 3 ROWS ONLY;

-- 2. List employees with above-average total sales
WITH AvgSales AS (
    SELECT AVG(TotalSales) AS AvgTotalSales FROM (
        SELECT EmployeeID, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY EmployeeID
    ) AS EmployeeSales
)
SELECT e.FirstName, e.LastName
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY EmployeeID
) es ON e.EmployeeID = es.EmployeeID
WHERE es.TotalSales > (SELECT AvgTotalSales FROM AvgSales);

-- 3. Identify customers who made a purchase in each of the last 3 months
WITH MonthlyPurchases AS (
    SELECT CustomerID, EXTRACT(MONTH FROM SaleDate) AS SaleMonth
    FROM Sales
    WHERE SaleDate >= ADD_MONTHS(CURRENT_DATE, -3)
    GROUP BY CustomerID, EXTRACT(MONTH FROM SaleDate)
)
SELECT CustomerID FROM MonthlyPurchases
GROUP BY CustomerID
HAVING COUNT(DISTINCT SaleMonth) = 3;

-- 4. Find the department with the highest total salary expense
WITH DepartmentSalaries AS (
    SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees GROUP BY DepartmentID
)
SELECT * FROM DepartmentSalaries ORDER BY TotalSalary DESC FETCH FIRST 1 ROW ONLY;

-- 5. Rank employees by their total sales within each department
WITH EmployeeSales AS (
    SELECT e.EmployeeID, e.DepartmentID, SUM(s.SalesAmount) AS TotalSales,
           RANK() OVER (PARTITION BY e.DepartmentID ORDER BY SUM(s.SalesAmount) DESC) AS Rank
    FROM Employees e
    JOIN Sales s ON e.EmployeeID = s.EmployeeID
    GROUP BY e.EmployeeID, e.DepartmentID
)
SELECT * FROM EmployeeSales;

-- 6. Retrieve products with sales greater than the average sales amount
WITH AvgSales AS (
    SELECT AVG(SalesAmount) AS AvgSales FROM Sales
)
SELECT ProductID FROM Sales
GROUP BY ProductID
HAVING SUM(SalesAmount) > (SELECT AvgSales FROM AvgSales);

-- 7. Identify customers who have made purchases in at least 2 different months
WITH CustomerMonths AS (
    SELECT CustomerID, COUNT(DISTINCT EXTRACT(MONTH FROM SaleDate)) AS MonthCount
    FROM Sales
    GROUP BY CustomerID
)
SELECT CustomerID FROM CustomerMonths WHERE MonthCount >= 2;

-- 8. List employees who have not made any sales
SELECT e.EmployeeID, e.FirstName, e.LastName
FROM Employees e
LEFT JOIN Sales s ON e.EmployeeID = s.EmployeeID
WHERE s.SalesAmount IS NULL;

-- 9. Identify the product with the highest number of unique customers
WITH ProductCustomers AS (
    SELECT ProductID, COUNT(DISTINCT CustomerID) AS CustomerCount FROM Sales GROUP BY ProductID
)
SELECT * FROM ProductCustomers ORDER BY CustomerCount DESC FETCH FIRST 1 ROW ONLY;

-- 10. Find the most recent sale date for each product
WITH RecentSales AS (
    SELECT ProductID, MAX(SaleDate) AS LastSaleDate FROM Sales GROUP BY ProductID
)
SELECT * FROM RecentSales;

-- 11. Retrieve customers who made more than 5 purchases
WITH CustomerPurchases AS (
    SELECT CustomerID, COUNT(*) AS PurchaseCount FROM Sales GROUP BY CustomerID
)
SELECT CustomerID FROM CustomerPurchases WHERE PurchaseCount > 5;

-- 12. Find the average sales amount per department
WITH DepartmentSales AS (
    SELECT e.DepartmentID, AVG(s.SalesAmount) AS AvgSales FROM Sales s
    JOIN Employees e ON s.EmployeeID = e.EmployeeID
    GROUP BY e.DepartmentID
)
SELECT * FROM DepartmentSales;

-- 13. Identify products with no sales in the last 3 months
WITH ProductSales AS (
    SELECT ProductID FROM Sales WHERE SaleDate >= ADD_MONTHS(CURRENT_DATE, -3)
)
SELECT p.ProductID FROM Products p
LEFT JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.ProductID IS NULL;

-- 14. Find employees with the highest number of sales transactions
WITH EmployeeTransactionCounts AS (
    SELECT EmployeeID, COUNT(*) AS TransactionCount FROM Sales GROUP BY EmployeeID
)
SELECT * FROM EmployeeTransactionCounts ORDER BY TransactionCount DESC FETCH FIRST 1 ROW ONLY;

-- 15. Identify customers whose first purchase was within the last 6 months
WITH FirstPurchase AS (
    SELECT CustomerID, MIN(SaleDate) AS FirstPurchaseDate FROM Sales GROUP BY CustomerID
)
SELECT * FROM FirstPurchase WHERE FirstPurchaseDate >= ADD_MONTHS(CURRENT_DATE, -6);

-- 16. List departments with more than 5 employees
WITH DepartmentEmployeeCount AS (
    SELECT DepartmentID, COUNT(*) AS EmployeeCount FROM Employees GROUP BY DepartmentID
)
SELECT * FROM DepartmentEmployeeCount WHERE EmployeeCount > 5;

-- 17. Identify products with total sales exceeding $10,000
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales FROM Sales GROUP BY ProductID
)
SELECT * FROM ProductSales WHERE TotalSales > 10000;

-- 18. Retrieve employees who have sold at least 5 different products
WITH EmployeeProductCount AS (
    SELECT EmployeeID, COUNT(DISTINCT ProductID) AS ProductCount FROM Sales GROUP BY EmployeeID
)
SELECT * FROM EmployeeProductCount WHERE ProductCount >= 5;

-- 19. Find the highest single transaction amount for each employee
WITH MaxTransaction AS (
    SELECT EmployeeID, MAX(SalesAmount) AS MaxSale FROM Sales GROUP BY EmployeeID
)
SELECT * FROM MaxTransaction;

-- 20. Identify customers who spent more than the average customer spend
WITH CustomerSpending AS (
    SELECT CustomerID, SUM(SalesAmount) AS TotalSpent FROM Sales GROUP BY CustomerID
),
AvgSpending AS (
    SELECT AVG(TotalSpent) AS AvgSpent FROM CustomerSpending
)
SELECT * FROM CustomerSpending WHERE TotalSpent > (SELECT AvgSpent FROM AvgSpending);



-- Difficult

-- 1. Recursive CTE for Fibonacci sequence up to the 20th term
WITH Fibonacci (n, value1, value2) AS (
    SELECT 1, 0, 1
    UNION ALL
    SELECT n + 1, value2, value1 + value2
    FROM Fibonacci
    WHERE n < 20
)
SELECT n, value1 FROM Fibonacci;

-- 2. CTE to calculate cumulative sales of employees over the past year
WITH CumulativeSales AS (
    SELECT E.EmployeeID, E.FirstName, E.LastName, SUM(S.SalesAmount) AS TotalSales
    FROM Employees E
    JOIN Sales S ON E.EmployeeID = S.SalesID
    WHERE S.SaleDate >= DATEADD(YEAR, -1, GETDATE())
    GROUP BY E.EmployeeID, E.FirstName, E.LastName
)
SELECT * FROM CumulativeSales;

-- 3. Recursive CTE to find all subordinates of a manager
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, ManagerID
    FROM Employees
    WHERE ManagerID = @ManagerID
    UNION ALL
    SELECT E.EmployeeID, E.ManagerID
    FROM Employees E
    JOIN EmployeeHierarchy EH ON E.ManagerID = EH.EmployeeID
)
SELECT * FROM EmployeeHierarchy;

-- 4. Derived table to find employees with sales above the company average
SELECT E.EmployeeID, E.FirstName, E.LastName, SalesTotal
FROM (
    SELECT S.EmployeeID, SUM(S.SalesAmount) AS SalesTotal
    FROM Sales S
    GROUP BY S.EmployeeID
) AS EmployeeSales
JOIN Employees E ON E.EmployeeID = EmployeeSales.EmployeeID
WHERE SalesTotal > (SELECT AVG(SalesAmount) FROM Sales);

-- 5. Recursive CTE to calculate the depth of a product in a multi-level product hierarchy
WITH ProductHierarchy AS (
    SELECT ProductID, ParentProductID, 1 AS Depth
    FROM Products
    WHERE ParentProductID IS NULL
    UNION ALL
    SELECT P.ProductID, P.ParentProductID, PH.Depth + 1
    FROM Products P
    JOIN ProductHierarchy PH ON P.ParentProductID = PH.ProductID
)
SELECT * FROM ProductHierarchy;

-- 6. CTE and Derived Table to calculate sales totals for each department and product
WITH DepartmentSales AS (
    SELECT E.DepartmentID, S.ProductID, SUM(S.SalesAmount) AS TotalSales
    FROM Employees E
    JOIN Sales S ON E.EmployeeID = S.SalesID
    GROUP BY E.DepartmentID, S.ProductID
)
SELECT D.DepartmentName, P.ProductName, DS.TotalSales
FROM DepartmentSales DS
JOIN Departments D ON DS.DepartmentID = D.DepartmentID
JOIN Products P ON DS.ProductID = P.ProductID;

-- 7. Recursive CTE to list all direct and indirect reports of a manager
WITH Reports AS (
    SELECT EmployeeID, ManagerID
    FROM Employees
    WHERE ManagerID = @ManagerID
    UNION ALL
    SELECT E.EmployeeID, E.ManagerID
    FROM Employees E
    JOIN Reports R ON E.ManagerID = R.EmployeeID
)
SELECT * FROM Reports;

-- 8. Derived table to find employees with the most sales in the last 6 months
SELECT TOP 5 E.EmployeeID, E.FirstName, E.LastName, SalesTotal
FROM (
    SELECT S.EmployeeID, SUM(S.SalesAmount) AS SalesTotal
    FROM Sales S
    WHERE S.SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY S.EmployeeID
) AS EmployeeSales
JOIN Employees E ON E.EmployeeID = EmployeeSales.EmployeeID
ORDER BY SalesTotal DESC;

-- 9. Recursive CTE to calculate total cost of an order with taxes and discounts
WITH OrderCosts AS (
    SELECT OrderID, ProductID, Quantity, Price, TaxRate, Discount, 
           (Quantity * Price * (1 + TaxRate) * (1 - Discount)) AS TotalCost
    FROM Orders
)
SELECT * FROM OrderCosts;

-- 10. CTE to find employees with the largest sales growth rate over the past year
WITH SalesGrowth AS (
    SELECT S.EmployeeID, 
           SUM(CASE WHEN S.SaleDate >= DATEADD(YEAR, -1, GETDATE()) THEN S.SalesAmount ELSE 0 END) AS LastYearSales,
           SUM(S.SalesAmount) AS TotalSales
    FROM Sales S
    GROUP BY S.EmployeeID
)
SELECT EmployeeID, (LastYearSales / NULLIF(TotalSales, 0)) AS GrowthRate
FROM SalesGrowth
ORDER BY GrowthRate DESC;

-- 11. Recursive CTE to calculate total number of sales for each employee over all years
WITH EmployeeSales AS (
    SELECT EmployeeID, COUNT(SalesID) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT * FROM EmployeeSales;

-- 12. CTE and Derived Table to find the highest-selling product and the employee who sold it
WITH SalesData AS (
    SELECT S.ProductID, S.EmployeeID, SUM(S.SalesAmount) AS TotalSales
    FROM Sales S
    GROUP BY S.ProductID, S.EmployeeID
)
SELECT TOP 1 P.ProductName, E.FirstName, E.LastName, SD.TotalSales
FROM SalesData SD
JOIN Products P ON SD.ProductID = P.ProductID
JOIN Employees E ON SD.EmployeeID = E.EmployeeID
ORDER BY SD.TotalSales DESC;

-- 13. Recursive CTE to calculate all generations of an organization’s hierarchy
WITH OrganizationHierarchy AS (
    SELECT EmployeeID, ManagerID, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT E.EmployeeID, E.ManagerID, OH.Level + 1
    FROM Employees E
    JOIN OrganizationHierarchy OH ON E.ManagerID = OH.EmployeeID
)
SELECT * FROM OrganizationHierarchy;

-- 14. CTE to find employees who made sales greater than the average of their department’s sales
WITH DepartmentSales AS (
    SELECT E.DepartmentID, E.EmployeeID, SUM(S.SalesAmount) AS SalesTotal
    FROM Employees E
    JOIN Sales S ON E.EmployeeID = S.SalesID
    GROUP BY E.DepartmentID, E.EmployeeID
)
SELECT E.EmployeeID, E.FirstName, E.LastName
FROM DepartmentSales DS
JOIN Employees E ON E.EmployeeID = DS.EmployeeID
WHERE DS.SalesTotal > (SELECT AVG(SalesTotal) FROM DepartmentSales);

-- 15. Derived table to find average sales per employee by region
SELECT Region, AVG(TotalSales) AS AvgSalesPerEmployee
FROM (
    SELECT E.Region, E.EmployeeID, SUM(S.SalesAmount) AS TotalSales
    FROM Employees E
    JOIN Sales S ON E.EmployeeID = S.SalesID
    GROUP BY E.Region, E.EmployeeID
) AS RegionSales
GROUP BY Region;

-- 16. Recursive CTE to identify employees reporting to a specific manager
WITH EmployeeReports AS (
    SELECT EmployeeID, ManagerID
    FROM Employees
    WHERE ManagerID = @ManagerID
    UNION ALL
    SELECT E.EmployeeID, E.ManagerID
    FROM Employees E
    JOIN EmployeeReports ER ON E.ManagerID = ER.EmployeeID
)
SELECT * FROM EmployeeReports;

-- 17. CTE to calculate the average number of products sold per employee in the last year
WITH EmployeeProductSales AS (
    SELECT S.EmployeeID, COUNT(S.ProductID) AS ProductsSold
    FROM Sales S
    WHERE S.SaleDate >= DATEADD(YEAR, -1, GETDATE())
    GROUP BY S.EmployeeID
)
SELECT AVG(ProductsSold) AS AvgProductsSold FROM EmployeeProductSales;

-- 18. CTE and Derived Table to analyze sales performance by employee and product category
WITH EmployeeSales AS (
    SELECT S.EmployeeID, P.Category, SUM(S.SalesAmount) AS TotalSales
    FROM Sales S
    JOIN Products P ON S.ProductID = P.ProductID
    GROUP BY S.EmployeeID, P.Category
)
SELECT * FROM EmployeeSales;

-- 19. Recursive CTE to list all departments reporting to a specific parent department
WITH DepartmentHierarchy AS (
    SELECT DepartmentID, ParentDepartmentID
    FROM Departments
    WHERE ParentDepartmentID = @ParentDepartmentID
    UNION ALL
    SELECT D.DepartmentID, D.ParentDepartmentID
    FROM Departments D
    JOIN DepartmentHierarchy DH ON D.ParentDepartmentID = DH.DepartmentID
)
SELECT * FROM DepartmentHierarchy;

-- 20. Recursive CTE to calculate levels in a product category hierarchy
WITH CategoryLevels AS (
    SELECT CategoryID, ParentCategoryID, 1 AS Level
    FROM Categories
    WHERE ParentCategoryID IS NULL
    UNION ALL
    SELECT C.CategoryID, C.ParentCategoryID, CL.Level + 1
    FROM Categories C
    JOIN CategoryLevels CL ON C.ParentCategoryID = CL.CategoryID
)
SELECT * FROM CategoryLevels;
