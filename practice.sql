/* =========================================================
   SQL SERVER PRACTICE SCRIPT
   Statements, Clauses, Operators & Functions
   ========================================================= */


/* =========================================================
   1. CREATE DATABASE
   ========================================================= */

-- Create the database only if it doesn't already exist

IF DB_ID('SQL_Practice_DB') IS NULL
BEGIN
    CREATE DATABASE SQL_Practice_DB;
END;
GO


/* =========================================================
   2. USE DATABASE
   ========================================================= */

USE SQL_Practice_DB;
GO


/* =========================================================
   3. CREATE TABLE
   ========================================================= */

-- Drop the table if you want to start from scratch

IF OBJECT_ID('dbo.Students', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Students;
END;
GO

CREATE TABLE dbo.Students
(
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50),
    Email VARCHAR(100),
    AdmissionDate DATE
);
GO


/* =========================================================
   4. INSERT DATA
   ========================================================= */

INSERT INTO dbo.Students
    (StudentID, Name, Age, City, Email, AdmissionDate)
VALUES
    (1, 'John', 20, 'Toronto', 'john@gmail.com', '2025-01-15'),
    (2, 'Mary', 22, 'Montreal', 'mary@gmail.com', '2025-02-20'),
    (3, 'David', 19, 'Toronto', 'david@gmail.com', '2025-03-10'),
    (4, 'Sarah', 25, 'Ottawa', 'sarah@gmail.com', '2025-04-05'),
    (5, 'Mike', 30, 'Toronto', NULL, '2025-05-12'),
    (6, 'Lisa', 21, 'Montreal', 'lisa@gmail.com', '2025-06-18'),
    (7, 'Robert', 28, 'Ottawa', 'robert@gmail.com', '2025-07-22'),
    (8, 'Emma', 24, 'Toronto', 'emma@gmail.com', '2025-08-01'),
    (9, 'James', 35, 'Montreal', NULL, '2025-08-15'),
    (10, 'Sophia', 18, 'Toronto', 'sophia@gmail.com', '2025-09-01');

GO


/* =========================================================
   5. SELECT
   ========================================================= */

-- Select all columns

SELECT *
FROM dbo.Students;


-- Select specific columns

SELECT StudentID, Name, Age
FROM dbo.Students;


/* =========================================================
   6. DISTINCT
   ========================================================= */

-- Show unique cities

SELECT DISTINCT City
FROM dbo.Students;


/* =========================================================
   7. WHERE
   ========================================================= */

-- Students older than 25

SELECT *
FROM dbo.Students
WHERE Age > 25;


-- Students from Toronto

SELECT *
FROM dbo.Students
WHERE City = 'Toronto';


/* =========================================================
   8. COMPARISON OPERATORS
   ========================================================= */

-- Equal

SELECT *
FROM dbo.Students
WHERE Age = 25;


-- Not equal

SELECT *
FROM dbo.Students
WHERE Age != 25;


-- Greater than

SELECT *
FROM dbo.Students
WHERE Age > 25;


-- Less than

SELECT *
FROM dbo.Students
WHERE Age < 25;


-- Greater than or equal

SELECT *
FROM dbo.Students
WHERE Age >= 25;


-- Less than or equal

SELECT *
FROM dbo.Students
WHERE Age <= 25;


/* =========================================================
   9. AND
   ========================================================= */

-- Both conditions must be true

SELECT *
FROM dbo.Students
WHERE Age > 20
AND City = 'Toronto';


/* =========================================================
   10. OR
   ========================================================= */

-- At least one condition must be true

SELECT *
FROM dbo.Students
WHERE City = 'Toronto'
OR City = 'Montreal';


/* =========================================================
   11. NOT
   ========================================================= */

SELECT *
FROM dbo.Students
WHERE NOT City = 'Toronto';


/* =========================================================
   12. BETWEEN
   ========================================================= */

-- Age between 20 and 30

SELECT *
FROM dbo.Students
WHERE Age BETWEEN 20 AND 30;


/* =========================================================
   13. IN
   ========================================================= */

SELECT *
FROM dbo.Students
WHERE City IN ('Toronto', 'Montreal');


/* =========================================================
   14. LIKE
   ========================================================= */

-- Names starting with S

SELECT *
FROM dbo.Students
WHERE Name LIKE 'S%';


