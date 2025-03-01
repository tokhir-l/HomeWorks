-- Easy:
-- Task 1: List all staff members using a view
CREATE VIEW vwStaff AS
SELECT * FROM Staff;

SELECT * FROM vwStaff;

-- Task 2: Create a view displaying items and prices
CREATE VIEW vwItemPrices AS
SELECT ItemID, ItemName, Price FROM Items;

SELECT * FROM vwItemPrices;

-- Task 3: Create a temporary table and insert sample data
CREATE TABLE #TempPurchases (
    PurchaseID INT PRIMARY KEY,
    ClientID INT,
    ItemID INT,
    PurchaseDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO #TempPurchases VALUES (1, 101, 5, '2025-03-01', 200.00);

-- Task 4: Declare a temporary variable for total revenue
DECLARE @currentRevenue DECIMAL(10,2);
SET @currentRevenue = (SELECT SUM(Amount) FROM Purchases WHERE MONTH(PurchaseDate) = MONTH(GETDATE()));

PRINT @currentRevenue;

-- Task 5: Create a scalar function to return the square of a number
CREATE FUNCTION fnSquare (@num INT) RETURNS INT AS BEGIN
    RETURN @num * @num;
END;

SELECT dbo.fnSquare(5);

-- Task 6: Create a stored procedure to return all clients
CREATE PROCEDURE spGetClients AS BEGIN
    SELECT * FROM Clients;
END;

EXEC spGetClients;

-- Task 7: Merge Purchases and Clients data
MERGE INTO Purchases AS target
USING Clients AS source
ON target.ClientID = source.ClientID
WHEN MATCHED THEN
    UPDATE SET target.ClientName = source.ClientName;

-- Task 8: Create a temporary table and insert staff details
CREATE TABLE #StaffInfo (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(100),
    Department VARCHAR(50)
);

INSERT INTO #StaffInfo VALUES (1, 'John Doe', 'Sales');

-- Task 9: Create a function to check even or odd numbers
CREATE FUNCTION fnEvenOdd (@num INT) RETURNS VARCHAR(10) AS BEGIN
    RETURN CASE WHEN @num % 2 = 0 THEN 'Even' ELSE 'Odd' END;
END;

SELECT dbo.fnEvenOdd(7);

-- Task 10: Stored procedure to calculate total revenue for a given month and year
CREATE PROCEDURE spMonthlyRevenue @year INT, @month INT AS BEGIN
    SELECT SUM(Amount) AS TotalRevenue FROM Purchases
    WHERE YEAR(PurchaseDate) = @year AND MONTH(PurchaseDate) = @month;
END;

EXEC spMonthlyRevenue 2025, 2;

-- Task 11: Create a view for total sales per item for the last month
CREATE VIEW vwRecentItemSales AS
SELECT ItemID, SUM(Amount) AS TotalSales FROM Purchases
WHERE PurchaseDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY ItemID;

SELECT * FROM vwRecentItemSales;

-- Task 12: Declare a temporary variable for the current date
DECLARE @currentDate DATE = GETDATE();
PRINT @currentDate;

-- Task 13: Create a view listing high quantity items
CREATE VIEW vwHighQuantityItems AS
SELECT * FROM Items WHERE Quantity > 100;

SELECT * FROM vwHighQuantityItems;

-- Task 14: Create a temporary table and join it with Purchases
CREATE TABLE #ClientOrders (
    OrderID INT PRIMARY KEY,
    ClientID INT,
    OrderDate DATE
);

INSERT INTO #ClientOrders VALUES (1, 101, '2025-02-25');

SELECT co.*, p.* FROM #ClientOrders co
JOIN Purchases p ON co.ClientID = p.ClientID;

-- Task 15: Create a stored procedure to get staff details
CREATE PROCEDURE spStaffDetails @StaffID INT AS BEGIN
    SELECT StaffName, Department FROM Staff WHERE StaffID = @StaffID;
END;

EXEC spStaffDetails 1;

