--Easy
--1
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount,
    SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS RunningTotal
FROM Sales;

--2
SELECT 
    CustomerID, 
    OrderDate, 
    OrderAmount,
    SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeSum
FROM Orders;


--3
SELECT 
    CustomerID, 
    OrderDate, 
    OrderAmount,
    SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM Orders;


--4
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount,
    AVG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS AvgSalesAmount
FROM Sales;


--5
SELECT 
    OrderID, 
    CustomerID, 
    OrderAmount,
    RANK() OVER (ORDER BY OrderAmount DESC) AS OrderRank
FROM Orders;


--6
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount,
    LEAD(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS NextSalesAmount
FROM Sales;


--7
SELECT 
    CustomerID, 
    OrderID, 
    OrderAmount,
    SUM(OrderAmount) OVER (PARTITION BY CustomerID) AS TotalSales
FROM Orders;


--8
SELECT 
    CustomerID, 
    OrderID, 
    COUNT(OrderID) OVER (PARTITION BY CustomerID) AS OrderCount
FROM Orders;


--9
SELECT 
    ProductCategory, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY ProductCategory ORDER BY SaleDate) AS RunningTotal
FROM Sales;

--10
SELECT 
    OrderID, 
    CustomerID, 
    OrderDate, 
    ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS OrderRank
FROM Orders;

