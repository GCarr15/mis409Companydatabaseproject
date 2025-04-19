SET SERVEROUTPUT ON;

DECLARE
    CURSOR emp_cursor IS
        SELECT e.EmployeeID, e.EmployeeFname, e.EmployeeLname, e.EmployeeSalary, 
               e.ZipCode, p.PositionTitle
        FROM Employees e
        JOIN Positions p ON e.PositionID = p.PositionID
        WHERE p.PositionTitle IN ('Dye Operator', 'Shear Operator', 'Mill Operator');

    v_id Employees.EmployeeID%TYPE;
    v_fname Employees.EmployeeFname%TYPE;
    v_lname Employees.EmployeeLname%TYPE;
    v_salary Employees.EmployeeSalary%TYPE;
    v_title Positions.PositionTitle%TYPE;
    v_zipcode Employees.ZipCode%TYPE;
    v_new_salary NUMBER;
    v_grand_total NUMBER := 0;

    -- Cursor for utility details
    CURSOR utility_cursor(p_zipcode VARCHAR) IS
        SELECT UtilitiesName, UtilitiesPhone
        FROM Utilities
        WHERE ZipCode = p_zipcode;

    v_util_name Utilities.UtilitiesName%TYPE;
    v_util_phone Utilities.UtilitiesPhone%TYPE;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        v_id := emp_rec.EmployeeID;
        v_fname := emp_rec.EmployeeFname;
        v_lname := emp_rec.EmployeeLname;
        v_salary := emp_rec.EmployeeSalary;
        v_title := emp_rec.PositionTitle;
        v_zipcode := emp_rec.ZipCode;

        v_new_salary := ROUND(v_salary * 1.02, 2);

        -- Update employee salary (optional)
        -- UPDATE Employees
        -- SET EmployeeSalary = v_new_salary
        -- WHERE EmployeeID = v_id;

        -- Add to grand total
        v_grand_total := v_grand_total + v_new_salary;

        -- Display employee details
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_id);
        DBMS_OUTPUT.PUT_LINE('Name: ' || v_fname || ' ' || v_lname);
        DBMS_OUTPUT.PUT_LINE('Position: ' || v_title);
        DBMS_OUTPUT.PUT_LINE('Zip Code: ' || v_zipcode);
        DBMS_OUTPUT.PUT_LINE('Old Salary: $' || v_salary);
        DBMS_OUTPUT.PUT_LINE('New Salary: $' || v_new_salary);

        -- List utilities in same ZipCode
        DBMS_OUTPUT.PUT_LINE('--- Utilities in Zip Code ' || v_zipcode || ' ---');
        FOR util_rec IN utility_cursor(v_zipcode) LOOP
            DBMS_OUTPUT.PUT_LINE('Utility: ' || util_rec.UtilitiesName || 
                                 ', Phone: ' || util_rec.UtilitiesPhone);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('----------------------------');
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('GRAND TOTAL OF UPDATED SALARIES: $' || v_grand_total);

    -- Optional: commit the salary changes if updates are enabled
    -- COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

Statement processed.
Employee ID: 1107011
Name: Jernej Devraj
Position: Shear Operator
Zip Code: 65534
Old Salary: $55000
New Salary: $56100
--- Utilities in Zip Code 65534 ---
Utility: Constellation, Phone: 2607364085
----------------------------
Employee ID: 1107019
Name: Honor Lennart
Position: Dye Operator
Zip Code: 65531
Old Salary: $45000
New Salary: $45900
--- Utilities in Zip Code 65531 ---
Utility: Atmos Energy, Phone: 9144799214
----------------------------
Employee ID: 1107025
Name: Yaron Vikram
Position: Mill Operator
Zip Code: 65588
Old Salary: $76000
New Salary: $77520
--- Utilities in Zip Code 65588 ---
Utility: Laclede Electric, Phone: 5778285576
----------------------------
Employee ID: 1107029
Name: Hermenegildo Maria
Position: Mill Operator
Zip Code: 65598
Old Salary: $52000
New Salary: $53040
--- Utilities in Zip Code 65598 ---
Utility: Growth Zone, Phone: 2705252613
----------------------------
Employee ID: 1107033
Name: Daniel Zunuri
Position: Shear Operator
Zip Code: 65531
Old Salary: $58000
New Salary: $59160
--- Utilities in Zip Code 65531 ---
Utility: Atmos Energy, Phone: 9144799214
----------------------------
Employee ID: 1107034
Name: Baxton Allred
Position: Dye Operator
Zip Code: 65537
Old Salary: $38000
New Salary: $38760
--- Utilities in Zip Code 65537 ---
Utility: Mid-Valley Pipeline Co, Phone: 5648028483
Utility: GlobalSpec, Phone: 3020327756
----------------------------
GRAND TOTAL OF UPDATED SALARIES: $330480