-- Names ending with a

SELECT *
FROM dbo.Students
WHERE Name LIKE '%a';


-- Names containing 'ar'

SELECT *
FROM dbo.Students
WHERE Name LIKE '%ar%';


-- Names where second character is 'a'

SELECT *
FROM dbo.Students
WHERE Name LIKE '_a%';


/* =========================================================
   15. IS NULL
   ========================================================= */

-- Students without email

SELECT *
FROM dbo.Students
WHERE Email IS NULL;


-- Students with email

SELECT *
FROM dbo.Students
WHERE Email IS NOT NULL;


/* =========================================================
   16. ORDER BY
   ========================================================= */

-- Sort by age ascending

SELECT *
FROM dbo.Students
ORDER BY Age ASC;


-- Sort by age descending

SELECT *
FROM dbo.Students
ORDER BY Age DESC;


-- Sort by city and then age

SELECT *
FROM dbo.Students
ORDER BY City ASC, Age DESC;


/* =========================================================
   17. TOP
   ========================================================= */

-- Top 5 students

SELECT TOP 5 *
FROM dbo.Students;


-- Five oldest students

SELECT TOP 5 *
FROM dbo.Students
ORDER BY Age DESC;


/* =========================================================
   18. ALIAS USING AS
   ========================================================= */

SELECT
    StudentID AS ID,
    Name AS StudentName,
    Age AS StudentAge
FROM dbo.Students;


/* =========================================================
   19. AGGREGATE FUNCTIONS
   ========================================================= */

-- COUNT

SELECT COUNT(*) AS TotalStudents
FROM dbo.Students;


-- AVG

SELECT AVG(Age) AS AverageAge
FROM dbo.Students;


-- MIN

SELECT MIN(Age) AS YoungestStudent
FROM dbo.Students;


-- MAX

SELECT MAX(Age) AS OldestStudent
FROM dbo.Students;


/* =========================================================
   20. GROUP BY
   ========================================================= */

-- Count students by city

SELECT
    City,
    COUNT(*) AS StudentCount
FROM dbo.Students
GROUP BY City;


/* =========================================================
   21. GROUP BY + AVG
   ========================================================= */

SELECT
    City,
    AVG(Age) AS AverageAge
FROM dbo.Students
GROUP BY City;


/* =========================================================
   22. HAVING
   ========================================================= */

-- Cities having more than 2 students

SELECT
    City,
    COUNT(*) AS StudentCount
FROM dbo.Students
GROUP BY City
HAVING COUNT(*) > 2;


/* =========================================================
   23. WHERE + GROUP BY + HAVING
   ========================================================= */

SELECT
    City,
    COUNT(*) AS StudentCount
FROM dbo.Students
WHERE Age >= 20
GROUP BY City
HAVING COUNT(*) > 1
ORDER BY StudentCount DESC;


/* =========================================================
   24. CASE
   ========================================================= */

SELECT
    Name,
    Age,
    CASE
        WHEN Age < 18 THEN 'Minor'
        WHEN Age BETWEEN 18 AND 24 THEN 'Young Adult'
        WHEN Age BETWEEN 25 AND 34 THEN 'Adult'
        ELSE 'Senior Adult'
    END AS AgeGroup
FROM dbo.Students;


/* =========================================================
   25. UPDATE
   ========================================================= */

-- Update one student's age

UPDATE dbo.Students
SET Age = 21
WHERE StudentID = 1;


-- Verify

SELECT *
FROM dbo.Students
WHERE StudentID = 1;


/* =========================================================
   26. UPDATE MULTIPLE COLUMNS
   ========================================================= */

UPDATE dbo.Students
SET
    Age = 23,
    City = 'Ottawa'
WHERE StudentID = 2;


-- Verify

SELECT *
FROM dbo.Students
WHERE StudentID = 2;


/* =========================================================
   27. DELETE
   ========================================================= */

-- Delete one student

DELETE FROM dbo.Students
WHERE StudentID = 10;


-- Verify

SELECT *
FROM dbo.Students;


/* =========================================================
   28. ALTER TABLE
   ========================================================= */

-- Add a new column

ALTER TABLE dbo.Students
ADD PhoneNumber VARCHAR(20);
GO


-- Check the table

SELECT *
FROM dbo.Students;


