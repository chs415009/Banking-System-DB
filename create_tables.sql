
IF DB_ID('BankingSystemDB') IS NULL
BEGIN
    CREATE DATABASE BankingSystemDB;
END;
GO

-- Switch to the database
USE BankingSystemDB;

-- Drop child tables first (tables referencing other tables)
DROP TABLE IF EXISTS Customer_Financial_Instrument;
DROP TABLE IF EXISTS [Transaction];
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Credit_Card;
DROP TABLE IF EXISTS Vehicle_Insurance;
DROP TABLE IF EXISTS Property_Insurance;
DROP TABLE IF EXISTS Health_Insurance;
DROP TABLE IF EXISTS Insurance;
DROP TABLE IF EXISTS Student_Loan;
DROP TABLE IF EXISTS Mortgage_Loan;
DROP TABLE IF EXISTS Business_Loan;
DROP TABLE IF EXISTS Vehicle_Loan;
DROP TABLE IF EXISTS Loan;
DROP TABLE IF EXISTS Financial_Instrument;
DROP TABLE IF EXISTS Investment;
DROP TABLE IF EXISTS Online_Banking;
DROP TABLE IF EXISTS Beneficiary;
DROP TABLE IF EXISTS Customer;

-- Drop tables with circular references carefully
IF OBJECT_ID('Branch', 'U') IS NOT NULL
    ALTER TABLE Branch DROP CONSTRAINT IF EXISTS FK_Branch_Manager;
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    ALTER TABLE Employee DROP CONSTRAINT IF EXISTS FK__Employee__branch_id;
IF OBJECT_ID('Employee', 'U') IS NOT NULL
    ALTER TABLE Employee DROP CONSTRAINT IF EXISTS FK__Employee__manager_id;

-- Now safely drop Employee and Branch
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Branch;

-- Create Branch table without foreign key
CREATE TABLE Branch (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_name NVARCHAR(100) NOT NULL,
    branch_code NVARCHAR(50) NOT NULL,
    address NVARCHAR(255) NOT NULL,
    phone_number NVARCHAR(15) NOT NULL
);

-- Create Employee table
CREATE TABLE Employee (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT NOT NULL,
    manager_id INT NULL,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL CHECK (salary > 0),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id)
);

-- Add foreign key to Branch table
ALTER TABLE Branch
ADD manager_id INT NULL;
ALTER TABLE Branch
ADD CONSTRAINT FK_Branch_Manager FOREIGN KEY (manager_id) REFERENCES Employee(employee_id);

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_id INT NOT NULL,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL CHECK (date_of_birth < GETDATE()), -- Ensure DOB is in the past
    address_line_1 NVARCHAR(255),
    address_line_2 NVARCHAR(255),
    email NVARCHAR(255),
    zip_code NVARCHAR(10),
    phone_number NVARCHAR(15),
    ssn NVARCHAR(11),
    customer_type NVARCHAR(50) CHECK (customer_type IN ('Individual', 'Business')),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

