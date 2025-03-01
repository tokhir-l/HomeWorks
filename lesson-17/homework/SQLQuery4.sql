--Easy
-- 1. List all items where the price is greater than the average price of all items.
SELECT * FROM Items WHERE Price > (SELECT AVG(Price) FROM Items);

-- 2. Find staff members who have worked in a division that employs more than 10 people.
SELECT * FROM Staff WHERE DivisionID IN (SELECT DivisionID FROM Divisions WHERE EmployeeCount > 10);

-- 3. List staff whose salary exceeds the average salary in their division.
SELECT * FROM Staff S WHERE Salary > (SELECT AVG(Salary) FROM Staff WHERE DivisionID = S.DivisionID);

-- 4. Find all clients who have made a purchase.
SELECT * FROM Clients WHERE ClientID IN (SELECT DISTINCT ClientID FROM Purchases);

-- 5. Retrieve all purchases that include at least one detail in PurchaseDetails.
SELECT * FROM Purchases WHERE EXISTS (SELECT 1 FROM PurchaseDetails WHERE Purchases.PurchaseID = PurchaseDetails.PurchaseID);

-- 6. List all items sold more than 100 times.
SELECT * FROM Items WHERE ItemID IN (SELECT ItemID FROM PurchaseDetails GROUP BY ItemID HAVING SUM(Quantity) > 100);

-- 7. List staff who earn more than the company’s average salary.
SELECT * FROM Staff WHERE Salary > (SELECT AVG(Salary) FROM Staff);

-- 8. Find all vendors supplying items priced below $50.
SELECT * FROM Vendors WHERE VendorID IN (SELECT VendorID FROM Items WHERE Price < 50);

-- 9. Determine the maximum item price.
SELECT MAX(Price) AS MaxPrice FROM Items;

-- 10. Find the highest total purchase value.
SELECT MAX(TotalAmount) AS HighestPurchase FROM (SELECT PurchaseID, SUM(Quantity * Price) AS TotalAmount FROM PurchaseDetails GROUP BY PurchaseID) AS SubQuery;

-- 11. List clients who have never made a purchase.
SELECT * FROM Clients WHERE ClientID NOT IN (SELECT DISTINCT ClientID FROM Purchases);

-- 12. List all items that belong to the category "Electronics."
SELECT * FROM Items WHERE Category = 'Electronics';

-- 13. List all purchases made after a specified date.
SELECT * FROM Purchases WHERE PurchaseDate > '2024-01-01';

-- 14. Calculate the total number of items sold in a particular purchase.
SELECT PurchaseID, SUM(Quantity) AS TotalItems FROM PurchaseDetails GROUP BY PurchaseID;

-- 15. List staff members employed for more than 5 years.
SELECT * FROM Staff WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 5;

-- 16. List staff whose salary exceeds the average salary in their division.
SELECT * FROM Staff S WHERE Salary > (SELECT AVG(Salary) FROM Staff WHERE DivisionID = S.DivisionID);

-- 17. List purchases that include an item from the Items table.
SELECT * FROM Purchases WHERE EXISTS (SELECT 1 FROM PurchaseDetails PD WHERE PD.PurchaseID = Purchases.PurchaseID AND PD.ItemID IN (SELECT ItemID FROM Items));

-- 18. Find clients who made a purchase within the last 30 days.
SELECT * FROM Clients WHERE ClientID IN (SELECT ClientID FROM Purchases WHERE PurchaseDate >= DATEADD(DAY, -30, GETDATE()));

-- 19. Identify the oldest item in the Items table.
SELECT * FROM Items WHERE AddedDate = (SELECT MIN(AddedDate) FROM Items);

-- 20. List staff members not assigned to any division.
SELECT * FROM Staff WHERE DivisionID IS NULL;


--Medium
-- 1. Find all staff who work in the same division as any staff member earning over $100,000
SELECT * FROM Staff 
WHERE DivisionID IN (
    SELECT DISTINCT DivisionID FROM Staff WHERE Salary > 100000
);

-- 2. List all staff members who have the highest salary in their division
SELECT * FROM Staff S1 
WHERE Salary = (
    SELECT MAX(Salary) FROM Staff S2 WHERE S1.DivisionID = S2.DivisionID
);

-- 3. List all clients who have made purchases but never bought an item priced above $200
SELECT * FROM Clients 
WHERE ClientID IN (
    SELECT DISTINCT ClientID FROM Purchases 
    WHERE PurchaseID NOT IN (
        SELECT DISTINCT PurchaseID FROM PurchaseDetails WHERE Price > 200
    )
);

-- 4. Find items that have been ordered more frequently than the average item
SELECT * FROM Items 
WHERE ItemID IN (
    SELECT ItemID FROM PurchaseDetails 
    GROUP BY ItemID HAVING COUNT(*) > (
        SELECT AVG(ItemCount) FROM (
            SELECT COUNT(*) AS ItemCount FROM PurchaseDetails GROUP BY ItemID
        ) AS AvgItems
    )
);