-- Task 16: Create a function to add two numbers
CREATE FUNCTION fnAddNumbers (@num1 INT, @num2 INT) RETURNS INT AS BEGIN
    RETURN @num1 + @num2;
END;

SELECT dbo.fnAddNumbers(10, 20);

-- Task 17: MERGE statement to update Items pricing from a temporary table
CREATE TABLE #NewItemPrices (
    ItemID INT PRIMARY KEY,
    NewPrice DECIMAL(10,2)
);

INSERT INTO #NewItemPrices VALUES (5, 150.00);

MERGE INTO Items AS target
USING #NewItemPrices AS source
ON target.ItemID = source.ItemID
WHEN MATCHED THEN
    UPDATE SET target.Price = source.NewPrice;

-- Task 18: Create a view to display staff salaries
CREATE VIEW vwStaffSalaries AS
SELECT StaffName, Salary FROM Staff;

SELECT * FROM vwStaffSalaries;

-- Task 19: Stored procedure to return purchases for a specific client
CREATE PROCEDURE spClientPurchases @ClientID INT AS BEGIN
    SELECT * FROM Purchases WHERE ClientID = @ClientID;
END;

EXEC spClientPurchases 101;

-- Task 20: Function to return string length
CREATE FUNCTION fnStringLength (@input VARCHAR(255)) RETURNS INT AS BEGIN
    RETURN LEN(@input);
END;

SELECT dbo.fnStringLength('Hello World!');


--Medium
-- Task 1: Create a view vwClientOrderHistory
CREATE VIEW vwClientOrderHistory AS
SELECT c.ClientID, c.ClientName, p.PurchaseID, p.PurchaseDate, p.TotalAmount
FROM Clients c
JOIN Purchases p ON c.ClientID = p.ClientID;

-- Task 2: Create a temporary table #YearlyItemSales
CREATE TABLE #YearlyItemSales (
    ItemID INT,
    ItemName VARCHAR(255),
    Year INT,
    TotalSales INT
);

-- Task 3: Create a stored procedure spUpdatePurchaseStatus
CREATE PROCEDURE spUpdatePurchaseStatus (@PurchaseID INT, @NewStatus VARCHAR(50))
AS
BEGIN
    UPDATE Purchases
    SET Status = @NewStatus
    WHERE PurchaseID = @PurchaseID;
END;

