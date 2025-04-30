USE BankingSystemDB;

GO

-- STORED PROCEDURES

-- Procedure to get customer account summary
CREATE OR ALTER PROCEDURE GetCustomerAccountSummary
    @CustomerID INT,
    @TotalAccounts INT OUTPUT,
    @TotalBalance DECIMAL(15,2) OUTPUT
AS
BEGIN
    BEGIN TRY
        -- Count total accounts for customer
        SELECT @TotalAccounts = COUNT(*)
        FROM Customer_Financial_Instrument cfi
        JOIN Account a ON cfi.instrument_id = a.account_instrument_id
        WHERE cfi.customer_id = @CustomerID;

        -- Calculate total balance across all accounts
        SELECT @TotalBalance = ISNULL(SUM(a.balance), 0)
        FROM Customer_Financial_Instrument cfi
        JOIN Account a ON cfi.instrument_id = a.account_instrument_id
        WHERE cfi.customer_id = @CustomerID;
    END TRY
    BEGIN CATCH
        PRINT 'Error occurred while fetching account summary';
    END CATCH
END;

GO

-- Procedure to transfer money between accounts with transaction management and error handling
CREATE OR ALTER PROCEDURE TransferMoney
    @FromAccountID INT,
    @ToAccountID INT,
    @Amount DECIMAL(10,2),
    @TransactionID INT OUTPUT,
    @Status NVARCHAR(20) OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Check if source account has sufficient funds
        DECLARE @SourceBalance DECIMAL(10,2);
        SELECT @SourceBalance = balance FROM Account WHERE account_instrument_id = @FromAccountID;

        IF @SourceBalance < @Amount
        BEGIN
            SET @Status = 'Failed';
            RAISERROR('Insufficient funds', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Deduct from source account and add to destination account
        UPDATE Account SET balance = balance - @Amount WHERE account_instrument_id = @FromAccountID;
        UPDATE Account SET balance = balance + @Amount WHERE account_instrument_id = @ToAccountID;

        -- Record transactions for both accounts
        INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, description, status)
        VALUES (@FromAccountID, 'Account', 'Withdrawal', @Amount, 'Transfer to account ' + CAST(@ToAccountID AS NVARCHAR), 'Completed');

        SET @TransactionID = SCOPE_IDENTITY();

        INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, description, status)
        VALUES (@ToAccountID, 'Account', 'Deposit', @Amount, 'Transfer from account ' + CAST(@FromAccountID AS NVARCHAR), 'Completed');

        COMMIT TRANSACTION;
        SET @Status = 'Completed';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        SET @Status = 'Failed';
    END CATCH;
END;

GO