-- 5. List clients who have placed more than 3 purchases
SELECT * FROM Clients 
WHERE ClientID IN (
    SELECT ClientID FROM Purchases 
    GROUP BY ClientID HAVING COUNT(*) > 3
);

-- 6. Calculate the number of items ordered in the last 30 days by each client
SELECT ClientID, (SELECT SUM(Quantity) FROM PurchaseDetails 
                  WHERE PurchaseID IN (
                      SELECT PurchaseID FROM Purchases 
                      WHERE PurchaseDate >= DATEADD(DAY, -30, GETDATE())
                  )
                 ) AS TotalItemsOrdered
FROM Clients;

-- 7. List staff whose salary exceeds the average salary of all staff in their division
SELECT * FROM Staff S1
WHERE Salary > (
    SELECT AVG(Salary) FROM Staff S2 WHERE S1.DivisionID = S2.DivisionID
);

-- 8. List items that have never been ordered
SELECT * FROM Items 
WHERE ItemID NOT IN (
    SELECT DISTINCT ItemID FROM PurchaseDetails
);

-- 9. List all vendors who supply items priced above the average price of items
SELECT * FROM Vendors 
WHERE VendorID IN (
    SELECT DISTINCT VendorID FROM Items 
    WHERE Price > (SELECT AVG(Price) FROM Items)
);

-- 10. Compute total sales for each item in the past year
SELECT ItemID, (SELECT SUM(Quantity * Price) FROM PurchaseDetails 
                WHERE PurchaseID IN (
                    SELECT PurchaseID FROM Purchases 
                    WHERE PurchaseDate >= DATEADD(YEAR, -1, GETDATE())
                )
               ) AS TotalSales
FROM Items;

-- 11. List staff members older than the overall average age of the company
SELECT * FROM Staff 
WHERE Age > (SELECT AVG(Age) FROM Staff);

-- 12. List items with a price greater than the average price in the Items table
SELECT * FROM Items 
WHERE Price > (SELECT AVG(Price) FROM Items);

-- 13. Find clients who have purchased items from a specific category
SELECT * FROM Clients 
WHERE ClientID IN (
    SELECT DISTINCT ClientID FROM Purchases 
    WHERE PurchaseID IN (
        SELECT DISTINCT PurchaseID FROM PurchaseDetails PD
        JOIN Items I ON PD.ItemID = I.ItemID
        WHERE I.Category = 'SpecificCategory'
    )
);

-- 14. List all items with a quantity available greater than the average stock level
SELECT * FROM Items 
WHERE QuantityAvailable > (SELECT AVG(QuantityAvailable) FROM Items);

-- 15. List all staff who work in the same division as those who have received a bonus
SELECT * FROM Staff 
WHERE DivisionID IN (
    SELECT DISTINCT DivisionID FROM Staff WHERE Bonus IS NOT NULL
);

-- 16. List staff members with salaries in the top 10% of all staff
SELECT * FROM Staff 
WHERE Salary >= (
    SELECT PERCENTILE_CONT(0.90) WITHIN GROUP (ORDER BY Salary) FROM Staff
);

-- 17. Identify the division that employs the most staff
SELECT TOP 1 DivisionID, COUNT(*) AS EmployeeCount
FROM Staff 
GROUP BY DivisionID 
ORDER BY EmployeeCount DESC;

-- 18. Find the purchase with the highest total value
SELECT * FROM Purchases 
WHERE PurchaseID = (
    SELECT TOP 1 PurchaseID FROM (
        SELECT PurchaseID, SUM(Quantity * Price) AS TotalValue FROM PurchaseDetails 
        GROUP BY PurchaseID
    ) AS PurchaseTotals ORDER BY TotalValue DESC
);

-- 19. List staff who earn more than the average salary of their division and have more than 5 years of service
SELECT * FROM Staff S1
WHERE Salary > (
    SELECT AVG(Salary) FROM Staff S2 WHERE S1.DivisionID = S2.DivisionID
) AND YearsOfService > 5;

-- 20. List clients who have never purchased an item with a price higher than $100
SELECT * FROM Clients 
WHERE ClientID NOT IN (
    SELECT DISTINCT ClientID FROM Purchases 
    WHERE PurchaseID IN (
        SELECT DISTINCT PurchaseID FROM PurchaseDetails WHERE Price > 100
    )
);


--Hard
-- 1. List all staff who earn more than the average salary in their division, excluding the highest earner in that division
SELECT * FROM Staff S
WHERE Salary > (SELECT AVG(Salary) FROM Staff WHERE DivisionID = S.DivisionID)
AND Salary < (SELECT MAX(Salary) FROM Staff WHERE DivisionID = S.DivisionID);

