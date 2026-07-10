USE AdvancedSQLDB;
GO

/*==========================================================
Exercise 1
Basic TRY...CATCH with Error Logging
==========================================================*/

CREATE OR ALTER PROCEDURE AddEmployee
(
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
)
AS
BEGIN
    BEGIN TRY

        INSERT INTO Employees
        (
            EmployeeID,
            FirstName,
            LastName,
            Email,
            DepartmentID,
            Salary,
            JoinDate
        )
        VALUES
        (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @DepartmentID,
            @Salary,
            GETDATE()
        );

        PRINT 'Employee Added Successfully';

    END TRY

    BEGIN CATCH

        INSERT INTO AuditLog(Action,ErrorMessage)
        VALUES('Add Employee',ERROR_MESSAGE());

        PRINT 'Error Logged';

    END CATCH
END;
GO

EXEC AddEmployee
5,'David','Wilson','john@gmail.com',5000,1;

SELECT * FROM AuditLog;
GO

/*==========================================================
Exercise 2
THROW
==========================================================*/

ALTER PROCEDURE AddEmployee
(
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
)
AS
BEGIN

    BEGIN TRY

        INSERT INTO Employees
        (
            EmployeeID,
            FirstName,
            LastName,
            Email,
            DepartmentID,
            Salary,
            JoinDate
        )
        VALUES
        (
            @EmployeeID,
            @FirstName,
            @LastName,
            @Email,
            @DepartmentID,
            @Salary,
            GETDATE()
        );

    END TRY

    BEGIN CATCH

        INSERT INTO AuditLog(Action,ErrorMessage)
        VALUES('Add Employee',ERROR_MESSAGE());

        THROW;

    END CATCH

END;
GO

/*==========================================================
Exercise 3
RAISERROR
==========================================================*/

ALTER PROCEDURE AddEmployee
(
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
)
AS
BEGIN

    IF @Salary<=0
    BEGIN
        RAISERROR('Salary must be greater than zero.',16,1);
        RETURN;
    END

    INSERT INTO Employees
    (
        EmployeeID,
        FirstName,
        LastName,
        Email,
        DepartmentID,
        Salary,
        JoinDate
    )
    VALUES
    (
        @EmployeeID,
        @FirstName,
        @LastName,
        @Email,
        @DepartmentID,
        @Salary,
        GETDATE()
    );

END;
GO

EXEC AddEmployee
6,'Alex','Thomas','alex@gmail.com',-1000,2;
GO

/*==========================================================
Exercise 4
Nested TRY...CATCH
==========================================================*/

CREATE OR ALTER PROCEDURE TransferEmployee
(
    @EmployeeID INT,
    @DepartmentID INT
)
AS
BEGIN

    BEGIN TRY

        BEGIN TRY

            IF NOT EXISTS
            (
                SELECT *
                FROM Departments
                WHERE DepartmentID=@DepartmentID
            )
            BEGIN
                RAISERROR('Department does not exist.',16,1);
            END

            UPDATE Employees
            SET DepartmentID=@DepartmentID
            WHERE EmployeeID=@EmployeeID;

        END TRY

        BEGIN CATCH

            INSERT INTO AuditLog(Action,ErrorMessage)
            VALUES('Transfer Employee',ERROR_MESSAGE());

            THROW;

        END CATCH

    END TRY

    BEGIN CATCH

        PRINT ERROR_MESSAGE();

    END CATCH

END;
GO

EXEC TransferEmployee 1,100;

SELECT * FROM AuditLog;
GO

/*==========================================================
Exercise 5
Transaction
==========================================================*/

CREATE OR ALTER PROCEDURE BatchInsertEmployees
AS
BEGIN

    BEGIN TRY

        BEGIN TRANSACTION;

        INSERT INTO Employees
        (
            EmployeeID,
            FirstName,
            LastName,
            Email,
            DepartmentID,
            Salary,
            JoinDate
        )
        VALUES
        (
            7,
            'Kevin',
            'Brown',
            'kevin@gmail.com',
            1,
            5000,
            GETDATE()
        );

        INSERT INTO Employees
        (
            EmployeeID,
            FirstName,
            LastName,
            Email,
            DepartmentID,
            Salary,
            JoinDate
        )
        VALUES
        (
            8,
            'Sarah',
            'Miller',
            'john@gmail.com',
            2,
            6000,
            GETDATE()
        );

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        INSERT INTO AuditLog(Action,ErrorMessage)
        VALUES('Batch Insert',ERROR_MESSAGE());

        PRINT 'Transaction Rolled Back';

    END CATCH

END;
GO

EXEC BatchInsertEmployees;

SELECT * FROM AuditLog;
GO

/*==========================================================
Exercise 6
Dynamic RAISERROR
==========================================================*/

ALTER PROCEDURE AddEmployee
(
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(100),
    @Salary DECIMAL(10,2),
    @DepartmentID INT
)
AS
BEGIN

    IF @Salary<0
    BEGIN
        RAISERROR('Negative salary is not allowed.',16,1);
        RETURN;
    END

    IF @Salary<1000
    BEGIN
        RAISERROR('Salary is very low.',10,1);
    END

    INSERT INTO Employees
    (
        EmployeeID,
        FirstName,
        LastName,
        Email,
        DepartmentID,
        Salary,
        JoinDate
    )
    VALUES
    (
        @EmployeeID,
        @FirstName,
        @LastName,
        @Email,
        @DepartmentID,
        @Salary,
        GETDATE()
    );

END;
GO

EXEC AddEmployee
9,'Peter','James','peter@gmail.com',500,1;

SELECT * FROM Employees;
SELECT * FROM AuditLog;
GO