-- Task 4: Write a MERGE statement for Purchases
MERGE INTO Purchases AS target
USING (SELECT PurchaseID, ClientID, PurchaseDate, TotalAmount FROM #NewPurchases) AS source
ON target.PurchaseID = source.PurchaseID
WHEN MATCHED THEN
    UPDATE SET target.PurchaseDate = source.PurchaseDate, target.TotalAmount = source.TotalAmount
WHEN NOT MATCHED THEN
    INSERT (PurchaseID, ClientID, PurchaseDate, TotalAmount)
    VALUES (source.PurchaseID, source.ClientID, source.PurchaseDate, source.TotalAmount);

-- Task 5: Declare a temporary variable for average sale
DECLARE @avgItemSale DECIMAL(10,2);
SET @avgItemSale = (SELECT AVG(TotalAmount) FROM Purchases WHERE ItemID = 1);

-- Task 6: Create a view vwItemOrderDetails
CREATE VIEW vwItemOrderDetails AS
SELECT p.PurchaseID, i.ItemName, p.Quantity
FROM Purchases p
JOIN Items i ON p.ItemID = i.ItemID;

-- Task 7: Create a function fnCalcDiscount
CREATE FUNCTION fnCalcDiscount (@OrderAmount DECIMAL(10,2), @DiscountRate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @OrderAmount * (@DiscountRate / 100);
END;

-- Task 8: Create a stored procedure spDeleteOldPurchases
CREATE PROCEDURE spDeleteOldPurchases (@CutoffDate DATE)
AS
BEGIN
    DELETE FROM Purchases WHERE PurchaseDate < @CutoffDate;
END;

-- Task 9: Write a MERGE statement for updating staff salaries
MERGE INTO Staff AS target
USING (SELECT StaffID, NewSalary FROM #SalaryUpdates) AS source
ON target.StaffID = source.StaffID
WHEN MATCHED THEN
    UPDATE SET target.Salary = source.NewSalary;

-- Task 10: Create a view vwStaffRevenue
CREATE VIEW vwStaffRevenue AS
SELECT s.StaffID, s.StaffName, SUM(p.TotalAmount) AS TotalRevenue
FROM Staff s
JOIN Sales p ON s.StaffID = p.StaffID
GROUP BY s.StaffID, s.StaffName;

-- Task 11: Create a function fnWeekdayName
CREATE FUNCTION fnWeekdayName (@InputDate DATE)
RETURNS VARCHAR(20)
AS
BEGIN
    RETURN DATENAME(WEEKDAY, @InputDate);
END;

-- Task 12: Create a temporary table #TempStaff
CREATE TABLE #TempStaff (
    StaffID INT,
    StaffName VARCHAR(100),
    Department VARCHAR(50)
);
INSERT INTO #TempStaff (StaffID, StaffName, Department)
SELECT StaffID, StaffName, Department FROM Staff;

-- Task 13: Store and display a client's total number of purchases
DECLARE @TotalPurchases INT;
SELECT @TotalPurchases = COUNT(*) FROM Purchases WHERE ClientID = 1;
PRINT @TotalPurchases;

-- Task 14: Create a stored procedure spClientDetails
CREATE PROCEDURE spClientDetails (@ClientID INT)
AS
BEGIN
    SELECT * FROM Clients WHERE ClientID = @ClientID;
    SELECT * FROM Purchases WHERE ClientID = @ClientID;
END;

-- Task 15: Write a MERGE statement to update stock quantities
MERGE INTO Items AS target
USING (SELECT ItemID, Quantity FROM Delivery) AS source
ON target.ItemID = source.ItemID
WHEN MATCHED THEN
    UPDATE SET target.Quantity = target.Quantity + source.Quantity;

-- Task 16: Create a stored procedure spMultiply
CREATE PROCEDURE spMultiply (@Num1 DECIMAL(10,2), @Num2 DECIMAL(10,2), @Result DECIMAL(10,2) OUTPUT)
AS
BEGIN
    SET @Result = @Num1 * @Num2;
END;

-- Task 17: Create a function fnCalcTax
CREATE FUNCTION fnCalcTax (@Amount DECIMAL(10,2), @TaxRate DECIMAL(5,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Amount * (@TaxRate / 100);
END;

-- Task 18: Create a view vwTopPerformingStaff
CREATE VIEW vwTopPerformingStaff AS
SELECT s.StaffID, s.StaffName, COUNT(p.PurchaseID) AS OrdersHandled
FROM Staff s
JOIN Purchases p ON s.StaffID = p.StaffID
GROUP BY s.StaffID, s.StaffName;

-- Task 19: Write a MERGE statement for synchronizing Clients table
MERGE INTO Clients AS target
USING (SELECT ClientID, ClientName, Email FROM #ClientDataTemp) AS source
ON target.ClientID = source.ClientID
WHEN MATCHED THEN
    UPDATE SET target.ClientName = source.ClientName, target.Email = source.Email
WHEN NOT MATCHED THEN
    INSERT (ClientID, ClientName, Email)
    VALUES (source.ClientID, source.ClientName, source.Email);

-- Task 20: Create a stored procedure spTopItems
CREATE PROCEDURE spTopItems
AS
BEGIN
    SELECT TOP 5 ItemID, ItemName, SUM(Quantity) AS TotalSold
    FROM Purchases
    GROUP BY ItemID, ItemName
    ORDER BY TotalSold DESC;
END;


--Hard
-- Task 1: Stored Procedure to Determine Top Sales Staff
CREATE PROCEDURE spTopSalesStaff (@Year INT)
AS
BEGIN
    SELECT TOP 1 s.StaffID, s.StaffName, SUM(p.TotalAmount) AS TotalRevenue
    FROM Staff s
    JOIN Purchases p ON s.StaffID = p.StaffID
    WHERE YEAR(p.PurchaseDate) = @Year
    GROUP BY s.StaffID, s.StaffName
    ORDER BY TotalRevenue DESC;
END;

-- Task 2: View for Client Order Statistics
CREATE VIEW vwClientOrderStats AS
SELECT c.ClientID, c.ClientName, COUNT(p.PurchaseID) AS PurchaseCount, SUM(p.TotalAmount) AS TotalPurchaseValue
FROM Clients c
LEFT JOIN Purchases p ON c.ClientID = p.ClientID
GROUP BY c.ClientID, c.ClientName;

-- Task 3: MERGE Purchases and Items Tables
MERGE INTO Items AS target
USING Purchases AS source
ON target.ItemID = source.ItemID
WHEN MATCHED THEN
    UPDATE SET target.StockQuantity = target.StockQuantity - source.QuantityOrdered
WHEN NOT MATCHED THEN
    INSERT (ItemID, ItemName, StockQuantity)
    VALUES (source.ItemID, source.ItemName, source.QuantityOrdered);

-- Task 4: Function to Calculate Monthly Revenue
CREATE FUNCTION fnMonthlyRevenue(@Year INT, @Month INT) RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Revenue DECIMAL(10,2);
    SELECT @Revenue = SUM(TotalAmount)
    FROM Purchases
    WHERE YEAR(PurchaseDate) = @Year AND MONTH(PurchaseDate) = @Month;
    RETURN @Revenue;
END;

-- Task 5: Complex Stored Procedure for Order Processing
CREATE PROCEDURE spProcessOrderTotals (@OrderID INT, @TaxRate DECIMAL(5,2), @Discount DECIMAL(5,2))
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10,2);
    SELECT @TotalAmount = SUM(ItemPrice * Quantity)
    FROM OrderDetails
    WHERE OrderID = @OrderID;
    
    SET @TotalAmount = @TotalAmount - (@TotalAmount * @Discount) + (@TotalAmount * @TaxRate);
    
    UPDATE Orders SET TotalAmount = @TotalAmount, OrderStatus = 'Processed'
    WHERE OrderID = @OrderID;
END;

-- Task 6: Temporary Table for Staff Sales Data
CREATE TABLE #StaffSalesData (
    StaffID INT,
    StaffName VARCHAR(100),
    TotalSales DECIMAL(10,2)
);
INSERT INTO #StaffSalesData
SELECT s.StaffID, s.StaffName, SUM(p.TotalAmount)
FROM Staff s
JOIN Purchases p ON s.StaffID = p.StaffID
GROUP BY s.StaffID, s.StaffName;

-- Task 7: MERGE Sales Table with Temporary Sales Data
MERGE INTO Sales AS target
USING #SalesTemp AS source
ON target.SaleID = source.SaleID
WHEN MATCHED THEN
    UPDATE SET target.Amount = source.Amount
WHEN NOT MATCHED THEN
    INSERT (SaleID, Amount)
    VALUES (source.SaleID, source.Amount);

-- Task 8: Stored Procedure for Orders Within Date Range
CREATE PROCEDURE spOrdersByDateRange (@StartDate DATE, @EndDate DATE)
AS
BEGIN
    SELECT * FROM Purchases
    WHERE PurchaseDate BETWEEN @StartDate AND @EndDate;
END;

-- Task 9: Function for Compound Interest Calculation
CREATE FUNCTION fnCompoundInterest(@Principal DECIMAL(10,2), @Rate DECIMAL(5,2), @Time INT) RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Principal * POWER(1 + @Rate / 100, @Time);
END;

-- Task 10: View for Staff Who Exceeded Quotas
CREATE VIEW vwQuotaExceeders AS
SELECT s.StaffID, s.StaffName, SUM(p.TotalAmount) AS TotalSales
FROM Staff s
JOIN Purchases p ON s.StaffID = p.StaffID
GROUP BY s.StaffID, s.StaffName
HAVING SUM(p.TotalAmount) > s.SalesQuota;

-- Task 11: Sync Product Stock Levels
CREATE PROCEDURE spSyncProductStock
AS
BEGIN
    MERGE INTO Stock AS target
    USING ProductStock AS source
    ON target.ProductID = source.ProductID
    WHEN MATCHED THEN
        UPDATE SET target.Quantity = source.Quantity
    WHEN NOT MATCHED THEN
        INSERT (ProductID, Quantity)
        VALUES (source.ProductID, source.Quantity);
END;

-- Task 12: MERGE Staff Records with External Data
MERGE INTO Staff AS target
USING ExternalStaffData AS source
ON target.StaffID = source.StaffID
WHEN MATCHED THEN
    UPDATE SET target.Salary = source.Salary, target.Position = source.Position
WHEN NOT MATCHED THEN
    INSERT (StaffID, Name, Position, Salary)
    VALUES (source.StaffID, source.Name, source.Position, source.Salary);

-- Task 13: Function to Calculate Date Difference in Days
CREATE FUNCTION fnDateDiffDays(@StartDate DATE, @EndDate DATE) RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @StartDate, @EndDate);
END;

-- Task 14: Update Item Prices Based on Sales Data
CREATE PROCEDURE spUpdateItemPrices
AS
BEGIN
    UPDATE Items
    SET Price = Price * 1.1
    WHERE ItemID IN (SELECT ItemID FROM Sales WHERE QuantitySold > 100);
END;

-- Task 15: MERGE Client Data from Temporary Source
MERGE INTO Clients AS target
USING #ClientDataTemp AS source
ON target.ClientID = source.ClientID
WHEN MATCHED THEN
    UPDATE SET target.Name = source.Name, target.Email = source.Email
WHEN NOT MATCHED THEN
    INSERT (ClientID, Name, Email)
    VALUES (source.ClientID, source.Name, source.Email);

-- Task 16: Regional Sales Report
CREATE PROCEDURE spRegionalSalesReport
AS
BEGIN
    SELECT Region, SUM(TotalAmount) AS TotalRevenue, AVG(TotalAmount) AS AvgSale, COUNT(DISTINCT StaffID) AS StaffCount
    FROM Sales
    GROUP BY Region;
END;

-- Task 17: Function to Calculate Profit Margin
CREATE FUNCTION fnProfitMargin(@Cost DECIMAL(10,2), @Revenue DECIMAL(10,2)) RETURNS DECIMAL(5,2)
AS
BEGIN
    RETURN ((@Revenue - @Cost) / @Revenue) * 100;
END;

-- Task 18: Temporary Table for Merging Staff Data
CREATE TABLE #TempStaffMerge (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10,2)
);
MERGE INTO Staff AS target
USING #TempStaffMerge AS source
ON target.StaffID = source.StaffID
WHEN MATCHED THEN
    UPDATE SET target.Name = source.Name, target.Salary = source.Salary;

-- Task 19: Backup Data Before Deletion
CREATE PROCEDURE spBackupData
AS
BEGIN
    INSERT INTO BackupTable SELECT * FROM CriticalData;
    DELETE FROM CriticalData WHERE BackupDate < GETDATE() - 30;
END;

-- Task 20: Ranked Report of Top Sales Staff
CREATE PROCEDURE spTopSalesReport
AS
BEGIN
    SELECT StaffID, StaffName, TotalSales,
           RANK() OVER (ORDER BY TotalSales DESC) AS Rank
    FROM (SELECT s.StaffID, s.StaffName, SUM(p.TotalAmount) AS TotalSales
          FROM Staff s
          JOIN Purchases p ON s.StaffID = p.StaffID
          GROUP BY s.StaffID, s.StaffName) AS SalesReport;
END;