--11
SELECT 
    OrderID, 
    CustomerID, 
    OrderDate, 
    OrderAmount, 
    LAG(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousOrderAmount
FROM Orders;

--12
SELECT 
    ProductID, 
    ProductName, 
    Price, 
    NTILE(4) OVER (ORDER BY Price DESC) AS PriceGroup
FROM Products;

--13
SELECT 
    SalesPersonID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY SalesPersonID ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

--14
SELECT 
    ProductID, 
    ProductName, 
    StockQuantity, 
    DENSE_RANK() OVER (ORDER BY StockQuantity DESC) AS StockRank
FROM Products;

--15
SELECT 
    OrderID, 
    CustomerID, 
    OrderDate, 
    OrderAmount, 
    LEAD(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) - OrderAmount AS OrderDifference
FROM Orders;



--16
SELECT 
    ProductID, 
    ProductName, 
    Price, 
    RANK() OVER (ORDER BY Price DESC) AS PriceRank
FROM Products;

--17
SELECT 
    CustomerID, 
    AVG(OrderAmount) AS AverageOrderAmount
FROM Orders
GROUP BY CustomerID;

--18
SELECT 
    EmployeeID, 
    EmployeeName, 
    Salary, 
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

--19
SELECT 
    StoreID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY StoreID ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

--20
SELECT 
    OrderID, 
    CustomerID, 
    OrderDate, 
    OrderAmount, 
    LAG(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousOrderAmount
FROM Orders;


--Medium
---- 1. Calculate the cumulative sum of SalesAmount for each employee in the Sales table
SELECT 
    EmployeeID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

-- 2. Calculate the difference in OrderAmount between the current row and the next row using LEAD()
SELECT 
    OrderID, 
    CustomerID, 
    OrderAmount, 
    LEAD(OrderAmount) OVER (ORDER BY OrderDate) - OrderAmount AS OrderAmountDifference
FROM Orders;

-- 3. Find the top 5 products based on SalesAmount using ROW_NUMBER()
SELECT * FROM (
    SELECT 
        ProductID, 
        SUM(SalesAmount) AS TotalSales, 
        ROW_NUMBER() OVER (ORDER BY SUM(SalesAmount) DESC) AS Rank
    FROM Sales
    GROUP BY ProductID
) AS RankedSales
WHERE Rank <= 5;

-- 4. Determine the products with the top 10 sales using RANK()
SELECT * FROM (
    SELECT 
        ProductID, 
        SUM(SalesAmount) AS TotalSales, 
        RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM Sales
    GROUP BY ProductID
) AS RankedProducts
WHERE SalesRank <= 10;

-- 5. Calculate the number of orders per product using COUNT()
SELECT 
    ProductID, 
    COUNT(OrderID) AS OrderCount
FROM Sales
GROUP BY ProductID;

-- 6. Calculate the running total of SalesAmount for each ProductCategory
SELECT 
    ProductCategory, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY ProductCategory ORDER BY SaleDate) AS RunningTotal
FROM Sales;

-- 7. Rank employees by Salary within each DepartmentID using DENSE_RANK()
SELECT 
    EmployeeID, 
    DepartmentID, 
    Salary, 
    DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- 8. Calculate the moving average of SalesAmount for each product
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    AVG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Sales;

-- 9. Divide products into 3 groups based on Price using NTILE(3)
SELECT 
    ProductID, 
    ProductName, 
    Price, 
    NTILE(3) OVER (ORDER BY Price) AS PriceGroup
FROM Products;

-- 10. Find the previous SalesAmount for each employee’s sale using LAG()
SELECT 
    EmployeeID, 
    SaleDate, 
    SalesAmount, 
    LAG(SalesAmount) OVER (PARTITION BY EmployeeID ORDER BY SaleDate) AS PreviousSalesAmount
FROM Sales;

-- 11. Compute the cumulative sum of SalesAmount for each salesperson, ordered by SaleDate
SELECT 
    SalespersonID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY SalespersonID ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

-- 12. Retrieve the SalesAmount of the next sale for each product using LEAD()
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    LEAD(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS NextSalesAmount
FROM Sales;

-- 13. Calculate the moving sum of SalesAmount for each product using a window function
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingSum
FROM Sales;

-- 14. Identify the employees with the top 3 salaries using RANK()
SELECT * FROM (
    SELECT 
        EmployeeID, 
        EmployeeName, 
        Salary, 
        RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank <= 3;

-- 15. Calculate the average order amount for each customer using AVG()
SELECT 
    CustomerID, 
    AVG(OrderAmount) AS AverageOrderAmount
FROM Orders
GROUP BY CustomerID;

-- 16 Assign a unique row number to orders, ordered by OrderDate
SELECT 
    OrderID, 
    CustomerID, 
    OrderDate, 
    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNum
FROM Orders;

-- 17. Calculate the running total of SalesAmount for each employee, partitioned by DepartmentID
SELECT 
    EmployeeID, 
    DepartmentID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY DepartmentID, EmployeeID ORDER BY SaleDate) AS RunningTotal
FROM Sales;

-- 18. Divide employees into 5 equal salary groups using NTILE(5)
SELECT 
    EmployeeID, 
    EmployeeName, 
    Salary, 
    NTILE(5) OVER (ORDER BY Salary) AS SalaryGroup
FROM Employees;

-- 19. Calculate both the cumulative sum of SalesAmount and the total sales for each product
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS CumulativeSales,
    SUM(SalesAmount) OVER (PARTITION BY ProductID) AS TotalSales
FROM Sales;

-- 20. Identify the top 5 highest SalesAmount products using DENSE_RANK()
SELECT * FROM (
    SELECT 
        ProductID, 
        SUM(SalesAmount) AS TotalSales, 
        DENSE_RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM Sales
    GROUP BY ProductID
) AS RankedProducts
WHERE SalesRank <= 5;


-- Difficult
-- 1. Running total of SalesAmount for each product and store
SELECT 
    ProductID, 
    StoreID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY ProductID, StoreID ORDER BY SaleDate) AS RunningTotal
FROM Sales;

-- 2. Percentage change in OrderAmount between the current and next row
SELECT 
    OrderID, 
    CustomerID, 
    OrderDate, 
    OrderAmount, 
    LEAD(OrderAmount) OVER (ORDER BY OrderDate) AS NextOrderAmount,
    (LEAD(OrderAmount) OVER (ORDER BY OrderDate) - OrderAmount) * 100.0 / NULLIF(OrderAmount, 0) AS PercentageChange
FROM Orders;

-- 3. Top 3 products by SalesAmount (handling ties)
SELECT * FROM (
    SELECT 
        ProductID, 
        SUM(SalesAmount) AS TotalSales, 
        ROW_NUMBER() OVER (ORDER BY SUM(SalesAmount) DESC) AS Rank
    FROM Sales
    GROUP BY ProductID
) AS RankedProducts
WHERE Rank <= 3;

-- 4. Rank employees by Salary within each DepartmentID
SELECT 
    EmployeeID, 
    DepartmentID, 
    Salary, 
    RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

-- 5. Top 10% of orders based on OrderAmount using NTILE()
SELECT * FROM (
    SELECT 
        OrderID, 
        OrderAmount, 
        NTILE(10) OVER (ORDER BY OrderAmount DESC) AS OrderGroup
    FROM Orders
) AS OrderRanks
WHERE OrderGroup = 1;

-- 6. Change in SalesAmount between previous and current sale per product
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    SalesAmount - LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS ChangeFromPrevious
FROM Sales;

-- 7. Cumulative average of SalesAmount for each product
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    AVG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeAvg
FROM Sales;

-- 8. Identify top 5 highest SalesAmount products, ignoring ties
SELECT * FROM (
    SELECT 
        ProductID, 
        SUM(SalesAmount) AS TotalSales, 
        DENSE_RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM Sales
    GROUP BY ProductID
) AS RankedProducts
WHERE SalesRank <= 5;

-- 9. Running total of SalesAmount for each category in the Sales table
SELECT 
    ProductCategory, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY ProductCategory ORDER BY SaleDate) AS RunningTotal