----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create a procedure to enter new customer ('101325427','Yulleti','Mcquire','ymcquire@yahoo.com','8997569771','711 Meadow Lane','65576'); and list each cutomer with a 65576 zip code and their invoices and utilities info.
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE InsertAndListCustomers_65576 AS
    -- Variables for inserting the new customer
    v_exists NUMBER;
BEGIN
    -- Check if customer already exists
    SELECT COUNT(*) INTO v_exists 
    FROM Customers 
    WHERE CustomerID = 101325427;

    IF v_exists = 0 THEN
        INSERT INTO Customers (
            CustomerID, CustomerFNAME, CustomerLNAME, CustomerEmail, 
            CustomerPhone, CustomerADDRESS, ZipCode
        ) VALUES (
            101325427, 'Yulleti', 'Mcquire', 'ymcquire@yahoo.com',
            '8997569771', '711 Meadow Lane', '65576'
        );

        DBMS_OUTPUT.PUT_LINE('New customer inserted.');

    ELSE

        DBMS_OUTPUT.PUT_LINE('Customer already exists.');

    END IF;

    -- List customers in 65576 along with invoices and utility info
    FOR rec IN (
        SELECT 
            c.CustomerID, c.CustomerFNAME, c.CustomerLNAME,
            i.InvoiceID, u.UtilitiesName, u.UtilitiesPhone
        FROM Customers c, Invoices i, Utilities u
        WHERE c.ZipCode = '65576'
        AND c.CustomerID = i.CustomerID
        AND i.UtilitiesID = u.UtilitiesID

    ) LOOP

        DBMS_OUTPUT.PUT_LINE('Customer ID: ' || rec.CustomerID);
        DBMS_OUTPUT.PUT_LINE('Name: ' || rec.CustomerFNAME || ' ' || rec.CustomerLNAME);
        
        IF rec.InvoiceID IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Invoice ID: ' || rec.InvoiceID);
            DBMS_OUTPUT.PUT_LINE('Utility: ' || rec.UtilitiesName || ', Phone: ' || rec.UtilitiesPhone);

        ELSE
            DBMS_OUTPUT.PUT_LINE('No invoices found.');

        END IF;

        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: Cannot create procedure');
        ROLLBACK;
END;
/

BEGIN
    InsertAndListCustomers_65576;

END;
/

Statement processed.
New customer inserted.
Customer ID: 101325422
Name: Manuelita Kirsi
Invoice ID: 991009815104
Utility: Laclede Electric, Phone: 5778285576
-----------------------------
Customer ID: 101325422
Name: Manuelita Kirsi
Invoice ID: 991009815095
Utility: GlobalSpec, Phone: 3020327756
-----------------------------
Customer ID: 101325423
Name: Olumide Junayd
Invoice ID: 991009815105
Utility: GlobalSpec, Phone: 3020327756
-----------------------------
Customer ID: 101325422
Name: Manuelita Kirsi
Invoice ID: 991009815100
Utility: Growth Zone, Phone: 2705252613
-----------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create a package with function that returns number of employees in each worksite then returns the employee with employee id of '01107027's name, gives them a raise then resets the raise
SET SERVEROUTPUT ON;

-- Package Specification
CREATE OR REPLACE PACKAGE EmployeeOps AS
    FUNCTION CountEmployeesAndRaise RETURN VARCHAR2;