-- Create Beneficiary table
CREATE TABLE Beneficiary (
    beneficiary_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    name NVARCHAR(255),
    relationship NVARCHAR(255),
    contact_information NVARCHAR(255),
    account_number BIGINT UNIQUE CHECK(account_number IS NOT NULL AND account_number > 0),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Online_Banking table
CREATE TABLE Online_Banking (
   online_banking_id INT IDENTITY(1,1) PRIMARY KEY,
   customer_id INT NOT NULL UNIQUE,
   username NVARCHAR(50),
   password_hash NVARCHAR(255),
   last_login_timestamp DATETIME DEFAULT GETDATE(),
   two_factor_authentication_status BIT DEFAULT 0 CHECK (two_factor_authentication_status IN (0, 1)), -- Valid status values
   FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- Create Investment table
CREATE TABLE Investment (
   investment_id INT IDENTITY(1,1) PRIMARY KEY,
   customer_id INT NOT NULL,
   investment_type NVARCHAR(255),
   investment_amount DECIMAL(10,2) CHECK (investment_amount > 0), 
   risk_profile NVARCHAR(255),
   maturity_date DATE CHECK (maturity_date >= GETDATE()), 
   FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);



-- Create Financial Instrument table (supertype)
CREATE TABLE Financial_Instrument (
    instrument_id INT IDENTITY(1,1) PRIMARY KEY,
    instrument_type NVARCHAR(50) NOT NULL CHECK (instrument_type IN ('Loan', 'Insurance', 'Credit Card', 'Account')),
    status NVARCHAR(20) NOT NULL CHECK (status IN ('Active', 'Inactive', 'Closed'))
);

-- Create Loan table (subtype of Financial Instrument)
CREATE TABLE Loan (
    loan_id INT PRIMARY KEY,
    processed_by_employee_id INT NOT NULL,
    loan_type NVARCHAR(50) NOT NULL CHECK (loan_type IN ('Vehicle', 'Student', 'Mortgage', 'Business')),
    loan_amount DECIMAL(10,2) CHECK (loan_amount > 0),
    interest_rate DECIMAL(5,2),
    term INT,
    start_date DATE,
    end_date DATE,
    status NVARCHAR(20),
    FOREIGN KEY (loan_id) REFERENCES Financial_Instrument(instrument_id),
    FOREIGN KEY (processed_by_employee_id) REFERENCES Employee(employee_id)
);

-- Create Vehicle Loan table (subtype of Loan)
CREATE TABLE Vehicle_Loan (
   vehicle_loan_id INT PRIMARY KEY,
   vehicle_type NVARCHAR(255),
   make NVARCHAR(255),
   model NVARCHAR(255),
   year INT CHECK (year > 1900 AND year <= YEAR(GETDATE())),
   vin NVARCHAR(255),
   FOREIGN KEY (vehicle_loan_id) REFERENCES Loan(loan_id)
);

-- Create Business Loan table (subtype of Loan)
CREATE TABLE Business_Loan (
   business_loan_id INT PRIMARY KEY,
   business_name NVARCHAR(255),
   business_type NVARCHAR(255),
   business_revenue DECIMAL(15,2),
   FOREIGN KEY (business_loan_id) REFERENCES Loan(loan_id)
);

-- Create Mortgage Loan table (subtype of Loan)
CREATE TABLE Mortgage_Loan (
   mortgage_loan_id INT PRIMARY KEY,
   property_address NVARCHAR(255),
   property_value DECIMAL(15,2),
   property_tax DECIMAL(15,2),
   down_payment_amount DECIMAL(15,2),
   FOREIGN KEY (mortgage_loan_id) REFERENCES Loan(loan_id) 
);

-- Create Student Loan table (subtype of Loan)
CREATE TABLE Student_Loan (
   student_loan_id INT PRIMARY KEY,
   school_name NVARCHAR(255),
   tuition_amount DECIMAL(15,2),
   graduation_date DATE,
   cosigner NVARCHAR(255),
   FOREIGN KEY (student_loan_id) REFERENCES Loan(loan_id) 
);

-- Create Insurance table (subtype of Financial Instrument)
CREATE TABLE Insurance (
    insurance_id INT PRIMARY KEY, -- insurance_id is both primary key and foreign key
    premium_amount DECIMAL(10,2) NOT NULL CHECK (premium_amount > 0), -- Ensure positive premium amounts
    coverage_amount DECIMAL(10,2) NOT NULL CHECK (coverage_amount > 0), -- Ensure positive coverage amounts
    insurance_type NVARCHAR(50) NOT NULL CHECK (insurance_type IN ('Health', 'Property', 'Vehicle')), -- Restricted values
    policy_start_date DATE NOT NULL,
    policy_end_date DATE NOT NULL,
    claim_status NVARCHAR(50),
    FOREIGN KEY (insurance_id) REFERENCES Financial_Instrument(instrument_id),
    CONSTRAINT CHK_PolicyDates CHECK (policy_end_date > policy_start_date) -- Table-level constraint for date validation
);

-- Create Health Insurance table (subtype of Insurance)
CREATE TABLE Health_Insurance (
    health_insurance_id INT PRIMARY KEY, 
    health_plan_type NVARCHAR(255) NOT NULL,
    FOREIGN KEY (health_insurance_id) REFERENCES Insurance(insurance_id)
);

-- Create Property Insurance table (subtype of Insurance)
CREATE TABLE Property_Insurance (
    property_insurance_id INT PRIMARY KEY,
    property_type NVARCHAR(255) NOT NULL,
    construction_year INT NOT NULL CHECK (construction_year > 1900 AND construction_year <= YEAR(GETDATE())), 
    market_value DECIMAL(15,2) NOT NULL CHECK (market_value > 0),
    FOREIGN KEY (property_insurance_id) REFERENCES Insurance(insurance_id) 
);

-- Create Vehicle Insurance table (subtype of Insurance)
CREATE TABLE Vehicle_Insurance (
    vehicle_insurance_id INT PRIMARY KEY,
    vehicle_type NVARCHAR(255) NOT NULL,
    make NVARCHAR(255),
    model NVARCHAR(255),
    year INT NOT NULL CHECK (year > 1900 AND year <= YEAR(GETDATE())), 
    vin NVARCHAR(255),
    FOREIGN KEY (vehicle_insurance_id) REFERENCES Insurance(insurance_id) 
);

-- Create Credit Card table (subtype of Financial Instrument)
CREATE TABLE Credit_Card (
    credit_card_id INT PRIMARY KEY, 
    expiration_date DATE NOT NULL CHECK (expiration_date > GETDATE()), 
    credit_limit DECIMAL(10,2) NOT NULL CHECK (credit_limit > 0),
    current_balance DECIMAL(10,2) NOT NULL CHECK (current_balance >= 0),
    FOREIGN KEY (credit_card_id) REFERENCES Financial_Instrument(instrument_id)
);

-- Create Account table (subtype of Financial Instrument)
CREATE TABLE Account (
    account_instrument_id INT PRIMARY KEY, 
    branch_id INT NOT NULL, 
    account_number BIGINT UNIQUE NOT NULL, 
    date_added DATE DEFAULT GETDATE(), 
    balance DECIMAL(10,2) NOT NULL CHECK (balance >= 0), 
    opening_date DATE NOT NULL,
    account_type NVARCHAR(50) NOT NULL CHECK (account_type IN ('Savings', 'Checking', 'Money Market')), 
    interest_rate DECIMAL(5,2) CHECK (interest_rate >= 0), 
    FOREIGN KEY (account_instrument_id) REFERENCES Financial_Instrument(instrument_id), 
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) 
);

-- Create Transaction table
CREATE TABLE [Transaction] (
    transaction_id INT IDENTITY(1,1) PRIMARY KEY, 
    instrument_id INT NOT NULL, 
    instrument_type NVARCHAR(50) NOT NULL CHECK (instrument_type IN ('Loan', 'Insurance', 'Credit Card', 'Account')), 
    transaction_type NVARCHAR(50) NOT NULL CHECK (transaction_type IN ('Deposit', 'Withdrawal', 'Payment', 'Transfer')), 
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0), 
    date_time DATETIME DEFAULT GETDATE(), 
    description NVARCHAR(MAX),
    status NVARCHAR(20) NOT NULL CHECK (status IN ('Pending', 'Completed', 'Failed')),
    FOREIGN KEY (instrument_id) REFERENCES Financial_Instrument(instrument_id)
);

-- Create Customer_Financial_Instrument associative table
CREATE TABLE Customer_Financial_Instrument (
    customer_id INT NOT NULL, 
    instrument_id INT NOT NULL,
    role NVARCHAR(50) NOT NULL CHECK (role IN ('Owner', 'Co-Owner')),
    enrollment_date DATE DEFAULT GETDATE(), 
    PRIMARY KEY (customer_id, instrument_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (instrument_id) REFERENCES Financial_Instrument(instrument_id)
);