FROM Sales;

-- 10. Difference in OrderAmount between previous and next rows
SELECT 
    OrderID, 
    OrderAmount, 
    LAG(OrderAmount) OVER (ORDER BY OrderDate) AS PreviousOrderAmount,
    LEAD(OrderAmount) OVER (ORDER BY OrderDate) AS NextOrderAmount,
    (LEAD(OrderAmount) OVER (ORDER BY OrderDate) - LAG(OrderAmount) OVER (ORDER BY OrderDate)) AS Difference
FROM Orders;

-- 11. Cumulative total of SalesAmount for each salesperson, ordered by SaleDate
SELECT 
    SalespersonID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY SalespersonID ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

-- 12. Divide products into 10 groups based on Price using NTILE(10)
SELECT 
    ProductID, 
    ProductName, 
    Price, 
    NTILE(10) OVER (ORDER BY Price) AS PriceGroup
FROM Products;

-- 13. Moving average of OrderAmount in Orders table
SELECT 
    OrderID, 
    OrderDate, 
    OrderAmount, 
    AVG(OrderAmount) OVER (ORDER BY OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg
FROM Orders;

-- 14. Rank employees by Salary within each department using ROW_NUMBER()
SELECT 
    EmployeeID, 
    DepartmentID, 
    Salary, 
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS Rank
FROM Employees;

-- 15. Number of orders per customer using COUNT()
SELECT 
    CustomerID, 
    COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID;

-- 16. Top 3 products with highest sales numbers using RANK(), considering ties
SELECT * FROM (
    SELECT 
        ProductID, 
        COUNT(SaleID) AS TotalSales, 
        RANK() OVER (ORDER BY COUNT(SaleID) DESC) AS SalesRank
    FROM Sales
    GROUP BY ProductID
) AS RankedProducts
WHERE SalesRank <= 3;

--17 Cumulative sales total for each employee and product
SELECT 
    EmployeeID, 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY EmployeeID, ProductID ORDER BY SaleDate) AS CumulativeSales
FROM Sales;

-- 18. Identify employees with the highest sales within each department using DENSE_RANK()
SELECT * FROM (
    SELECT 
        EmployeeID, 
        DepartmentID, 
        SUM(SalesAmount) AS TotalSales, 
        DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM Sales
    GROUP BY EmployeeID, DepartmentID
) AS RankedEmployees
WHERE SalesRank = 1;

-- 19. Cumulative total of SalesAmount for each store, partitioned by StoreID
SELECT 
    StoreID, 
    SaleDate, 
    SalesAmount, 
    SUM(SalesAmount) OVER (PARTITION BY StoreID ORDER BY SaleDate) AS CumulativeStoreSales
FROM Sales;

-- 20. Difference in SalesAmount for each product between previous and current sale using LAG()
SELECT 
    ProductID, 
    SaleDate, 
    SalesAmount, 
    SalesAmount - LAG(SalesAmount) OVER (PARTITION BY ProductID ORDER BY SaleDate) AS SalesDifference
FROM Sales;


done :)