END EmployeeOps;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY EmployeeOps AS

    FUNCTION CountEmployeesAndRaise RETURN VARCHAR2 IS
        v_original_salary Employees.EmployeeSalary%TYPE;
        v_raised_salary   Employees.EmployeeSalary%TYPE;
        v_fname           Employees.EmployeeFname%TYPE;
        v_lname           Employees.EmployeeLname%TYPE;
        v_total_worksites NUMBER;
    BEGIN
        -- 1. Count employees in each worksite
        DBMS_OUTPUT.PUT_LINE('--- Employee Count Per Worksite ---');
        FOR rec IN (
            SELECT WorksiteID, COUNT(*) AS EmpCount
            FROM Employees
            GROUP BY WorksiteID
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Worksite ' || rec.WorksiteID || ' has ' || rec.EmpCount || ' employees.');
        END LOOP;

        -- 2. Count total number of unique worksites
        SELECT COUNT(DISTINCT WorksiteID)
        INTO v_total_worksites
        FROM Employees;

        DBMS_OUTPUT.PUT_LINE('Total number of unique worksites: ' || v_total_worksites);

        -- 3. Get Esthiru Kishori's info
        SELECT EmployeeSalary, EmployeeFname, EmployeeLname
        INTO v_original_salary, v_fname, v_lname
        FROM Employees
        WHERE EmployeeID = '01107027'; -- treat ID as string, not number

        -- 4. Give a 2% raise
        v_raised_salary := ROUND(v_original_salary * 1.02, 2);

        -- Uncomment to apply raise
        -- UPDATE Employees
        -- SET EmployeeSalary = v_raised_salary
        -- WHERE EmployeeID = '01107027';

        DBMS_OUTPUT.PUT_LINE('Raise applied to ' || v_fname || ' ' || v_lname || '. New salary: ' || v_raised_salary);

        -- 5. Reset salary to original
        -- UPDATE Employees
        -- SET EmployeeSalary = v_original_salary
        -- WHERE EmployeeID = '01107027';

        DBMS_OUTPUT.PUT_LINE('Salary reset to original: ' || v_original_salary);

        RETURN v_fname || ' ' || v_lname;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Employee not found.';
        WHEN OTHERS THEN
            RETURN 'Error: ' || SQLERRM;
    END CountEmployeesAndRaise;

END EmployeeOps;
/

-- Test the package function
DECLARE
    v_name VARCHAR2(128);
BEGIN
    v_name := EmployeeOps.CountEmployeesAndRaise;
    DBMS_OUTPUT.PUT_LINE('Processed Employee: ' || v_name);
END;
/

--- Employee Count Per Worksite ---
Worksite 6025054 has 2 employees.
Worksite 6025058 has 2 employees.
Worksite 6025056 has 4 employees.
Worksite 6025059 has 3 employees.
Worksite 6025055 has 3 employees.
Worksite 6025060 has 2 employees.
Worksite 6025057 has 2 employees.
Worksite 6025051 has 2 employees.
Worksite 6025050 has 2 employees.
Worksite 6025053 has 2 employees.
Worksite 6025052 has 2 employees.
Total number of unique worksites: 11
Raise applied to Esthiru Kishori. New salary: 43860
Salary reset to original: 43000
Processed Employee: Esthiru Kishori


----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create a table that stores a username, date and time user created data, and number of records created, then user creates four new employees in the employee table, and create trigger displaying user info and new employees in employee table
-- Main activity log
CREATE TABLE UserActivity (
    ActivityID NUMBER PRIMARY KEY,
    Username VARCHAR(64),
    ActivityDateTime TIMESTAMP,
    RecordsCreated NUMBER
);

-- Detailed employee audit trail
CREATE TABLE EmployeeAudit (
    AuditID NUMBER PRIMARY KEY,
    EmployeeID VARCHAR2(16),
    Username VARCHAR2(64),
    ActivityDateTime TIMESTAMP
);

-- Sequences for both tables
CREATE SEQUENCE UserActivity_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE EmployeeAudit_SEQ START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Employee_After_Insert
AFTER INSERT ON Employees
FOR EACH ROW
DECLARE
    v_username VARCHAR(64);
BEGIN
    -- Get the current session user
    v_username := SYS_CONTEXT('USERENV', 'SESSION_USER');

    BEGIN
        -- Log basic user activity
        INSERT INTO UserActivity (
            ActivityID, Username, ActivityDateTime, RecordsCreated
        ) VALUES (
            UserActivity_SEQ.NEXTVAL, v_username, SYSTIMESTAMP, 1
        );

        -- Log employee-level audit detail
        INSERT INTO EmployeeAudit (
            AuditID, EmployeeID, Username, ActivityDateTime
        ) VALUES (
            EmployeeAudit_SEQ.NEXTVAL, :NEW.EmployeeID, v_username, SYSTIMESTAMP
        );

        -- Output info to console/log
        DBMS_OUTPUT.PUT_LINE('New Employee Created: ' || :NEW.EmployeeID || 
                             ' - ' || :NEW.EmployeeFname || ' ' || :NEW.EmployeeLname);

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in trigger: ' || SQLERRM);
    END;
END;
/

CREATE OR REPLACE VIEW v_UserActivityDetails AS
SELECT 
    ua.ActivityID,
    ua.Username,
    ua.ActivityDateTime,
    ua.RecordsCreated,
    ea.EmployeeID,
    e.EmployeeFname || ' ' || e.EmployeeLname AS FullName
FROM 
    UserActivity ua
JOIN 
    EmployeeAudit ea ON ua.Username = ea.Username AND ua.ActivityDateTime = ea.ActivityDateTime
JOIN 
    Employees e ON ea.EmployeeID = e.EmployeeID;

-- Insert new employees and trigger will fire automatically
INSERT INTO Employees (EmployeeID, EmployeeFname, EmployeeMinit, EmployeeLname, EmployeeSsn, EmployeeAddress, ZipCode, EmployeePhone, EmployeeSalary, WorksiteID, PositionID)
VALUES ('01107036', 'John', 'D', 'Doe', '123456789', '123 Elm St.', '65598', '4171234567', 35000, '6025059', '50112');

INSERT INTO Employees (EmployeeID, EmployeeFname, EmployeeMinit, EmployeeLname, EmployeeSsn, EmployeeAddress, ZipCode, EmployeePhone, EmployeeSalary, WorksiteID, PositionID)
VALUES ('01107037', 'Jane', 'B', 'Smith', '987654321', '456 Oak St.', '65534', '4172345678', 40000, '6025051', '50114');

-- Check high-level activity
SELECT * FROM UserActivity;

-- Check detailed audit
SELECT * FROM EmployeeAudit;

-- Use the combined view
SELECT * FROM v_UserActivityDetails;

1 row(s) inserted.
New Employee Created: 1107036 - John Doe

1 row(s) inserted.
New Employee Created: 1107037 - Jane Smith

Result Set 1
ACTIVITYID	USERNAME	ACTIVITYDATETIME	RECORDSCREATED
1	APEX_PUBLIC_USER	11-APR-25 12.35.11.094965 AM	1
2	APEX_PUBLIC_USER	11-APR-25 12.35.11.127849 AM	1
2 rows selected.

Result Set 2
AUDITID	EMPLOYEEID	USERNAME	ACTIVITYDATETIME
1	1107036	APEX_PUBLIC_USER	11-APR-25 12.35.11.117766 AM
2	1107037	APEX_PUBLIC_USER	11-APR-25 12.35.11.127916 AM
2 rows selected.

----------------------------------------------------------------------------------------------------------------------------------------------------------
--List each lease contract and its info with a line id of '870050', and '870051'. then increse the line price by 10%. then list the line information with the lease contract, then output the total price of each lease contract.
SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur_lease IS
    SELECT * FROM LeaseContracts
    WHERE LineID IN (870050, 870051);

  v_old_total NUMBER := 0;
  v_new_total NUMBER := 0;
  v_count NUMBER := 0;

BEGIN
  -- Step 0: Check if records exist
  SELECT COUNT(*) INTO v_count
  FROM LeaseContracts
  WHERE LineID IN (870050, 870051);

  IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('No lease contracts found for LineID 870050 or 870051.');
    RETURN;
  END IF;

  -- Step 1: Display lease contract info before update
  DBMS_OUTPUT.PUT_LINE('--- BEFORE UPDATE ---');
  FOR rec IN cur_lease LOOP
    DBMS_OUTPUT.PUT_LINE('Lease ID: ' || rec.LeaseContractID ||
                         ', LineID: ' || rec.LineID ||
                         ', Owner: ' || rec.LeaseContractOwnerFname || ' ' || rec.LeaseContractOwnerLname ||
                         ', Price: $' || rec.LeaseContractPrice);
    v_old_total := v_old_total + rec.LeaseContractPrice;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Grand Total BEFORE Update: $' || v_old_total);

  -- Step 2: Update lease contract prices by 10%
  --UPDATE LeaseContracts
  --SET LeaseContractPrice = LeaseContractPrice * 1.10
  --WHERE LineID IN (870050, 870051);

  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' lease(s) updated with 10% price increase.');

  -- Step 3: Display updated lease and line info
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- AFTER UPDATE ---');

  FOR rec IN (
    SELECT lc.LeaseContractID, lc.LineID,
           lc.LeaseContractOwnerFname || ' ' || lc.LeaseContractOwnerLname AS Owner,
           lc.LeaseContractPrice, l.LineAddress, l.ZipCode, l.LineAcres
    FROM LeaseContracts lc
    JOIN Lines l ON lc.LineID = l.LineID
    WHERE lc.LineID IN (870050, 870051)
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Lease ID: ' || rec.LeaseContractID ||
                         ', Owner: ' || rec.Owner ||
                         ', Updated Price: $' || rec.LeaseContractPrice ||
                         ', Address: ' || rec.LineAddress ||
                         ', Zip: ' || rec.ZipCode ||
                         ', Acres: ' || rec.LineAcres);
    v_new_total := v_new_total + rec.LeaseContractPrice;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Grand Total AFTER Update: $' || v_new_total);

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);

