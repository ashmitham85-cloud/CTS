USE AdvancedSQLDB;
GO

/*==========================================================
Exercise 1
Simple Cursor
==========================================================*/

DECLARE
    @EmployeeID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @DepartmentID INT,
    @Salary DECIMAL(10,2),
    @JoinDate DATE;

DECLARE EmployeeCursor CURSOR
FOR
SELECT
    EmployeeID,
    FirstName,
    LastName,
    DepartmentID,
    Salary,
    JoinDate
FROM Employees;

OPEN EmployeeCursor;

FETCH NEXT FROM EmployeeCursor
INTO
    @EmployeeID,
    @FirstName,
    @LastName,
    @DepartmentID,
    @Salary,
    @JoinDate;

WHILE @@FETCH_STATUS = 0
BEGIN

    PRINT 'Employee ID : ' + CAST(@EmployeeID AS VARCHAR(10));
    PRINT 'Name        : ' + @FirstName + ' ' + @LastName;
    PRINT 'Department  : ' + CAST(@DepartmentID AS VARCHAR(10));
    PRINT 'Salary      : ' + CAST(@Salary AS VARCHAR(20));
    PRINT 'Join Date   : ' + CAST(@JoinDate AS VARCHAR(20));
    PRINT '-----------------------------';

    FETCH NEXT FROM EmployeeCursor
    INTO
        @EmployeeID,
        @FirstName,
        @LastName,
        @DepartmentID,
        @Salary,
        @JoinDate;

END;

CLOSE EmployeeCursor;
DEALLOCATE EmployeeCursor;
GO

/*==========================================================
Exercise 2
STATIC Cursor
==========================================================*/

DECLARE
    @EmpID INT,
    @Name VARCHAR(100);

DECLARE StaticCursor CURSOR STATIC
FOR
SELECT
EmployeeID,
FirstName
FROM Employees;

OPEN StaticCursor;

FETCH NEXT FROM StaticCursor
INTO @EmpID,@Name;

WHILE @@FETCH_STATUS=0
BEGIN

    PRINT 'STATIC : '
          +CAST(@EmpID AS VARCHAR)
          +' - '
          +@Name;

    FETCH NEXT FROM StaticCursor
    INTO @EmpID,@Name;

END;

CLOSE StaticCursor;
DEALLOCATE StaticCursor;
GO

/*==========================================================
Exercise 2
DYNAMIC Cursor
==========================================================*/

DECLARE
    @EmpID2 INT,
    @Name2 VARCHAR(100);

DECLARE DynamicCursor CURSOR DYNAMIC
FOR
SELECT
EmployeeID,
FirstName
FROM Employees;

OPEN DynamicCursor;

FETCH NEXT FROM DynamicCursor
INTO @EmpID2,@Name2;

WHILE @@FETCH_STATUS=0
BEGIN

    PRINT 'DYNAMIC : '
          +CAST(@EmpID2 AS VARCHAR)
          +' - '
          +@Name2;

    FETCH NEXT FROM DynamicCursor
    INTO @EmpID2,@Name2;

END;

CLOSE DynamicCursor;
DEALLOCATE DynamicCursor;
GO

/*==========================================================
Exercise 2
FORWARD_ONLY Cursor
==========================================================*/

DECLARE
    @EmpID3 INT,
    @Name3 VARCHAR(100);

DECLARE ForwardCursor CURSOR FORWARD_ONLY
FOR
SELECT
EmployeeID,
FirstName
FROM Employees;

OPEN ForwardCursor;

FETCH NEXT FROM ForwardCursor
INTO @EmpID3,@Name3;

WHILE @@FETCH_STATUS=0
BEGIN

    PRINT 'FORWARD_ONLY : '
          +CAST(@EmpID3 AS VARCHAR)
          +' - '
          +@Name3;

    FETCH NEXT FROM ForwardCursor
    INTO @EmpID3,@Name3;

END;

CLOSE ForwardCursor;
DEALLOCATE ForwardCursor;
GO

/*==========================================================
Exercise 2
KEYSET Cursor
==========================================================*/

DECLARE
    @EmpID4 INT,
    @Name4 VARCHAR(100);

DECLARE KeysetCursor CURSOR KEYSET
FOR
SELECT
EmployeeID,
FirstName
FROM Employees;

OPEN KeysetCursor;

FETCH NEXT FROM KeysetCursor
INTO @EmpID4,@Name4;

WHILE @@FETCH_STATUS=0
BEGIN

    PRINT 'KEYSET : '
          +CAST(@EmpID4 AS VARCHAR)
          +' - '
          +@Name4;

    FETCH NEXT FROM KeysetCursor
    INTO @EmpID4,@Name4;

END;

CLOSE KeysetCursor;
DEALLOCATE KeysetCursor;
GO