/* =========================================================
   29. CAST
   ========================================================= */

-- Convert VARCHAR to INT

SELECT CAST('25' AS INT) AS ConvertedNumber;


-- Convert INT to VARCHAR

SELECT CAST(25 AS VARCHAR(10)) AS ConvertedText;


/* =========================================================
   30. CONVERT
   ========================================================= */

-- Convert VARCHAR to INT

SELECT CONVERT(INT, '25') AS ConvertedNumber;


-- Convert date to VARCHAR

SELECT CONVERT(VARCHAR(10), GETDATE(), 101) AS FormattedDate;


/* =========================================================
   31. DATE FUNCTIONS
   ========================================================= */

-- Current date and time

SELECT GETDATE() AS CurrentDateTime;


-- Current year

SELECT YEAR(GETDATE()) AS CurrentYear;


-- Current month

SELECT MONTH(GETDATE()) AS CurrentMonth;


-- Current day

SELECT DAY(GETDATE()) AS CurrentDay;


/* =========================================================
   32. DATEDIFF
   ========================================================= */

SELECT
    Name,
    AdmissionDate,
    DATEDIFF(DAY, AdmissionDate, GETDATE()) AS DaysSinceAdmission
FROM dbo.Students;


/* =========================================================
   33. DATEADD
   ========================================================= */

-- Add 30 days to admission date

SELECT
    Name,
    AdmissionDate,
    DATEADD(DAY, 30, AdmissionDate) AS DateAfter30Days
FROM dbo.Students;


/* =========================================================
   34. STRING FUNCTIONS
   ========================================================= */

-- Convert names to uppercase

SELECT
    Name,
    UPPER(Name) AS UpperName
FROM dbo.Students;


-- Convert names to lowercase

SELECT
    Name,
    LOWER(Name) AS LowerName
FROM dbo.Students;


-- Length of names

SELECT
    Name,
    LEN(Name) AS NameLength
FROM dbo.Students;


-- First 3 characters

SELECT
    Name,
    LEFT(Name, 3) AS FirstThreeCharacters
FROM dbo.Students;


-- Last 3 characters

SELECT
    Name,
    RIGHT(Name, 3) AS LastThreeCharacters
FROM dbo.Students;


/* =========================================================
   35. CREATE SECOND TABLE FOR JOINS
   ========================================================= */