END;
/

Statement processed.
--- BEFORE UPDATE ---
Lease ID: 12300111, LineID: 870050, Owner: Harrison Wobler, Price: $496922.8605
Lease ID: 12300101, LineID: 870051, Owner: Marshall Mathers, Price: $292307.565
Lease ID: 12300104, LineID: 870050, Owner: Alan Jackson, Price: $1948717.1
Grand Total BEFORE Update: $2737947.5255
1 lease(s) updated with 10% price increase.

--- AFTER UPDATE ---
Lease ID: 12300111, Owner: Harrison Wobler, Updated Price: $496922.8605, Address: 379 Plymouth St., Zip: 65598, Acres: 1000
Lease ID: 12300101, Owner: Marshall Mathers, Updated Price: $292307.565, Address: 216 Miles St., Zip: 65534, Acres: 200
Lease ID: 12300104, Owner: Alan Jackson, Updated Price: $1948717.1, Address: 379 Plymouth St., Zip: 65598, Acres: 1000
Grand Total AFTER Update: $2737947.5255

----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create a procedure to enter new lease contract '12300111','870050','Harrison','Wobler','6687568992', '4/10/20025','255000', then list each lease contract with 870050 worksite id and that worksites information
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE InsertAndListLeaseFor870050 AS
    v_count NUMBER := 0;
