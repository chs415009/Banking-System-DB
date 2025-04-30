USE BankingSystemDB;

GO
-- Non-clustered index on Customer table for faster lookups by email
CREATE NONCLUSTERED INDEX NCI_Customer_Email
ON Customer(email);

GO

-- Non-clustered index on Account table for quicker balance queries
CREATE NONCLUSTERED INDEX NCI_Account_Balance
ON Account(balance DESC);

GO

-- Non-clustered index on Transaction table for efficient date-based queries
CREATE NONCLUSTERED INDEX NCI_Transaction_DateTime
ON [Transaction](date_time DESC);

GO

-- Non-clustered index on Customer table for name-based searches
CREATE NONCLUSTERED INDEX NCI_Customer_Name
ON Customer(last_name, first_name);

GO

-- Non-clustered index on Loan table for interest rate analysis
CREATE NONCLUSTERED INDEX NCI_Loan_InterestRate
ON Loan(interest_rate, loan_type);

GO

-- Composite non-clustered index on Transaction table for instrument-based queries
CREATE NONCLUSTERED INDEX NCI_Transaction_Instrument
ON [Transaction](instrument_id, instrument_type, transaction_type);

GO

-- Non-clustered index on Customer_Financial_Instrument for ownership queries
CREATE NONCLUSTERED INDEX NCI_CFI_CustomerInstrument
ON Customer_Financial_Instrument(customer_id, instrument_id, role);

GO

-- Filtered non-clustered index for active loans only
CREATE NONCLUSTERED INDEX NCI_Loan_Active
ON Loan(loan_id, loan_type, loan_amount)
WHERE status = 'Active';

GO

-- Include columns in non-clustered index for covering queries
CREATE NONCLUSTERED INDEX NCI_Account_Type
ON Account(account_type)
INCLUDE (balance, interest_rate);
