USE AdvancedSQLDB;
GO

/*==========================================================
Exercise 1
Create EmployeeChanges Table
==========================================================*/

IF OBJECT_ID('EmployeeChanges','U') IS NOT NULL
DROP TABLE EmployeeChanges;
GO

CREATE TABLE EmployeeChanges
(
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO

/*==========================================================
Exercise 1
AFTER UPDATE Trigger
==========================================================*/

CREATE TRIGGER trg_AfterSalaryUpdate
ON Employees
AFTER UPDATE
AS
BEGIN

    INSERT INTO EmployeeChanges
    (
        EmployeeID,
        OldSalary,
        NewSalary
    )

    SELECT
        d.EmployeeID,
        d.Salary,
        i.Salary
    FROM deleted d
    INNER JOIN inserted i
    ON d.EmployeeID=i.EmployeeID
    WHERE d.Salary<>i.Salary;

END;
GO

-- Test Trigger

UPDATE Employees
SET Salary=6500
WHERE EmployeeID=1;

SELECT * FROM EmployeeChanges;
GO

/*==========================================================
Exercise 2
INSTEAD OF DELETE Trigger
==========================================================*/

CREATE TRIGGER trg_PreventDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN

    PRINT 'Deletion of Employee Records is Not Allowed';

END;
GO

-- Test

DELETE FROM Employees
WHERE EmployeeID=2;

SELECT * FROM Employees;
GO

/*==========================================================
Exercise 3
LOGON Trigger
==========================================================*/

/*
Run this only if your SQL Server allows server-level triggers.

CREATE TRIGGER trg_LogonRestriction
ON ALL SERVER
FOR LOGON
AS
BEGIN

    IF DATEPART(HOUR,GETDATE()) BETWEEN 2 AND 3
    BEGIN

        ROLLBACK;

    END

END;
GO
*/

/*
If the above gives permission errors,
leave it commented.
*/

/*==========================================================
Exercise 4
Modify Trigger
==========================================================*/

ALTER TRIGGER trg_AfterSalaryUpdate
ON Employees
AFTER UPDATE
AS
BEGIN

    INSERT INTO EmployeeChanges
    (
        EmployeeID,
        OldSalary,
        NewSalary,
        ChangeDate
    )

    SELECT
        d.EmployeeID,
        d.Salary,
        i.Salary,
        GETDATE()

    FROM deleted d
    INNER JOIN inserted i
    ON d.EmployeeID=i.EmployeeID

    WHERE d.Salary<>i.Salary;

END;
GO

-- Test

UPDATE Employees
SET Salary=7000
WHERE EmployeeID=1;

SELECT * FROM EmployeeChanges;
GO

/*==========================================================
Exercise 5
Delete Trigger
==========================================================*/

DROP TRIGGER trg_PreventDelete;
GO

/*==========================================================
Exercise 6
Annual Salary Trigger
==========================================================*/

ALTER TABLE Employees
ADD AnnualSalary DECIMAL(10,2);
GO

UPDATE Employees
SET AnnualSalary=Salary*12;
GO

CREATE TRIGGER trg_UpdateAnnualSalary
ON Employees
AFTER UPDATE
AS
BEGIN

    UPDATE e

    SET AnnualSalary=i.Salary*12

    FROM Employees e
    INNER JOIN inserted i

    ON e.EmployeeID=i.EmployeeID;

END;
GO

-- Test

UPDATE Employees
SET Salary=7500
WHERE EmployeeID=3;

SELECT
EmployeeID,
FirstName,
Salary,
AnnualSalary
FROM Employees;
GO