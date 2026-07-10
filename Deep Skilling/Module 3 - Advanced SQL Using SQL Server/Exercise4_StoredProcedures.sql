USE AdvancedSQLDB;
GO

/*==========================================================
Exercise 1
Stored Procedure to Retrieve Employees by Department
==========================================================*/

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID,
           FirstName,
           LastName,
           DepartmentID,
           Salary,
           JoinDate
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GetEmployeesByDepartment 1;
GO

/*==========================================================
Exercise 2
Modify Stored Procedure to Include Salary
==========================================================*/

ALTER PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT EmployeeID,
           FirstName,
           LastName,
           DepartmentID,
           Salary,
           JoinDate
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GetEmployeesByDepartment 2;
GO

/*==========================================================
Exercise 3
Delete Stored Procedure
==========================================================*/

DROP PROCEDURE sp_GetEmployeesByDepartment;
GO

/*==========================================================
Recreate Procedure (Required for Remaining Exercises)
==========================================================*/

CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

/*==========================================================
Exercise 4
Execute Stored Procedure
==========================================================*/

EXEC sp_GetEmployeesByDepartment 3;
GO

/*==========================================================
Exercise 5
Return Employee Count
==========================================================*/

CREATE PROCEDURE sp_GetEmployeeCount
    @DepartmentID INT
AS
BEGIN
    SELECT COUNT(*) AS TotalEmployees
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

EXEC sp_GetEmployeeCount 1;
GO

/*==========================================================
Exercise 6
Output Parameter
==========================================================*/

CREATE PROCEDURE sp_GetTotalSalary
    @DepartmentID INT,
    @TotalSalary DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @TotalSalary = SUM(Salary)
    FROM Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

DECLARE @Salary DECIMAL(10,2);

EXEC sp_GetTotalSalary
    2,
    @Salary OUTPUT;

SELECT @Salary AS TotalSalary;
GO

/*==========================================================
Exercise 7
Update Employee Salary
==========================================================*/

CREATE PROCEDURE sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @Salary DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary=@Salary
    WHERE EmployeeID=@EmployeeID;
END;
GO

EXEC sp_UpdateEmployeeSalary 1,5500;

SELECT * FROM Employees;
GO

/*==========================================================
Exercise 8
Give Bonus
==========================================================*/

CREATE PROCEDURE sp_GiveBonus
    @DepartmentID INT,
    @Bonus DECIMAL(10,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + @Bonus
    WHERE DepartmentID=@DepartmentID;
END;
GO

EXEC sp_GiveBonus 1,500;

SELECT * FROM Employees;
GO

/*==========================================================
Exercise 9
Transaction
==========================================================*/

CREATE PROCEDURE sp_UpdateSalaryTransaction
    @EmployeeID INT,
    @Salary DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY

        BEGIN TRANSACTION;

        UPDATE Employees
        SET Salary=@Salary
        WHERE EmployeeID=@EmployeeID;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        PRINT ERROR_MESSAGE();

    END CATCH
END;
GO

EXEC sp_UpdateSalaryTransaction 2,6500;

SELECT * FROM Employees;
GO

/*==========================================================
Exercise 10
Dynamic SQL
==========================================================*/

CREATE PROCEDURE sp_SearchEmployee
    @ColumnName NVARCHAR(50),
    @Value NVARCHAR(100)
AS
BEGIN

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL='SELECT * FROM Employees
              WHERE '+QUOTENAME(@ColumnName)+'='''+@Value+'''';

    EXEC sp_executesql @SQL;

END;
GO

EXEC sp_SearchEmployee 'FirstName','John';
GO

/*==========================================================
Exercise 11
Error Handling
==========================================================*/

CREATE PROCEDURE sp_UpdateSalaryWithErrorHandling
    @EmployeeID INT,
    @Salary DECIMAL(10,2)
AS
BEGIN

    BEGIN TRY

        UPDATE Employees
        SET Salary=@Salary
        WHERE EmployeeID=@EmployeeID;

        PRINT 'Salary Updated Successfully';

    END TRY

    BEGIN CATCH

        PRINT 'Error Occurred';

        PRINT ERROR_MESSAGE();

    END CATCH

END;
GO

EXEC sp_UpdateSalaryWithErrorHandling 3,7500;

SELECT * FROM Employees;
GO