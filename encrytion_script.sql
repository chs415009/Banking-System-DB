USE BankingSystemDB;
GO

-- Step 1: Create a master key in the database
-- This is the first step in setting up column encryption
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Banking@Str0ngP@ssw0rd2025';
    -- PRINT 'Database Master Key created.';
END
ELSE
BEGIN
    -- PRINT 'Database Master Key already exists.';
END
GO

-- Step 2: Create a certificate to protect the column encryption keys
IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'BankingEncryptionCert')
BEGIN
    CREATE CERTIFICATE BankingEncryptionCert
    WITH SUBJECT = 'Certificate for Column Encryption in Banking System';
    -- PRINT 'Certificate created.';
END
ELSE
BEGIN
    -- PRINT 'Certificate already exists.';
END
GO

-- Step 3: Create symmetric keys for different types of data
-- Key for personal identification data (SSN, etc.)
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'PII_EncryptionKey')
BEGIN
    CREATE SYMMETRIC KEY PII_EncryptionKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE BankingEncryptionCert;
    -- PRINT 'PII Encryption Key created.';
END
ELSE
BEGIN
    -- PRINT 'PII Encryption Key already exists.';
END
GO

-- Key for financial data (account numbers, etc.)
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'Financial_EncryptionKey')
BEGIN
    CREATE SYMMETRIC KEY Financial_EncryptionKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE BankingEncryptionCert;
    -- PRINT 'Financial Encryption Key created.';
END
ELSE
BEGIN
    -- PRINT 'Financial Encryption Key already exists.';
END
GO

-- Key for authentication data (passwords, etc.)
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'Auth_EncryptionKey')
BEGIN
    CREATE SYMMETRIC KEY Auth_EncryptionKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE BankingEncryptionCert;
    -- PRINT 'Authentication Encryption Key created.';
END
ELSE
BEGIN
    -- PRINT 'Authentication Encryption Key already exists.';
END
GO

-- Step 4: Add encrypted columns to the tables and migrate data

-- 1. Customer table - Encrypt SSN
-- First check if the encrypted column exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'ssn_encrypted' AND object_id = OBJECT_ID('Customer'))
BEGIN
    -- Add encrypted column
    ALTER TABLE Customer ADD ssn_encrypted VARBINARY(256);
    -- PRINT 'Added encrypted SSN column to Customer table.';
END
ELSE
BEGIN
    -- PRINT 'Encrypted SSN column already exists in Customer table.';
END
GO

-- Now encrypt the data in the newly added column
IF EXISTS (SELECT * FROM sys.columns WHERE name = 'ssn_encrypted' AND object_id = OBJECT_ID('Customer'))
BEGIN
    -- Encrypt existing data
    OPEN SYMMETRIC KEY PII_EncryptionKey DECRYPTION BY CERTIFICATE BankingEncryptionCert;
    
    UPDATE Customer
    SET ssn_encrypted = EncryptByKey(Key_GUID('PII_EncryptionKey'), ssn, 1, CONVERT(VARBINARY, customer_id));
    
    CLOSE SYMMETRIC KEY PII_EncryptionKey;
    -- PRINT 'Encrypted existing SSN data.';
END
GO

-- 2. Online_Banking table - Encrypt password hash
-- First check if the encrypted column exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'password_hash_encrypted' AND object_id = OBJECT_ID('Online_Banking'))
BEGIN
    -- Add encrypted column
    ALTER TABLE Online_Banking ADD password_hash_encrypted VARBINARY(512);
    -- PRINT 'Added encrypted password hash column to Online_Banking table.';
END
ELSE
BEGIN
    -- PRINT 'Encrypted password hash column already exists in Online_Banking table.';
END
GO

-- Now encrypt the data in the newly added column
IF EXISTS (SELECT * FROM sys.columns WHERE name = 'password_hash_encrypted' AND object_id = OBJECT_ID('Online_Banking'))
BEGIN
    -- Encrypt existing data
    OPEN SYMMETRIC KEY Auth_EncryptionKey DECRYPTION BY CERTIFICATE BankingEncryptionCert;
    
    UPDATE Online_Banking
    SET password_hash_encrypted = EncryptByKey(Key_GUID('Auth_EncryptionKey'), password_hash, 1, CONVERT(VARBINARY, online_banking_id));
    
    CLOSE SYMMETRIC KEY Auth_EncryptionKey;
    -- PRINT 'Encrypted existing password hash data.';