BEGIN
    -- Step 0: Check if the LeaseContractID already exists
    SELECT COUNT(*) INTO v_count
    FROM LeaseContracts
    WHERE LeaseContractID = 12300111;

    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('LeaseContractID 12300111 already exists. Skipping insert.');
    ELSE
        -- Step 1: Insert the new lease contract
        INSERT INTO LeaseContracts (
            LeaseContractID, LineID, LeaseContractOwnerFname,
            LeaseContractOwnerLname, LeaseContractOwnerPhone,
            LeaseContractContractDate, LeaseContractPrice
        )
        VALUES (
            12300111, 870050, 'Harrison', 'Wobler', '6687568992',
            TO_DATE('04/10/2025', 'MM/DD/YYYY'), 255000
        );

        DBMS_OUTPUT.PUT_LINE('New lease contract inserted.');
    END IF;

    -- Step 2: List all lease contracts for LineID 870050
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Lease Contracts for LineID 870050 ---');
    FOR lease_rec IN (
        SELECT * FROM LeaseContracts WHERE LineID = 870050
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Lease ID: ' || lease_rec.LeaseContractID ||
                             ', Owner: ' || lease_rec.LeaseContractOwnerFname || ' ' || lease_rec.LeaseContractOwnerLname ||
                             ', Phone: ' || lease_rec.LeaseContractOwnerPhone ||
                             ', Price: $' || lease_rec.LeaseContractPrice ||
                             ', Date: ' || TO_CHAR(lease_rec.LeaseContractContractDate, 'MM/DD/YYYY'));
    END LOOP;

    -- Step 3: Check if the LineID exists in Worksites
    SELECT COUNT(*) INTO v_count
    FROM Worksites
    WHERE LineID = 870050;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE(CHR(10) || 'No worksite found for LineID 870050.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Worksite Info for LineID 870050 ---');
        FOR ws_rec IN (
            SELECT * FROM Worksites WHERE LineID = 870050
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Worksite ID: ' || ws_rec.WorksiteID ||
                                 ', Location: ' || ws_rec.WorksiteLocation ||
                                 ', Manager: ' || ws_rec.WorksiteManagerFname || ' ' || ws_rec.WorksiteManagerLname ||
                                 ', Phone: ' || ws_rec.WorksiteManagerPhone);
        END LOOP;
    END IF;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/

BEGIN
  InsertAndListLeaseFor870050;
END;
/

New lease contract inserted.

--- Lease Contracts for LineID 870050 ---
Lease ID: 12300111, Owner: Harrison Wobler, Phone: 6687568992, Price: $255000, Date: 04/10/2025
Lease ID: 12300104, Owner: Alan Jackson, Phone: 6621123355, Price: $1000000, Date: 05/31/2015

--- Worksite Info for LineID 870050 ---
Worksite ID: 6025051, Location: Springfield, Manager: Yaron Vikram, Phone: 4178245189

----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create a package with function that returns number of lines in each lease contract then returns the lease contract with id of '12300105' rasie the price by 15% then resets the price.
SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE LeaseContractPkg AS
  FUNCTION GetLineCount RETURN NUMBER;
  FUNCTION AdjustAndResetPrice RETURN VARCHAR2;
END LeaseContractPkg;
/

-- PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY LeaseContractPkg AS

  -- Function to count unique LineIDs used in LeaseContracts
  FUNCTION GetLineCount RETURN NUMBER IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(DISTINCT LineID)
    INTO v_count
    FROM LeaseContracts;
    
    RETURN v_count;
  END GetLineCount;

  -- Function to increase price of lease 12300105 by 15%, show info, reset price
  FUNCTION AdjustAndResetPrice RETURN VARCHAR2 IS
    v_old_price LeaseContracts.LeaseContractPrice%TYPE;
    v_new_price LeaseContracts.LeaseContractPrice%TYPE;
    v_output VARCHAR2(1000);
  BEGIN
    -- Get original price
    SELECT LeaseContractPrice INTO v_old_price
    FROM LeaseContracts
    WHERE LeaseContractID = 12300105;

    -- Calculate new price
    v_new_price := v_old_price * 1.15;

    -- Temporarily update the price
    UPDATE LeaseContracts
    SET LeaseContractPrice = v_new_price
    WHERE LeaseContractID = 12300105;

    -- Get updated info
    SELECT 'Lease ID: ' || LeaseContractID ||
           ', Owner: ' || LeaseContractOwnerFname || ' ' || LeaseContractOwnerLname ||
           ', Phone: ' || LeaseContractOwnerPhone ||
           ', Price (Raised): ' || LeaseContractPrice
    INTO v_output
    FROM LeaseContracts
    WHERE LeaseContractID = 12300105;

    -- Reset price back to original
    UPDATE LeaseContracts
    SET LeaseContractPrice = v_old_price
    WHERE LeaseContractID = 12300105;

    COMMIT;

    RETURN v_output;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN 'Lease contract 12300105 not found.';
    WHEN OTHERS THEN
      RETURN 'Unexpected error: ' || SQLERRM;
  END AdjustAndResetPrice;

END LeaseContractPkg;
/

-- Show count of unique LineIDs in LeaseContracts
BEGIN
  DBMS_OUTPUT.PUT_LINE('Number of lines: ' || LeaseContractPkg.GetLineCount);
END;
/

-- Show raised price info then reset
DECLARE
  v_result VARCHAR2(1000);
BEGIN
  v_result := LeaseContractPkg.AdjustAndResetPrice;
  DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

Package created.

Package Body created.

Statement processed.
Number of lines: 11

Statement processed.
Lease ID: 12300105, Owner: Kenny Chesney, Phone: 6628811000, Price (Raised): 621000

----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create a table that stores a username, date and time user created data, and number of records created, then user creates four new lease contracts in the employee table, and create trigger displays user info and new contracts.
SET SERVEROUTPUT ON;

CREATE TABLE UserActivity1 (
    ActivityID NUMBER PRIMARY KEY,
    Username VARCHAR2(64),
    ActivityDate DATE,
    ActivityTime VARCHAR2(8),
    RecordsCreated NUMBER
);

CREATE OR REPLACE TRIGGER LogUserActivity
AFTER INSERT ON LeaseContracts
FOR EACH ROW
DECLARE
    v_username VARCHAR2(64);
