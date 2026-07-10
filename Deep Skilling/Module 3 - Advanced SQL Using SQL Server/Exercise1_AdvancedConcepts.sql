USE AdvancedSQLDB;
GO

/*==========================================================
Exercise 1 : Ranking and Window Functions
==========================================================*/

/*----------------------------------------------------------
Query 1 : ROW_NUMBER()
Assign a unique rank within each department
----------------------------------------------------------*/

SELECT
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    ROW_NUMBER() OVER
    (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS RowNum
FROM Employees;

GO

/*----------------------------------------------------------
Query 2 : RANK()
----------------------------------------------------------*/

SELECT
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    RANK() OVER
    (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS RankNumber
FROM Employees;

GO

/*----------------------------------------------------------
Query 3 : DENSE_RANK()
----------------------------------------------------------*/

SELECT
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    DENSE_RANK() OVER
    (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS DenseRank
FROM Employees;

GO

/*----------------------------------------------------------
Query 4 : Top 3 Employees in Each Department
----------------------------------------------------------*/

WITH EmployeeRanks AS
(
    SELECT
        EmployeeID,
        FirstName,
        LastName,
        DepartmentID,
        Salary,
        ROW_NUMBER() OVER
        (
            PARTITION BY DepartmentID
            ORDER BY Salary DESC
        ) AS RowNum
    FROM Employees
)

SELECT
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    RowNum
FROM EmployeeRanks
WHERE RowNum <= 3;

GO

/*----------------------------------------------------------
Query 5 : ROW_NUMBER + Department Name
----------------------------------------------------------*/

SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName,
    e.Salary,
    ROW_NUMBER() OVER
    (
        PARTITION BY d.DepartmentName
        ORDER BY e.Salary DESC
    ) AS RowNum
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID;

GO

/*----------------------------------------------------------
Query 6 : Compare all Ranking Functions
----------------------------------------------------------*/

SELECT
    EmployeeID,
    FirstName,
    DepartmentID,
    Salary,

    ROW_NUMBER() OVER
    (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS Row_Number,

    RANK() OVER
    (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS Rank_Number,

    DENSE_RANK() OVER
    (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS Dense_Rank

FROM Employees;

GO