END
GO

-- 3. Account table - Encrypt account number
-- First check if the encrypted column exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'account_number_encrypted' AND object_id = OBJECT_ID('Account'))
BEGIN
    -- Add encrypted column
    ALTER TABLE Account ADD account_number_encrypted VARBINARY(256);
    -- PRINT 'Added encrypted account number column to Account table.';
END
ELSE
BEGIN
    -- PRINT 'Encrypted account number column already exists in Account table.';
END
GO

-- Now encrypt the data in the newly added column
IF EXISTS (SELECT * FROM sys.columns WHERE name = 'account_number_encrypted' AND object_id = OBJECT_ID('Account'))
BEGIN
    -- Encrypt existing data
    OPEN SYMMETRIC KEY Financial_EncryptionKey DECRYPTION BY CERTIFICATE BankingEncryptionCert;
    
    UPDATE Account
    SET account_number_encrypted = EncryptByKey(Key_GUID('Financial_EncryptionKey'), 
                                              CONVERT(VARCHAR(20), account_number), 
                                              1, 
                                              CONVERT(VARBINARY, account_instrument_id));
    
    CLOSE SYMMETRIC KEY Financial_EncryptionKey;
    -- PRINT 'Encrypted existing account number data.';
END
GO

-- 4. Credit_Card table - Encrypt credit card data
-- First check if the encrypted column exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'credit_limit_encrypted' AND object_id = OBJECT_ID('Credit_Card'))
BEGIN
    -- Add encrypted column
    ALTER TABLE Credit_Card ADD credit_limit_encrypted VARBINARY(256);
    -- PRINT 'Added encrypted credit limit column to Credit_Card table.';
END
ELSE
BEGIN
    -- PRINT 'Encrypted credit limit column already exists in Credit_Card table.';
END
GO

-- Now encrypt the data in the newly added column
IF EXISTS (SELECT * FROM sys.columns WHERE name = 'credit_limit_encrypted' AND object_id = OBJECT_ID('Credit_Card'))
BEGIN
    -- Encrypt existing data
    OPEN SYMMETRIC KEY Financial_EncryptionKey DECRYPTION BY CERTIFICATE BankingEncryptionCert;
    
    UPDATE Credit_Card
    SET credit_limit_encrypted = EncryptByKey(Key_GUID('Financial_EncryptionKey'), 
                                            CONVERT(VARCHAR(20), credit_limit), 
                                            1, 
                                            CONVERT(VARBINARY, credit_card_id));
    
    CLOSE SYMMETRIC KEY Financial_EncryptionKey;
    -- PRINT 'Encrypted existing credit limit data.';
END
GO

-- 5. Beneficiary table - Encrypt account number
-- First check if the encrypted column exists
IF NOT EXISTS (SELECT * FROM sys.columns WHERE name = 'account_number_encrypted' AND object_id = OBJECT_ID('Beneficiary'))
BEGIN
    -- Add encrypted column
    ALTER TABLE Beneficiary ADD account_number_encrypted VARBINARY(256);
    -- PRINT 'Added encrypted account number column to Beneficiary table.';
END
ELSE
BEGIN
    -- PRINT 'Encrypted account number column already exists in Beneficiary table.';
END
GO

-- Now encrypt the data in the newly added column
IF EXISTS (SELECT * FROM sys.columns WHERE name = 'account_number_encrypted' AND object_id = OBJECT_ID('Beneficiary'))
BEGIN
    -- Encrypt existing data
    OPEN SYMMETRIC KEY Financial_EncryptionKey DECRYPTION BY CERTIFICATE BankingEncryptionCert;
    
    UPDATE Beneficiary
    SET account_number_encrypted = EncryptByKey(Key_GUID('Financial_EncryptionKey'), 
                                              CONVERT(VARCHAR(20), account_number), 
                                              1, 
                                              CONVERT(VARBINARY, beneficiary_id));
    
    CLOSE SYMMETRIC KEY Financial_EncryptionKey;
    -- PRINT 'Encrypted existing beneficiary account number data.';
END
GO