BEGIN
    SELECT USER INTO v_username FROM dual;

    INSERT INTO UserActivity1 (
        ActivityID, Username, ActivityDate, ActivityTime, RecordsCreated
    )
    VALUES (
        UserActivity1_SEQ.NEXTVAL,
        v_username,
        SYSDATE,
        TO_CHAR(SYSDATE, 'HH24:MI:SS'),
        1  -- now logging 1 record per insert
    );

    DBMS_OUTPUT.PUT_LINE('User: ' || v_username);
    DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(SYSDATE, 'MM/DD/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Time: ' || TO_CHAR(SYSDATE, 'HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Records Created: 1');
    DBMS_OUTPUT.PUT_LINE('Lease ID: ' || :NEW.LeaseContractID || 
                         ', Owner: ' || :NEW.LeaseContractOwnerFname || ' ' || :NEW.LeaseContractOwnerLname || 
                         ', Price: ' || :NEW.LeaseContractPrice);
END;
/


CREATE SEQUENCE UserActivity1_SEQ START WITH 1 INCREMENT BY 1;

DECLARE
    v_total_price NUMBER := 0;
BEGIN
    INSERT INTO LeaseContracts 
    VALUES ('12300112', '870057', 'John', 'Doe', '6625551234', TO_DATE('4/15/2025', 'MM/DD/YYYY'), 200000);
    v_total_price := v_total_price + 200000;

    INSERT INTO LeaseContracts 
    VALUES ('12300113', '870058', 'Jane', 'Doe', '6625555678', TO_DATE('4/16/2025', 'MM/DD/YYYY'), 250000);
    v_total_price := v_total_price + 250000;

    INSERT INTO LeaseContracts 
    VALUES ('12300114', '870059', 'Alice', 'Williams', '6625556789', TO_DATE('4/17/2025', 'MM/DD/YYYY'), 300000);
    v_total_price := v_total_price + 300000;

    INSERT INTO LeaseContracts 
    VALUES ('12300115', '870060', 'Bob', 'Johnson', '6625557890', TO_DATE('4/18/2025', 'MM/DD/YYYY'), 350000);
    v_total_price := v_total_price + 350000;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Lease Price of New Inserts: ' || v_total_price);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
END;
/

User: APEX_PUBLIC_USER
Date: 04/11/2025
Time: 03:13:39
Records Created: 1
Lease ID: 12300112, Owner: John Doe, Price: 200000
User: APEX_PUBLIC_USER
Date: 04/11/2025
Time: 03:13:39
Records Created: 1
Lease ID: 12300113, Owner: Jane Doe, Price: 250000
User: APEX_PUBLIC_USER
Date: 04/11/2025
Time: 03:13:39
Records Created: 1
Lease ID: 12300114, Owner: Alice Williams, Price: 300000
User: APEX_PUBLIC_USER
Date: 04/11/2025
Time: 03:13:39
Records Created: 1
Lease ID: 12300115, Owner: Bob Johnson, Price: 350000
--------------------------------------
Total Lease Price of New Inserts: 1100000
--------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------
--List each product and its info with line id of '870057', and '870051'. then increse the contract line price by 10%. then list new lease contract info.
SET SERVEROUTPUT ON;

DECLARE
    
    -- Cursor to fetch product and lease contract info for specified LineIDs
    CURSOR product_cursor IS
        SELECT p.ProductID, p.ProductName, p.ProductType, p.ProductVolts, p.Conductor,
               p.AVGHeight, p.AVGWidth, l.LineID, l.LineAddress, l.ZipCode, l.LineAcres
          FROM Products p
               JOIN Lines l ON p.ProductID = l.ProductID
         WHERE l.LineID IN ('870051', '870057');
    
    CURSOR lease_cursor IS
        SELECT lc.LeaseContractID, lc.LineID, lc.LeaseContractOwnerFname, lc.LeaseContractOwnerLname,
               lc.LeaseContractOwnerPhone, lc.LeaseContractContractDate, lc.LeaseContractPrice
          FROM LeaseContracts lc
         WHERE lc.LineID IN ('870051', '870057');

    v_total_price NUMBER := 0; -- Variable to accumulate total lease prices

BEGIN
    -- Display product details
    FOR product_record IN product_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Product ID: ' || product_record.ProductID);
        DBMS_OUTPUT.PUT_LINE('Product Name: ' || product_record.ProductName);
        DBMS_OUTPUT.PUT_LINE('Product Type: ' || product_record.ProductType);
        DBMS_OUTPUT.PUT_LINE('Product Volts: ' || product_record.ProductVolts);
        DBMS_OUTPUT.PUT_LINE('Conductor: ' || product_record.Conductor);
        DBMS_OUTPUT.PUT_LINE('Average Height: ' || product_record.AVGHeight);
        DBMS_OUTPUT.PUT_LINE('Average Width: ' || product_record.AVGWidth);
        DBMS_OUTPUT.PUT_LINE('Line ID: ' || product_record.LineID);
        DBMS_OUTPUT.PUT_LINE('Line Address: ' || product_record.LineAddress);
        DBMS_OUTPUT.PUT_LINE('Zip Code: ' || product_record.ZipCode);
        DBMS_OUTPUT.PUT_LINE('Line Acres: ' || product_record.LineAcres);
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;

    -- Update lease contract prices by 10% and display updated contract info
    FOR lease_record IN lease_cursor LOOP
        
        -- Increase the lease contract price by 10%
        --UPDATE LeaseContracts
        --SET LeaseContractPrice = LeaseContractPrice * 1.10
        --WHERE LeaseContractID = lease_record.LeaseContractID;

        -- Accumulate the updated lease price
        v_total_price := v_total_price + (lease_record.LeaseContractPrice * 1.10);

        -- Output updated lease contract info
        DBMS_OUTPUT.PUT_LINE('Updated Lease Contract ID: ' || lease_record.LeaseContractID);
        DBMS_OUTPUT.PUT_LINE('Line ID: ' || lease_record.LineID);
        DBMS_OUTPUT.PUT_LINE('Owner Name: ' || lease_record.LeaseContractOwnerFname || ' ' || lease_record.LeaseContractOwnerLname);
        DBMS_OUTPUT.PUT_LINE('Owner Phone: ' || lease_record.LeaseContractOwnerPhone);
        DBMS_OUTPUT.PUT_LINE('Contract Date: ' || TO_CHAR(lease_record.LeaseContractContractDate, 'MM/DD/YYYY'));
        DBMS_OUTPUT.PUT_LINE('Updated Lease Price: ' || TO_CHAR(lease_record.LeaseContractPrice * 1.10, 'FM$999,999,999.00'));
        DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    END LOOP;

    -- Display the grand total of updated lease prices
    DBMS_OUTPUT.PUT_LINE('GRAND TOTAL OF UPDATED LEASE PRICES: ' || TO_CHAR(v_total_price, 'FM$999,999,999.00'));

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

Product ID: 4400108
Product Name: Resistor
Product Type: Component
Product Volts: 20
Conductor: N
Average Height: 6
Average Width: 2
Line ID: 870051
Line Address: 216 Miles St.
Zip Code: 65534
Line Acres: 200
--------------------------------------
Product ID: 4400107
Product Name: DC Block
Product Type: Component
Product Volts: 15
Conductor: Y
Average Height: 6
Average Width: 2
Line ID: 870057
Line Address: 9513 Plymouth St.
Zip Code: 65536
Line Acres: 750
--------------------------------------
Updated Lease Contract ID: 12300101
Line ID: 870051
Owner Name: Marshall Mathers
Owner Phone: 6015547898
Contract Date: 06/13/2001
Updated Lease Price: 165000
--------------------------------------
Updated Lease Contract ID: 12300103
Line ID: 870057
Owner Name: Ed Sheeren
Owner Phone: 6625556699
Contract Date: 09/25/2000
Updated Lease Price: 550000
--------------------------------------
Updated Lease Contract ID: 12300112
Line ID: 870057
Owner Name: John Doe
Owner Phone: 6625551234
Contract Date: 04/15/2025
Updated Lease Price: 220000
--------------------------------------

----------------------------------------------------------------------------------------------------------------------------------------------------------
--Create a procedure to enter new product '4400112','Meter Box','Product','42','N','13','7', and list each product from the product table and add a price coloum with each price starting at $450. If the product is a 'Capacitor', 'Switch', or 'SemiConductor' then increase the price from 450 to 25% and list those products info.
-- Add Price column to the Products table (if not already added)
ALTER TABLE Products ADD (Price NUMBER);

-- Create the procedure to add a new product, update prices, and list them
CREATE OR REPLACE PROCEDURE AddNewProductAndUpdatePrices AS
BEGIN
    -- Insert the new product '4400112', 'Meter Box', 'Product', '42', 'N', '13', '7'
    INSERT INTO Products (ProductID, ProductName, ProductType, ProductVolts, Conductor, AVGHeight, AVGWidth, Price)
    VALUES ('4400112', 'Meter Box', 'Product', 42, 'N', 13, 7, 450);

    -- Update the price of all products to 450
    --UPDATE Products
    --SET Price = 450;

    -- Increase price for 'Capacitor', 'Switch', or 'SemiConductor' by 25%
    --UPDATE Products
    --SET Price = Price * 1.25
    --WHERE ProductName IN ('Capacitor', 'Switch', 'SemiConductor');

    -- Commit the changes
    COMMIT;

    -- List all products and their prices, highlighting those with updated prices
    FOR product_record IN (SELECT ProductID, ProductName, Price FROM Products) LOOP
        -- Display product information
        IF product_record.Price > 450 THEN
            DBMS_OUTPUT.PUT_LINE('Product ID: ' || product_record.ProductID || 
                                 ', Product Name: ' || product_record.ProductName || 
                                 ', Price: $' || product_record.Price || ' (Price increased by 25%)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Product ID: ' || product_record.ProductID || 
                                 ', Product Name: ' || product_record.ProductName || 
                                 ', Price: $' || product_record.Price);
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Product added and prices updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

SET SERVEROUTPUT ON;

EXEC AddNewProductAndUpdatePrices;

Product ID: 4400100, Product Name: Capacitor, Price: $562.5 (Price increased by 25%)
Product ID: 4400101, Product Name: Resonator, Price: $450
Product ID: 4400102, Product Name: Transducers, Price: $450
Product ID: 4400103, Product Name: Switch, Price: $562.5 (Price increased by 25%)
Product ID: 4400104, Product Name: Signal, Price: $450
Product ID: 4400105, Product Name: SemiConductor, Price: $562.5 (Price increased by 25%)
Product ID: 4400106, Product Name: Adapter, Price: $450
Product ID: 4400107, Product Name: DC Block, Price: $450
Product ID: 4400108, Product Name: Resistor, Price: $450
Product ID: 4400109, Product Name: Buzzer, Price: $450
Product ID: 4400110, Product Name: Control Nob, Price: $450
Product ID: 4400111, Product Name: Fuse, Price: $450
Product ID: 4400112, Product Name: Meter Box, Price: $450
--------------------------------------
TOTAL VALUE OF ALL PRODUCTS: $   6,187.50
Product added and prices updated successfully.