-- 2. List items purchased by clients with more than 5 orders
SELECT DISTINCT ItemID FROM Purchases P
WHERE ClientID IN (SELECT ClientID FROM Purchases GROUP BY ClientID HAVING COUNT(PurchaseID) > 5);

-- 3. List staff older than the company average age and earning more than the average salary
SELECT * FROM Staff
WHERE Age > (SELECT AVG(Age) FROM Staff) AND Salary > (SELECT AVG(Salary) FROM Staff);

-- 4. List staff in divisions with more than 5 members earning over $100,000
SELECT * FROM Staff S
WHERE DivisionID IN (SELECT DivisionID FROM Staff WHERE Salary > 100000 GROUP BY DivisionID HAVING COUNT(*) > 5);

-- 5. List items not purchased in the past year
SELECT * FROM Items
WHERE ItemID NOT IN (SELECT DISTINCT ItemID FROM Purchases WHERE PurchaseDate >= DATEADD(YEAR, -1, GETDATE()));

-- 6. List clients who bought items from at least two categories
SELECT ClientID FROM Purchases P
JOIN Items I ON P.ItemID = I.ItemID
GROUP BY ClientID HAVING COUNT(DISTINCT I.CategoryID) >= 2;

-- 7. List staff earning more than the average salary in their job position
SELECT * FROM Staff S
WHERE Salary > (SELECT AVG(Salary) FROM Staff WHERE PositionID = S.PositionID);

-- 8. List items in the top 10% by price
SELECT * FROM Items
WHERE Price >= (SELECT TOP 10 PERCENT Price FROM Items ORDER BY Price DESC);

-- 9. List staff in the top 10% salary within their division
SELECT * FROM Staff S
WHERE Salary >= (SELECT TOP 10 PERCENT Salary FROM Staff WHERE DivisionID = S.DivisionID ORDER BY Salary DESC);

-- 10. List staff who haven't received a bonus in the last 6 months
SELECT * FROM Staff
WHERE StaffID NOT IN (SELECT StaffID FROM Bonuses WHERE BonusDate >= DATEADD(MONTH, -6, GETDATE()));

-- 11. List items ordered more frequently than the average order per item
SELECT ItemID FROM PurchaseDetails
GROUP BY ItemID HAVING COUNT(*) > (SELECT AVG(OrderCount) FROM (SELECT COUNT(*) AS OrderCount FROM PurchaseDetails GROUP BY ItemID) AS AvgOrders);

-- 12. List clients who made purchases last year for items above the average price
SELECT DISTINCT ClientID FROM Purchases P
JOIN Items I ON P.ItemID = I.ItemID
WHERE PurchaseDate BETWEEN DATEADD(YEAR, -1, GETDATE()) AND GETDATE()
AND I.Price > (SELECT AVG(Price) FROM Items);

-- 13. Identify division with the highest average salary
SELECT TOP 1 DivisionID FROM Staff
GROUP BY DivisionID ORDER BY AVG(Salary) DESC;

-- 14. List items purchased by clients with more than 10 orders
SELECT DISTINCT ItemID FROM Purchases
WHERE ClientID IN (SELECT ClientID FROM Purchases GROUP BY ClientID HAVING COUNT(PurchaseID) > 10);

-- 15. List staff in the division with the highest total sales
SELECT * FROM Staff
WHERE DivisionID = (SELECT TOP 1 DivisionID FROM Purchases P
JOIN Staff S ON P.StaffID = S.StaffID
GROUP BY DivisionID ORDER BY SUM(P.TotalAmount) DESC);

-- 16. List staff in the top 5% salary of the company
SELECT * FROM Staff
WHERE Salary >= (SELECT TOP 5 PERCENT Salary FROM Staff ORDER BY Salary DESC);

-- 17. List items not purchased in the past month
SELECT * FROM Items
WHERE ItemID NOT IN (SELECT DISTINCT ItemID FROM Purchases WHERE PurchaseDate >= DATEADD(MONTH, -1, GETDATE()));

-- 18. List staff in the same division as those with highest purchase totals
SELECT DISTINCT S.* FROM Staff S
JOIN Purchases P ON S.StaffID = P.StaffID
WHERE S.DivisionID IN (SELECT DivisionID FROM Purchases GROUP BY DivisionID ORDER BY SUM(TotalAmount) DESC LIMIT 1);

-- 19. List clients who haven't purchased in 6 months and spent less than $100
SELECT * FROM Clients
WHERE ClientID NOT IN (SELECT DISTINCT ClientID FROM Purchases WHERE PurchaseDate >= DATEADD(MONTH, -6, GETDATE()))
AND ClientID IN (SELECT ClientID FROM Purchases GROUP BY ClientID HAVING SUM(TotalAmount) < 100);

-- 20. List staff employed for over 10 years and made purchases worth over $1,000
SELECT * FROM Staff S
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > 10
AND StaffID IN (SELECT StaffID FROM Purchases GROUP BY StaffID HAVING SUM(TotalAmount) > 1000);
