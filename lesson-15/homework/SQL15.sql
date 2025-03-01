-- Task 1: Use a Derived Table to Find Employees with Managers
SELECT e.EmployeeID, e.EmployeeName, m.EmployeeName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;

-- Task 2: Use a CTE to Find Employees with Managers
WITH EmployeeManager AS (
    SELECT e.EmployeeID, e.EmployeeName, m.EmployeeName AS ManagerName
    FROM Employees e
    LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID
)
SELECT * FROM EmployeeManager;

-- Task 3: Compare Results of Derived Table and CTE
-- Both queries return the same result set. CTE improves readability and maintainability for complex queries.

-- Task 4: Find Direct Reports for a Given Manager Using CTE
WITH DirectReports AS (
    SELECT EmployeeID, EmployeeName FROM Employees WHERE ManagerID = 1 -- Change ManagerID as needed
)
SELECT * FROM DirectReports;

-- Task 5: Create a Recursive CTE to Find All Levels of Employees
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, EmployeeName, ManagerID, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.EmployeeName, e.ManagerID, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy;

-- Task 6: Count Number of Employees at Each Level Using Recursive CTE
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, EmployeeName, ManagerID, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.EmployeeName, e.ManagerID, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT Level, COUNT(*) AS EmployeeCount FROM EmployeeHierarchy GROUP BY Level;

-- Task 7: Retrieve Employees Without Managers Using Derived Table
SELECT EmployeeID, EmployeeName FROM Employees WHERE ManagerID IS NULL;

-- Task 8: Retrieve Employees Without Managers Using CTE
WITH NoManagers AS (
    SELECT EmployeeID, EmployeeName FROM Employees WHERE ManagerID IS NULL
)
SELECT * FROM NoManagers;

-- Task 9: Find Employees Reporting to a Specific Manager Using Recursive CTE
WITH Reports AS (
    SELECT EmployeeID, EmployeeName, ManagerID
    FROM Employees
    WHERE ManagerID = 1 -- Change ManagerID as needed
    UNION ALL
    SELECT e.EmployeeID, e.EmployeeName, e.ManagerID
    FROM Employees e
    INNER JOIN Reports r ON e.ManagerID = r.EmployeeID
)
SELECT * FROM Reports;

-- Task 10: Find the Maximum Depth of Management Hierarchy
WITH EmployeeHierarchy AS (
    SELECT EmployeeID, EmployeeName, ManagerID, 1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL
    SELECT e.EmployeeID, e.EmployeeName, e.ManagerID, eh.Level + 1
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT MAX(Level) AS MaxDepth FROM EmployeeHierarchy;
