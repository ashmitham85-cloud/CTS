USE AdvancedSQLDB;
GO

/*========================================================
Exercise 1 : Create a Simple View
========================================================*/

CREATE VIEW vw_EmployeeBasicInfo
AS
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

-- View Output
SELECT * FROM vw_EmployeeBasicInfo;
GO


/*========================================================
Exercise 2 : View with Full Name
========================================================*/

CREATE VIEW vw_EmployeeFullName
AS
SELECT
    EmployeeID,
    FirstName + ' ' + LastName AS FullName,
    DepartmentID,
    Salary
FROM Employees;
GO

-- View Output
SELECT * FROM vw_EmployeeFullName;
GO


/*========================================================
Exercise 3 : View with Annual Salary
========================================================*/

CREATE VIEW vw_EmployeeAnnualSalary
AS
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    Salary * 12 AS AnnualSalary
FROM Employees;
GO

-- View Output
SELECT * FROM vw_EmployeeAnnualSalary;
GO


/*========================================================
Exercise 4 : Employee Report View
========================================================*/

CREATE VIEW vw_EmployeeReport
AS
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    d.DepartmentName,
    e.Salary * 12 AS AnnualSalary,
    (e.Salary * 12) * 0.10 AS Bonus
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
GO

-- View Output
SELECT * FROM vw_EmployeeReport;
GO