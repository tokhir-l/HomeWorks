String Functions in SQL Server:
LEN vs. DATALENGTH

LEN(): Returns the number of characters in a string, excluding trailing spaces.
DATALENGTH(): Returns the number of bytes used to store a string. This includes trailing spaces and depends on the data type (e.g., nvarchar stores 2 bytes per character).
CHARINDEX Usage & Importance

CHARINDEX(substring, string, start_position): Finds the starting position of a substring in a string.
Useful for locating specific words or characters within text.
CONCAT vs. + Operator

CONCAT(value1, value2, ...): Automatically converts NULL values to empty strings, preventing errors.
+ operator: Can cause NULL propagation if any operand is NULL.
REPLACE Function Usage

REPLACE(string, old_value, new_value): Replaces occurrences of old_value with new_value in a string.
Used for data cleansing (e.g., replacing incorrect/misspelled words).
SUBSTRING Function

SUBSTRING(string, start, length): Extracts a portion of a string based on position and length.
Mathematical Functions in SQL Server
ROUND Function

ROUND(number, decimal_places, operation): Rounds a number to a specified number of decimal places.
ABS Function

ABS(number): Returns the absolute value.
Example: SELECT ABS(-5) → Returns 5.
POWER vs. EXP

POWER(base, exponent): Raises a number to a power (POWER(2,3) = 8).
EXP(value): Returns e^value (exponential function).
CEILING vs. FLOOR

CEILING(number): Rounds up to the nearest integer.
FLOOR(number): Rounds down to the nearest integer.
Date and Time Functions in SQL Server
GETDATE Function

Returns the current system date and time.
DATEDIFF Function

DATEDIFF(interval, start_date, end_date): Calculates the difference between two dates.
DATEADD Function

DATEADD(interval, number, date): Adds a specific interval (e.g., days, months) to a date.
Example: SELECT DATEADD(DAY, 5, '2025-03-16')
FORMAT Function Usage

FORMAT(date, format, culture): Formats date values for display.
Example: FORMAT(GETDATE(), 'yyyy-MM-dd')


String Functions Example

SELECT UPPER(Name), LOWER(Name), LEN(Name) 
FROM Employees;

Mathematical Functions Example

SELECT ABS(-10), POWER(2,3), ROUND(123.456, 2);

Date Functions Example

SELECT GETDATE(), DATEDIFF(DAY, '2024-01-01', GETDATE()), DATEADD(MONTH, 2, GETDATE());


Use Cases and Performance
Performance Considerations

Functions on indexed columns may reduce performance.
Complex string operations can slow down queries.

Query Optimization Scenarios

Use SUBSTRING for extracting only required parts instead of processing the whole string.
Use ROUND to simplify stored numeric values.

Avoiding Certain Functions

Avoid FORMAT() in large datasets due to performance issues.
Avoid + for string concatenation if NULLs are involved.

Homework Puzzles

Count Spaces in Strings
SELECT LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

Count Character Types
DECLARE @str VARCHAR(1000) = 'AddsfsdfWUES 12*&';

SELECT 
    SUM(IIF(ASCII(SUBSTRING(@str, number, 1)) BETWEEN 65 AND 90, 1, 0)) AS UppercaseCount,
    SUM(IIF(ASCII(SUBSTRING(@str, number, 1)) BETWEEN 97 AND 122, 1, 0)) AS LowercaseCount,
    SUM(IIF(ASCII(SUBSTRING(@str, number, 1)) NOT BETWEEN 65 AND 90 
         AND ASCII(SUBSTRING(@str, number, 1)) NOT BETWEEN 97 AND 122, 1, 0)) AS OtherCount
FROM master.dbo.spt_values
WHERE type = 'P' AND number BETWEEN 1 AND LEN(@str);

Generate Date Sequence
WITH DateSeq AS (
    SELECT @fromdate AS DateValue
    UNION ALL
    SELECT DATEADD(DAY, 1, DateValue)
    FROM DateSeq
    WHERE DateValue < @todate
)
SELECT 
    DateValue, 
    YEAR(DateValue) AS Year, 
    MONTH(DateValue) AS Month, 
    DAY(DateValue) AS Day
FROM DateSeq
OPTION (MAXRECURSION 1000);

Split Column into Two Columns
-- Approach 1: Using SUBSTRING and CHARINDEX
SELECT 
    Id,
    SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1) AS FirstName,
    SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)) AS LastName
FROM TestMultipleColumns;

-- Approach 2: Using PARSENAME (only if using '.' as a separator)
SELECT 
    Id,
    PARSENAME(REPLACE(Name, ',', '.'), 2) AS FirstName,
    PARSENAME(REPLACE(Name, ',', '.'), 1) AS LastName
FROM TestMultipleColumns;

-- Approach 3: Using STRING_SPLIT (SQL Server 2016+)
SELECT 
    Id, 
    value AS NamePart
FROM TestMultipleColumns
CROSS APPLY STRING_SPLIT(Name, ',');