IF OBJECT_ID('dbo.Courses', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Courses;
END;
GO

CREATE TABLE dbo.Courses
(
    CourseID INT PRIMARY KEY,
    StudentID INT,
    CourseName VARCHAR(100),
    Grade INT
);
GO


INSERT INTO dbo.Courses
    (CourseID, StudentID, CourseName, Grade)
VALUES
    (101, 1, 'SQL', 85),
    (102, 2, 'Python', 90),
    (103, 3, 'SQL', 78),
    (104, 4, 'Python', 88),
    (105, 5, 'Data Analysis', 92),
    (106, 6, 'SQL', 80),
    (107, 7, 'Python', 75),
    (108, 8, 'Data Analysis', 95);

GO


/* =========================================================
   36. INNER JOIN
   ========================================================= */

SELECT
    s.StudentID,
    s.Name,
    c.CourseName,
    c.Grade
FROM dbo.Students AS s
INNER JOIN dbo.Courses AS c
    ON s.StudentID = c.StudentID;


/* =========================================================
   37. LEFT JOIN
   ========================================================= */

SELECT
    s.StudentID,
    s.Name,
    c.CourseName,
    c.Grade
FROM dbo.Students AS s
LEFT JOIN dbo.Courses AS c
    ON s.StudentID = c.StudentID;


/* =========================================================
   38. RIGHT JOIN
   ========================================================= */

SELECT
    s.StudentID,
    s.Name,
    c.CourseName,
    c.Grade
FROM dbo.Students AS s
RIGHT JOIN dbo.Courses AS c
    ON s.StudentID = c.StudentID;


/* =========================================================
   39. FULL OUTER JOIN
   ========================================================= */

SELECT
    s.StudentID,
    s.Name,
    c.CourseName,
    c.Grade
FROM dbo.Students AS s
FULL OUTER JOIN dbo.Courses AS c
    ON s.StudentID = c.StudentID;


/* =========================================================
   40. JOIN + WHERE
   ========================================================= */

SELECT
    s.Name,
    s.City,
    c.CourseName,
    c.Grade
FROM dbo.Students AS s
INNER JOIN dbo.Courses AS c
    ON s.StudentID = c.StudentID
WHERE c.Grade >= 85;


/* =========================================================
   41. UNION
   ========================================================= */

SELECT City
FROM dbo.Students

UNION

SELECT CourseName
FROM dbo.Courses;


/* =========================================================
   42. UNION ALL
   ========================================================= */

SELECT City
FROM dbo.Students

UNION ALL

SELECT CourseName
FROM dbo.Courses;


/* =========================================================
   43. SUBQUERY
   ========================================================= */

-- Students older than the average student

SELECT *
FROM dbo.Students
WHERE Age >
(
    SELECT AVG(Age)
    FROM dbo.Students
);


/* =========================================================
   44. CTE - COMMON TABLE EXPRESSION
   ========================================================= */

WITH StudentData AS
(
    SELECT
        StudentID,
        Name,
        Age,
        City
    FROM dbo.Students
    WHERE Age >= 20
)
SELECT *
FROM StudentData;


/* =========================================================
   45. ROW_NUMBER()
   ========================================================= */

SELECT
    Name,
    Age,
    ROW_NUMBER() OVER (ORDER BY Age DESC) AS RowNumber
FROM dbo.Students;


/* =========================================================
   46. RANK()
   ========================================================= */

SELECT
    Name,
    Age,
    RANK() OVER (ORDER BY Age DESC) AS AgeRank
FROM dbo.Students;


/* =========================================================
   47. DENSE_RANK()
   ========================================================= */

SELECT
    Name,
    Age,
    DENSE_RANK() OVER (ORDER BY Age DESC) AS AgeRank
FROM dbo.Students;


/* =========================================================
   48. PARTITION BY
   ========================================================= */

SELECT
    City,
    Name,
    Age,
    ROW_NUMBER() OVER
    (
        PARTITION BY City
        ORDER BY Age DESC
    ) AS CityRank
FROM dbo.Students;


/* =========================================================
   49. LAG()
   ========================================================= */

SELECT
    Name,
    Age,
    LAG(Age) OVER (ORDER BY Age) AS PreviousAge
FROM dbo.Students;


/* =========================================================
   50. LEAD()
   ========================================================= */

SELECT
    Name,
    Age,
    LEAD(Age) OVER (ORDER BY Age) AS NextAge
FROM dbo.Students;


/* =========================================================
   51. COMBINED REAL-WORLD QUERY
   ========================================================= */

SELECT
    s.City,
    COUNT(*) AS TotalStudents,
    AVG(s.Age) AS AverageAge,
    MAX(s.Age) AS OldestStudent
FROM dbo.Students AS s
WHERE s.Age >= 18
GROUP BY s.City
HAVING COUNT(*) >= 2
ORDER BY TotalStudents DESC;


/* =========================================================
   52. ADVANCED COMBINED QUERY
   ========================================================= */

WITH StudentScores AS
(
    SELECT
        s.StudentID,
        s.Name,
        s.City,
        c.CourseName,
        c.Grade,
        RANK() OVER
        (
            PARTITION BY c.CourseName
            ORDER BY c.Grade DESC
        ) AS CourseRank
    FROM dbo.Students AS s
    INNER JOIN dbo.Courses AS c
        ON s.StudentID = c.StudentID
)
SELECT *
FROM StudentScores
WHERE CourseRank <= 3
ORDER BY CourseName, CourseRank;


/* =========================================================
   53. CHECK TABLE STRUCTURE
   ========================================================= */

SELECT
    COLUMN_NAME,
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Students';


/* =========================================================
   54. CHECK ALL TABLES
   ========================================================= */

SELECT
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


/* =========================================================
   55. FINAL PRACTICE QUERY
   ========================================================= */

SELECT
    s.City,
    COUNT(s.StudentID) AS TotalStudents,
    AVG(s.Age) AS AverageAge,
    MAX(s.Age) AS MaximumAge,
    MIN(s.Age) AS MinimumAge
FROM dbo.Students AS s
WHERE s.Email IS NOT NULL
GROUP BY s.City
HAVING COUNT(s.StudentID) > 1
ORDER BY AverageAge DESC;