-- Procedure to process loan application with transaction management and error handling
CREATE OR ALTER PROCEDURE ProcessLoanApplication
    @CustomerID INT,
    @LoanType NVARCHAR(50),
    @LoanAmount DECIMAL(10,2),
    @EmployeeID INT,
    @Term INT,
    @LoanID INT OUTPUT,
    @ApprovalStatus NVARCHAR(20) OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validate CustomerID
        IF NOT EXISTS (SELECT 1 FROM Customer WHERE customer_id = @CustomerID)
        BEGIN
            RAISERROR('Invalid Customer ID', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Validate EmployeeID
        IF NOT EXISTS (SELECT 1 FROM Employee WHERE employee_id = @EmployeeID)
        BEGIN
            RAISERROR('Invalid Employee ID', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insert into Financial_Instrument table for loan creation
        INSERT INTO Financial_Instrument (instrument_type, status)
        VALUES ('Loan', 'Active');

        SET @LoanID = SCOPE_IDENTITY();

        -- Validate SCOPE_IDENTITY()
        IF (@LoanID IS NULL)
        BEGIN
            RAISERROR('Failed to create Financial Instrument', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Calculate interest rate based on loan type
        DECLARE @InterestRate DECIMAL(5,2);
        
        IF (@LoanType = 'Student') SET @InterestRate = 4.5;
        ELSE IF (@LoanType = 'Vehicle') SET @InterestRate = 5.5;
        ELSE IF (@LoanType = 'Mortgage') SET @InterestRate = 3.5;
        ELSE SET @InterestRate = 6.0;

        -- Insert into Loan table with calculated details
        INSERT INTO Loan (loan_id, processed_by_employee_id, loan_type, loan_amount, interest_rate, term)
        VALUES (@LoanID, @EmployeeID, @LoanType, @LoanAmount, @InterestRate, @Term);

        -- Link customer to financial instrument in Customer_Financial_Instrument table with role 'Owner'
        INSERT INTO Customer_Financial_Instrument (customer_id, instrument_id, role)
        VALUES (@CustomerID, @LoanID, 'Owner');

        SET @ApprovalStatus = 'Approved';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Debugging: Display error message for troubleshooting
        SELECT ERROR_MESSAGE() AS ErrorMessage,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState;
    END CATCH;
END;

GO

CREATE OR ALTER PROCEDURE UpdateAccountBalance
    @AccountID INT,
    @TransactionType NVARCHAR(50),
    @Amount DECIMAL(10,2),
    @Description NVARCHAR(MAX),
    @TransactionID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Update the account balance based on transaction type
        IF @TransactionType = 'Deposit'
        BEGIN
            UPDATE Account SET balance = balance + @Amount WHERE account_instrument_id = @AccountID;
        END
        ELSE IF @TransactionType = 'Withdrawal'
        BEGIN
            DECLARE @CurrentBalance DECIMAL(10,2);
            SELECT @CurrentBalance = balance FROM Account WHERE account_instrument_id = @AccountID;

            IF @CurrentBalance < @Amount
            BEGIN
                RAISERROR('Insufficient funds', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN;
            END

            UPDATE Account SET balance = balance - @Amount WHERE account_instrument_id = @AccountID;
        END

        -- Log the transaction in the Transaction table
        INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, description, status)
        VALUES (@AccountID, 'Account', @TransactionType, @Amount, @Description, 'Completed');

        SET @TransactionID = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT ERROR_MESSAGE();
    END CATCH;
END;

GO

CREATE OR ALTER PROCEDURE GetCustomerLoanDetails
    @CustomerID INT
AS
BEGIN
    SELECT 
        l.loan_id,
        l.loan_type,
        l.loan_amount,
        l.interest_rate,
        l.term,
        l.start_date,
        l.end_date,
        l.status
    FROM 
        Loan l
    JOIN 
        Customer_Financial_Instrument cfi ON l.loan_id = cfi.instrument_id
    WHERE 
        cfi.customer_id = @CustomerID;
END;

GO

-- VIEWS

-- View for customer accounts summary
CREATE OR ALTER VIEW CustomerAccountsView AS 
SELECT 
   c.customer_id,
   c.first_name + ' ' + c.last_name AS customer_name,
   a.account_number,
   a.account_type,
   a.balance,
   a.interest_rate,
   b.branch_name AS branch_associated_with_account 
FROM 
   Customer c 
JOIN 
   Customer_Financial_Instrument cfi ON c.customer_id = cfi.customer_id 
JOIN 
   Account a ON cfi.instrument_id = a.account_instrument_id 
JOIN 
   Branch b ON a.branch_id = b.branch_id;

GO

-- View for loan summary reporting purposes
CREATE OR ALTER VIEW LoanSummaryView AS 
SELECT 
   c.customer_id,
   c.first_name + ' ' + c.last_name AS customer_name,
   l.loan_type,
   l.loan_amount,
   l.interest_rate,
   l.term,
   l.start_date,
   e.first_name + ' ' + e.last_name AS processed_by_employee 
FROM 
   Loan l 
JOIN 
   Customer_Financial_Instrument cfi ON l.loan_id = cfi.instrument_id 
JOIN 
   Customer c ON cfi.customer_id = c.customer_id 
JOIN 
   Employee e ON l.processed_by_employee_id = e.employee_id;

GO

-- View for transaction history reporting purposes
CREATE OR ALTER VIEW TransactionHistoryView AS 
SELECT 
   t.transaction_id,
   t.date_time,
   t.transaction_type,
   t.amount,
   t.description,
   t.status,
   c.customer_id,
   c.first_name + ' ' + c.last_name AS customer_name 
FROM 
   [Transaction] t 
JOIN 
   Customer_Financial_Instrument cfi ON t.instrument_id = cfi.instrument_id 
JOIN 
   Customer c ON cfi.customer_id = c.customer_id;

GO

CREATE OR ALTER VIEW BranchEmployeeSummaryView AS 
SELECT 
    b.branch_name,
    b.branch_code,
    e.employee_id,
    e.first_name + ' ' + e.last_name AS employee_name,
    e.hire_date,
    e.salary
FROM 
    Branch b
JOIN 
    Employee e ON b.branch_id = e.branch_id;

GO

CREATE VIEW CustomerInvestmentSummaryView AS 
SELECT 
    c.customer_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    i.investment_type,
    i.investment_amount,
    i.risk_profile,
    i.maturity_date
FROM 
    Customer c
JOIN 
    Investment i ON c.customer_id = i.customer_id;

GO

-- UDFs

-- Function to calculate monthly loan payment based on principal amount and interest rate.
CREATE OR ALTER FUNCTION CalculateMonthlyPayment (
	@Principal DECIMAL(10,2),
	@AnnualRate DECIMAL(5,2),
	@TermMonths INT)
RETURNS DECIMAL(10,2)
AS BEGIN	
	RETURN ROUND(
		@Principal * ((@AnnualRate / 100 / 12) * POWER((1 + (@AnnualRate / 100 / 12)),@TermMonths)) /
		(POWER((1 + (@AnnualRate / 100 / 12)),@TermMonths) - 1),2);
END;

GO

-- Function to calculate yearly interest earned on an account balance.
CREATE OR ALTER FUNCTION CalculateYearlyInterest(@Balance DECIMAL(10,2),@Rate DECIMAL(5,2))
RETURNS DECIMAL(10,2) AS BEGIN	
	RETURN ROUND(@Balance * (@Rate/100),2);
END;

GO

-- Function to calculate the age of a customer based on their date of birth.
CREATE OR ALTER FUNCTION GetCustomerAge(@CustomerID INT)
RETURNS INT
AS
BEGIN
    DECLARE @DOB DATE;
    DECLARE @Age INT;

    -- Fetch date of birth for the given customer ID
    SELECT @DOB = date_of_birth FROM Customer WHERE customer_id = @CustomerID;

    -- Calculate age based on current date
    SET @Age = DATEDIFF(YEAR, @DOB, GETDATE());

    RETURN @Age;
END;

GO

CREATE OR ALTER FUNCTION CalculateLoanInterest (
	@Principal DECIMAL(10,2),
	@InterestRate DECIMAL(5,2),
	@TermMonths INT)
RETURNS DECIMAL(10,2)
AS BEGIN	
	RETURN ROUND(@Principal * (@InterestRate / 100) * (@TermMonths / 12.0), 2);
END;

GO

CREATE OR ALTER FUNCTION GetBranchEmployeeCount (
	@BranchID INT)
RETURNS INT 
AS BEGIN	
	RETURN (SELECT COUNT(*) FROM Employee WHERE branch_id = @BranchID);
END;

GO

-- TRIGGERS

-- Trigger to append audit information to transaction descriptions after insertion.
CREATE OR ALTER TRIGGER AuditTransactionTrigger ON [Transaction]
AFTER INSERT AS BEGIN	
	UPDATE [Transaction]
	SET description = description + ' | Audited'
	WHERE transaction_id IN (SELECT transaction_id FROM inserted);	
END;

GO

CREATE OR ALTER TRIGGER EnforceTransactionStatusRules ON [Transaction]
AFTER UPDATE
AS
BEGIN

    -- Rollback if invalid status transitions are detected
    IF EXISTS (
        SELECT 1 
        FROM inserted i
        JOIN deleted d ON i.transaction_id = d.transaction_id
        WHERE d.status = 'Completed' AND i.status <> d.status -- Prevent changing from Completed to any other status
           OR d.status = 'Failed' AND i.status <> d.status     -- Prevent changing from Failed to any other status
           OR d.status = 'Pending' AND i.status NOT IN ('Completed', 'Failed') -- Allow only valid transitions for Pending
    )
    BEGIN
        RAISERROR('Invalid transaction status transition.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;

GO


-- Test commands
-- GetCustomerAccountSummary stored procedure
DECLARE @TotalAccounts INT;
DECLARE @TotalBalance DECIMAL(15,2);

EXEC GetCustomerAccountSummary 
    @CustomerID = 1, 
    @TotalAccounts = @TotalAccounts OUTPUT, 
    @TotalBalance = @TotalBalance OUTPUT;

-- -- View the output parameters
SELECT @TotalAccounts AS TotalAccounts, @TotalBalance AS TotalBalance;




-- TransferMoney stored procedure
DECLARE @TransactionID INT;
DECLARE @Status NVARCHAR(20);

EXEC TransferMoney 
    @FromAccountID = 81, 
    @ToAccountID = 82, 
    @Amount = 500.00, 
    @TransactionID = @TransactionID OUTPUT, 
    @Status = @Status OUTPUT;

-- View the output parameters
SELECT @TransactionID AS TransactionID, @Status AS Status;

-- Verify the updated balances in both accounts
SELECT account_instrument_id, balance FROM Account WHERE account_instrument_id IN (81, 82);




-- ProcessLoanApplication stored procedure
DECLARE @LoanID INT;
DECLARE @ApprovalStatus NVARCHAR(20);
EXEC ProcessLoanApplication 
    @CustomerID = 1,
    @LoanType = 'Student',
    @LoanAmount = 20000.00,
    @EmployeeID = 1,
    @Term = 60,
    @LoanID = @LoanID OUTPUT,
    @ApprovalStatus = @ApprovalStatus OUTPUT;

-- View output parameters
SELECT @LoanID AS LoanID, @ApprovalStatus AS ApprovalStatus;
-- Verify that records were created successfully
SELECT * FROM Financial_Instrument WHERE instrument_id = @LoanID; -- Check Financial Instrument record
SELECT * FROM Loan WHERE loan_id = @LoanID; -- Check Loan record
SELECT * FROM Customer_Financial_Instrument WHERE instrument_id = @LoanID AND customer_id = 1; -- Check linkage record



DECLARE @TransactionID INT;
EXEC UpdateAccountBalance 
    @AccountID = 81, 
    @TransactionType = 'Deposit', 
    @Amount = 1000.00, 
    @Description = 'Monthly savings deposit', 
    @TransactionID = @TransactionID OUTPUT;
-- View the output parameter
SELECT @TransactionID AS TransactionID;
-- Verify that the balance was updated and the transaction was logged
SELECT balance FROM Account WHERE account_instrument_id = 81;
SELECT * FROM [Transaction] WHERE transaction_id = @TransactionID;



-- GetCustomerLoanDetails stored procedure
EXEC GetCustomerLoanDetails 
    @CustomerID = 1;







-- VIEWS
-- CustomerAccountsView
-- Query the CustomerAccountsView
SELECT * FROM CustomerAccountsView;

-- Example: Filter by a specific customer ID
SELECT * FROM CustomerAccountsView WHERE customer_id = 1;

-- Example: Filter by account type
SELECT * FROM CustomerAccountsView WHERE account_type = 'Savings';

-- Example: Sort by balance in descending order
SELECT * FROM CustomerAccountsView ORDER BY balance DESC;




-- LoanSummaryView
-- Query the LoanSummaryView
SELECT * FROM LoanSummaryView;

-- Example: Filter by a specific customer ID
SELECT * FROM LoanSummaryView WHERE customer_id = 1;

-- Example: Filter by loan type
SELECT * FROM LoanSummaryView WHERE loan_type = 'Student';

-- Example: Sort by loan amount in descending order
SELECT * FROM LoanSummaryView ORDER BY loan_amount DESC;




-- TransactionHistoryView
-- Query the TransactionHistoryView
SELECT * FROM TransactionHistoryView;

-- Example: Filter by a specific customer ID
SELECT * FROM TransactionHistoryView WHERE customer_id = 1;

-- Example: Filter by transaction type
SELECT * FROM TransactionHistoryView WHERE transaction_type = 'Deposit';

-- Example: Sort by transaction date in descending order
SELECT * FROM TransactionHistoryView ORDER BY date_time DESC;




-- BranchEmployeeSummaryView
-- Query the BranchEmployeeSummaryView
SELECT * FROM BranchEmployeeSummaryView;

-- Example: Filter by a specific branch name
SELECT * FROM BranchEmployeeSummaryView WHERE branch_name = 'Main Branch';

-- Example: Sort by employee salary in descending order
SELECT * FROM BranchEmployeeSummaryView ORDER BY salary DESC;

-- CustomerInvestmentSummaryView
-- Query the CustomerInvestmentSummaryView
SELECT * FROM CustomerInvestmentSummaryView;

-- Example: Filter by a specific customer ID
SELECT * FROM CustomerInvestmentSummaryView WHERE customer_id = 1;

-- Example: Filter by investment type
SELECT * FROM CustomerInvestmentSummaryView WHERE investment_type = 'Stocks';

-- Example: Sort by investment amount in descending order
SELECT * FROM CustomerInvestmentSummaryView ORDER BY investment_amount DESC;






-- UDFs
-- CalculateMonthlyPayment
-- Test 1: Calculate monthly payment for a loan with $20,000 principal, 4.5% annual rate, and 60 months term
SELECT dbo.CalculateMonthlyPayment(20000, 4.5, 60) AS MonthlyPayment;

-- Test 2: Calculate monthly payment for a loan with $30,000 principal, 5.5% annual rate, and 72 months term
SELECT dbo.CalculateMonthlyPayment(30000, 5.5, 72) AS MonthlyPayment;

-- Test 3: Calculate monthly payment for a loan with $50,000 principal, 3.5% annual rate, and 120 months term
SELECT dbo.CalculateMonthlyPayment(50000, 3.5, 120) AS MonthlyPayment;





-- CalculateYearlyInterest
-- Test 1: Calculate yearly interest for an account with $10,000 balance and 1.5% interest rate
SELECT dbo.CalculateYearlyInterest(10000, 1.5) AS YearlyInterest;

-- Test 2: Calculate yearly interest for an account with $15,000 balance and 2.0% interest rate
SELECT dbo.CalculateYearlyInterest(15000, 2.0) AS YearlyInterest;

-- Test 3: Calculate yearly interest for an account with $50,000 balance and 3.0% interest rate
SELECT dbo.CalculateYearlyInterest(50000, 3.0) AS YearlyInterest;





-- GetCustomerAge
SELECT dbo.GetCustomerAge(1) AS CustomerAge;
SELECT dbo.GetCustomerAge(2) AS CustomerAge;
SELECT dbo.GetCustomerAge(3) AS CustomerAge;




-- CalculateLoanInterest
-- Test 1: Calculate total loan interest for $20,000 principal at 4.5% annual rate over a term of 60 months
SELECT dbo.CalculateLoanInterest(20000, 4.5, 60) AS TotalLoanInterest;
-- Test 2: Calculate total loan interest for $30,000 principal at 5.5% annual rate over a term of 72 months
SELECT dbo.CalculateLoanInterest(30000, 5.5, 72) AS TotalLoanInterest;
-- Test 3: Calculate total loan interest for $50,000 principal at 3.5% annual rate over a term of 120 months
SELECT dbo.CalculateLoanInterest(50000, 3.5, 120) AS TotalLoanInterest;





-- GetBranchEmployeeCount
-- Test 1: Get the number of employees working in branch ID = 1
SELECT dbo.GetBranchEmployeeCount(1) AS EmployeeCountInBranch;
-- Test 2: Get the number of employees working in branch ID = 2
SELECT dbo.GetBranchEmployeeCount(2) AS EmployeeCountInBranch;
-- Test 3: Get the number of employees working in branch ID = 3 (if applicable)
SELECT dbo.GetBranchEmployeeCount(3) AS EmployeeCountInBranch;






-- TRIGGERS
-- AuditTransactionTrigger
-- Test 1: Insert a new transaction and verify that the description is updated with '| Audited'
INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, description, status)
VALUES (81, 'Account', 'Deposit', 1000.00, 'Initial deposit', 'Completed');

-- Verify that the description was updated
SELECT transaction_id, description FROM [Transaction] WHERE instrument_id = 81;



-- EnforceTransactionStatusRules
-- Test 1: Update a transaction from Pending to Completed (valid transition)
UPDATE [Transaction] SET status = 'Completed' WHERE transaction_id = 1;

-- Test 2: Attempt to update a transaction from Completed to Pending (invalid transition)
UPDATE [Transaction] SET status = 'Pending' WHERE transaction_id = 1;

-- Verify transactions in the table after updates
SELECT * FROM [Transaction] WHERE transaction_id = 1;
