USE BankingSystemDB;

-- Branch (10 rows)
INSERT INTO Branch (branch_name, branch_code, address, phone_number) VALUES 
('Main Branch', 'MB001', '123 Main St', '123-456-7890'),
('Downtown Branch', 'DB002', '456 Downtown Ave', '987-654-3210'),
('Uptown Branch', 'UB003', '789 Uptown Blvd', '555-123-4567'),
('Westside Branch', 'WB004', '101 Westside Rd', '555-987-6543'),
('Eastside Branch', 'EB005', '202 Eastside Ave', '555-222-3333'),
('Northside Branch', 'NB006', '303 Northside Blvd', '555-444-5555'),
('Southside Branch', 'SB007', '404 Southside St', '555-666-7777'),
('Central Branch', 'CB008', '505 Central Ave', '555-888-9999'),
('Lakeside Branch', 'LB009', '606 Lakeside Dr', '555-000-1111'),
('Riverside Branch', 'RB010', '707 Riverside Blvd', '555-333-2222');

-- Employee (10 rows)
INSERT INTO Employee (branch_id, manager_id, first_name, last_name, hire_date, salary) VALUES 
(1, NULL, 'John','Doe','2020-01-01',50000),
(1, 1,'Jane','Smith','2020-02-01',60000),
(2,NULL,'Bob','Johnson','2020-03-01',55000),
(3,NULL,'Alice','Williams','2020-04-01',52000),
(4,NULL,'Mike','Brown','2020-05-01',58000),
(5,NULL,'Emily','Davis','2020-06-01',54000),
(6,NULL,'David','Miller','2020-07-01',56000),
(7,NULL,'Sarah','Wilson','2020-08-01',57000),
(8,NULL,'Chris','Taylor','2020-09-01',53000),
(9,NULL,'Laura','Anderson','2020-10-01',59000);

-- Update Branch managers
UPDATE Branch SET manager_id=1 WHERE branch_id=1;
UPDATE Branch SET manager_id=3 WHERE branch_id=2;

-- Customer (10 rows)
INSERT INTO Customer(branch_id,first_name,last_name,date_of_birth,address_line_1,address_line_2,email,zip_code,phone_number,ssn,customer_type) VALUES
(1,'Alice','Brown','1990-01-01','789 Oak St','','alice@example.com','12345','5551234567','123456789','Individual'),
(2,'Bob','Smith','1985-06-01','901 Maple St','','bob@example.com','67890','5559876543','987654321','Individual'),
(3,'Jane','Doe','1992-01-01','456 Elm St','','jane@example.com','34567','5551112222','111223333','Individual'),
(4,'Tom','Harris','1988-04-15','321 Pine St','','tom@example.com','54321','5554443333','444556666','Business'),
(5,'Mary','Clarkson','1975-07-20','654 Cedar St','','mary@example.com','98765','5557778888','777889999','Individual'),
(6,'Steve','Adams','1982-03-22','852 Birch Rd','','steve@example.com','11223','5552221111','222334444','Business'),
(7,'Nancy','Whitehead','1995-11-30','963 Spruce Ave','','nancy@example.com','44556','5556667777','666778888','Individual'),
(8,'Pauline ','Greenfield ','1989 -09 -17 ','147 Ash Dr','','pauline@example.com ','77889 ','5558889999 ','888990000 ','Business'),
(9,'George ','Blackwell ','1978 -12 -05 ','258 Willow Ln','','george@example.com ','99000 ','5550001111 ','000112222 ','Individual'),
(10,'Linda ','Stone ','1993 -02 -14 ','369 Poplar Ct','','linda@example.com ','22334 ','5553334444 ','333445555 ','Individual');

-- Beneficiary (10 rows)
INSERT INTO Beneficiary(customer_id,name,relationship,contact_information,account_number) VALUES
(1,'Emily Brown ','Daughter ','emily@example.com ',1234567890),
(2,'Sarah Davis ','Wife ','sarah@example.com ',9876543210),
(3,'Mark Doe ','Brother ','mark@example.com ',1234567891),
(4,'Anna Harris ','Wife ','anna@example.com ',9876543211),
(5,'Luke Clarkson ','Son ','luke@example.com ',1234567892),
(6,'Rachel Adams ','Sister ','rachel@example.com ',9876543212),
(7,'Oliver Whitehead ','Son ','oliver@example.com ',1234567893),
(8,'Sophia Greenfield ','Daughter ','sophia@example.com ',9876543213),
(9,'Henry Blackwell ','Father ','henry@example.com ',1234567894),
(10,'Grace Stone ','Mother ','grace@example.com ',9876543214);

-- Online_Banking (10 rows)
INSERT INTO Online_Banking(customer_id,username,password_hash,two_factor_authentication_status) VALUES
(1,'alice123','#hash1#',0),
(2,'bob123','#hash2#',1),
(3,'janeD','#hash3#',1),
(4,'tomH','#hash4#',0),
(5,'maryC','#hash5#',1),
(6,'steveA','#hash6#',0),
(7,'nancyW','#hash7#',1),
(8,'paulineG','#hash8#',0),
(9,'georgeB','#hash9#',1),
(10,'lindaS','#hash10#',0);

-- Insert into Investment table
INSERT INTO Investment (customer_id, investment_type, investment_amount, risk_profile, maturity_date)
VALUES 
(1, 'Stocks', 10000.00, 'High', '2026-01-01'),
(2, 'Bonds', 50000.00, 'Low', '2027-01-01'),
(3, 'Mutual Funds', 20000.00, 'Medium', '2026-06-01'),
(4, 'Real Estate', 75000.00, 'High', '2028-01-01'),
(5, 'Cryptocurrency', 15000.00, 'High', '2026-12-01'),
(6, 'Commodities', 30000.00, 'Medium', '2027-03-01'),
(7, 'Index Funds', 40000.00, 'Low', '2027-09-01'),
(8, 'ETFs', 25000.00, 'Medium', '2026-11-01'),
(9, 'Government Bonds', 60000.00, 'Low', '2028-05-01'),
(10, 'Private Equity', 100000.00, 'High', '2029-01-01');

-- Insert into Financial_Instrument table for Loan records (40 records)
INSERT INTO Financial_Instrument (instrument_type, status)
VALUES 
-- Student Loans (10)
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
-- Business Loans (10)
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
-- Vehicle Loans (10)
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
-- Mortgage Loans (10)
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active'),
('Loan', 'Active');

-- Insert into Loan table (40 records)
INSERT INTO Loan (loan_id, processed_by_employee_id, loan_type, loan_amount, interest_rate, term, start_date, end_date, status)
VALUES 
-- Student Loans (10)
(1, 1, 'Student', 20000.00, 4.5, 60, '2025-01-01', '2030-01-01', 'Active'),
(2, 2, 'Student', 15000.00, 4.2, 48, '2025-01-15', '2029-01-15', 'Active'),
(3, 3, 'Student', 25000.00, 4.7, 72, '2025-02-01', '2031-02-01', 'Active'),
(4, 1, 'Student', 18000.00, 4.3, 60, '2025-02-15', '2030-02-15', 'Active'),
(5, 2, 'Student', 22000.00, 4.6, 60, '2025-03-01', '2030-03-01', 'Active'),
(6, 3, 'Student', 30000.00, 4.8, 84, '2025-03-15', '2032-03-15', 'Active'),
(7, 1, 'Student', 17500.00, 4.4, 48, '2025-04-01', '2029-04-01', 'Active'),
(8, 2, 'Student', 28000.00, 4.9, 72, '2025-04-15', '2031-04-15', 'Active'),
(9, 3, 'Student', 19500.00, 4.5, 60, '2025-05-01', '2030-05-01', 'Active'),
(10, 1, 'Student', 23500.00, 4.7, 60, '2025-05-15', '2030-05-15', 'Active'),
-- Business Loans (10)
(11, 2, 'Business', 500000.00, 6.0, 120, '2025-01-01', '2035-01-01', 'Active'),
(12, 3, 'Business', 350000.00, 5.8, 96, '2025-01-15', '2033-01-15', 'Active'),
(13, 1, 'Business', 750000.00, 6.2, 180, '2025-02-01', '2040-02-01', 'Active'),
(14, 2, 'Business', 400000.00, 5.9, 120, '2025-02-15', '2035-02-15', 'Active'),
(15, 3, 'Business', 600000.00, 6.1, 144, '2025-03-01', '2037-03-01', 'Active'),
(16, 1, 'Business', 300000.00, 5.7, 84, '2025-03-15', '2032-03-15', 'Active'),
(17, 2, 'Business', 850000.00, 6.3, 180, '2025-04-01', '2040-04-01', 'Active'),
(18, 3, 'Business', 425000.00, 5.9, 120, '2025-04-15', '2035-04-15', 'Active'),
(19, 1, 'Business', 575000.00, 6.0, 144, '2025-05-01', '2037-05-01', 'Active'),
(20, 2, 'Business', 650000.00, 6.2, 156, '2025-05-15', '2038-05-15', 'Active'),
-- Vehicle Loans (10)
(21, 3, 'Vehicle', 30000.00, 5.5, 60, '2025-01-01', '2030-01-01', 'Active'),
(22, 1, 'Vehicle', 25000.00, 5.3, 48, '2025-01-15', '2029-01-15', 'Active'),
(23, 2, 'Vehicle', 35000.00, 5.6, 60, '2025-02-01', '2030-02-01', 'Active'),
(24, 3, 'Vehicle', 28000.00, 5.4, 48, '2025-02-15', '2029-02-15', 'Active'),
(25, 1, 'Vehicle', 32000.00, 5.5, 60, '2025-03-01', '2030-03-01', 'Active'),
(26, 2, 'Vehicle', 40000.00, 5.7, 72, '2025-03-15', '2031-03-15', 'Active'),
(27, 3, 'Vehicle', 27500.00, 5.4, 48, '2025-04-01', '2029-04-01', 'Active'),
(28, 1, 'Vehicle', 38000.00, 5.6, 60, '2025-04-15', '2030-04-15', 'Active'),
(29, 2, 'Vehicle', 29500.00, 5.5, 48, '2025-05-01', '2029-05-01', 'Active'),
(30, 3, 'Vehicle', 33500.00, 5.6, 60, '2025-05-15', '2030-05-15', 'Active'),
-- Mortgage Loans (10)
(31, 1, 'Mortgage', 200000.00, 3.5, 360, '2025-01-01', '2055-01-01', 'Active'),
(32, 2, 'Mortgage', 250000.00, 3.6, 360, '2025-01-15', '2055-01-15', 'Active'),
(33, 3, 'Mortgage', 300000.00, 3.7, 360, '2025-02-01', '2055-02-01', 'Active'),
(34, 1, 'Mortgage', 275000.00, 3.6, 360, '2025-02-15', '2055-02-15', 'Active'),
(35, 2, 'Mortgage', 325000.00, 3.7, 360, '2025-03-01', '2055-03-01', 'Active'),
(36, 3, 'Mortgage', 350000.00, 3.8, 360, '2025-03-15', '2055-03-15', 'Active'),
(37, 1, 'Mortgage', 225000.00, 3.5, 360, '2025-04-01', '2055-04-01', 'Active'),
(38, 2, 'Mortgage', 375000.00, 3.8, 360, '2025-04-15', '2055-04-15', 'Active'),
(39, 3, 'Mortgage', 400000.00, 3.9, 360, '2025-05-01', '2055-05-01', 'Active'),
(40, 1, 'Mortgage', 450000.00, 4.0, 360, '2025-05-15', '2055-05-15', 'Active');

-- Insert into Student_Loan table (10 records)
INSERT INTO Student_Loan (student_loan_id, school_name, tuition_amount, graduation_date, cosigner)
VALUES 
(1, 'Harvard University', 50000.00, '2027-06-01', 'John Doe'),
(2, 'Stanford University', 45000.00, '2027-05-15', 'Mary Johnson'),
(3, 'MIT', 55000.00, '2028-06-01', 'Robert Smith'),
(4, 'Yale University', 48000.00, '2027-06-15', 'Patricia Brown'),
(5, 'Princeton University', 52000.00, '2028-05-01', 'Michael Wilson'),
(6, 'Columbia University', 60000.00, '2029-06-01', 'Elizabeth Taylor'),
(7, 'Cornell University', 47500.00, '2027-05-01', 'David Miller'),
(8, 'University of Chicago', 58000.00, '2028-06-15', 'Jennifer Davis'),
(9, 'University of Pennsylvania', 49500.00, '2027-06-30', 'Richard Moore'),
(10, 'Dartmouth College', 53500.00, '2028-05-15', 'Susan Anderson');

-- Insert into Business_Loan table (10 records)
INSERT INTO Business_Loan (business_loan_id, business_name, business_type, business_revenue)
VALUES 
(11, 'TechCorp LLC', 'Technology', 500000.00),
(12, 'Green Energy Solutions', 'Renewable Energy', 350000.00),
(13, 'Global Logistics Inc', 'Transportation', 750000.00),
(14, 'Innovative Healthcare', 'Healthcare', 400000.00),
(15, 'Urban Development Group', 'Real Estate', 600000.00),
(16, 'Organic Foods Market', 'Retail', 300000.00),
(17, 'Advanced Manufacturing Co', 'Manufacturing', 850000.00),
(18, 'Digital Marketing Agency', 'Marketing', 425000.00),
(19, 'Financial Advisory Partners', 'Financial Services', 575000.00),
(20, 'Hospitality Management Group', 'Hospitality', 650000.00);

-- Insert into Vehicle_Loan table (10 records)
INSERT INTO Vehicle_Loan (vehicle_loan_id, vehicle_type, make, model, year, vin)
VALUES 
(21, 'Car', 'Toyota', 'Camry', 2023, 'VIN12345678901234'),
(22, 'Car', 'Honda', 'Accord', 2023, 'VIN23456789012345'),
(23, 'SUV', 'Ford', 'Explorer', 2024, 'VIN34567890123456'),
(24, 'Car', 'Chevrolet', 'Malibu', 2023, 'VIN45678901234567'),
(25, 'SUV', 'Toyota', 'RAV4', 2024, 'VIN56789012345678'),
(26, 'Truck', 'Ford', 'F-150', 2024, 'VIN67890123456789'),
(27, 'Car', 'Nissan', 'Altima', 2023, 'VIN78901234567890'),
(28, 'SUV', 'Honda', 'CR-V', 2024, 'VIN89012345678901'),
(29, 'Car', 'Hyundai', 'Sonata', 2023, 'VIN90123456789012'),
(30, 'SUV', 'Subaru', 'Outback', 2024, 'VIN01234567890123');

-- Insert into Mortgage_Loan table (10 records)
INSERT INTO Mortgage_Loan (mortgage_loan_id, property_address, property_value, property_tax, down_payment_amount)
VALUES 
(31, '123 Main St, Boston, MA', 250000.00, 5000.00, 50000.00),
(32, '456 Oak Ave, New York, NY', 300000.00, 6000.00, 60000.00),
(33, '789 Pine Rd, Los Angeles, CA', 350000.00, 7000.00, 70000.00),
(34, '321 Maple Dr, Chicago, IL', 325000.00, 6500.00, 65000.00),
(35, '654 Cedar Ln, Miami, FL', 375000.00, 7500.00, 75000.00),
(36, '987 Birch Ct, Seattle, WA', 400000.00, 8000.00, 80000.00),
(37, '147 Elm St, Austin, TX', 275000.00, 5500.00, 55000.00),
(38, '258 Spruce Ave, Denver, CO', 425000.00, 8500.00, 85000.00),
(39, '369 Willow Rd, Portland, OR', 450000.00, 9000.00, 90000.00),
(40, '159 Redwood Dr, San Francisco, CA', 500000.00, 10000.00, 100000.00);

-- Insert into Financial_Instrument table for Insurance records
INSERT INTO Financial_Instrument (instrument_type, status)
VALUES 
-- health insurance
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
-- property insurnace
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
-- vehicle insurance
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active'),
('Insurance', 'Active');

-- Insert into Insurance table (IDs 41-70)
INSERT INTO Insurance (insurance_id, premium_amount, coverage_amount, insurance_type, policy_start_date, policy_end_date, claim_status)
VALUES 
-- Health Insurance (41-50)
(41, 200, 100000, 'Health', '2025-01-01', '2026-01-01', 'Pending'),
(42, 210, 105000, 'Health', '2025-01-02', '2026-01-02', 'Pending'),
(43, 220, 110000, 'Health', '2025-01-03', '2026-01-03', 'Approved'),
(44, 230, 115000, 'Health', '2025-01-04', '2026-01-04', 'Pending'),
(45, 240, 120000, 'Health', '2025-01-05', '2026-01-05', 'Rejected'),
(46, 250, 125000, 'Health', '2025-01-06', '2026-01-06', 'Pending'),
(47, 260, 130000, 'Health', '2025-01-07', '2026-01-07', 'Approved'),
(48, 270, 135000, 'Health', '2025-01-08', '2026-01-08', 'Rejected'),
(49, 280, 140000, 'Health', '2025-01-09', '2026-01-09', 'Pending'),
(50, 290, 145000, 'Health', '2025-01-10', '2026-01-10', 'Approved'),
-- Property Insurance (51-60)
(51, 300, 200000, 'Property', '2025-02-01', '2026-02-01', 'Approved'),
(52, 310, 210000, 'Property', '2025-02-02', '2026-02-02', 'Pending'),
(53, 320, 220000, 'Property', '2025-02-03', '2026-02-03', 'Rejected'),
(54, 330, 230000, 'Property', '2025-02-04', '2026-02-04', 'Approved'),
(55, 340, 240000, 'Property', '2025-02-05', '2026-02-05', 'Approved'),
(56, 350, 250000, 'Property', '2025-02-06', '2026-02-06', 'Approved'),
(57, 360, 260000, 'Property', '2025-02-07', '2026-02-07', 'Pending'),
(58, 370, 270000, 'Property', '2025-02-08', '2026-02-08', 'Approved'),
(59, 380, 280000, 'Property', '2025-02-09', '2026-02-09', 'Approved'),
(60, 390, 290000, 'Property', '2025-02-10', '2026-02-10', 'Rejected'),
-- Vehicle Insurance (61-70)
(61, 150, 50000, 'Vehicle', '2025-03-01', '2026-03-01', 'Pending'),
(62, 160, 52000, 'Vehicle', '2025-03-02', '2026-03-02', 'Rejected'),
(63, 170, 54000, 'Vehicle', '2025-03-03', '2026-03-03', 'Approved'),
(64, 180, 56000, 'Vehicle', '2025-03-04', '2026-03-04', 'Pending'),
(65, 190, 58000, 'Vehicle', '2025-03-05', '2026-03-05', 'Rejected'),
(66, 200, 60000, 'Vehicle', '2025-03-06', '2026-03-06', 'Approved'),
(67, 210, 62000, 'Vehicle', '2025-03-07', '2026-03-07', 'Rejected'),
(68, 220, 64000, 'Vehicle', '2025-03-08', '2026-03-08', 'Pending'),
(69, 230, 66000, 'Vehicle', '2025-03-09', '2026-03-09', 'Approved'),
(70, 240, 68000, 'Vehicle', '2025-03-10', '2026-03-10', 'Approved');

-- Insert into Health_Insurance table (10 records)
INSERT INTO Health_Insurance (health_insurance_id, health_plan_type)
VALUES 
(41, 'Plan 1'),
(42, 'Plan 2'),
(43, 'Plan 3'),
(44, 'Plan 4'),
(45, 'Plan 5'),
(46, 'Plan 6'),
(47, 'Plan 7'),
(48, 'Plan 8'),
(49, 'Plan 9'),
(50, 'Plan 10');

-- Insert into Property_Insurance table (10 records)
INSERT INTO Property_Insurance (property_insurance_id, property_type, construction_year, market_value)
VALUES 
(51, 'Type 1', 2010, 150000),
(52, 'Type 2', 2011, 155000),
(53, 'Type 3', 2012, 160000),
(54, 'Type 4', 2013, 165000),
(55, 'Type 5', 2014, 170000),
(56, 'Type 6', 2015, 175000),
(57, 'Type 7', 2016, 180000),
(58, 'Type 8', 2017, 185000),
(59, 'Type 9', 2018, 190000),
(60, 'Type 10', 2019, 195000);

-- Insert into Vehicle_Insurance table (10 records)
INSERT INTO Vehicle_Insurance (vehicle_insurance_id, vehicle_type, make, model, year, vin)
VALUES 
(61, 'Car', 'Make 1', 'Model 1', 2020, 'VIN000000000000061'),
(62, 'Car', 'Make 2', 'Model 2', 2021, 'VIN000000000000062'),
(63, 'Car', 'Make 3', 'Model 3', 2022, 'VIN000000000000063'),
(64, 'Car', 'Make 4', 'Model 4', 2023, 'VIN000000000000064'),
(65, 'Car', 'Make 5', 'Model 5', 2024, 'VIN000000000000065'),
(66, 'Car', 'Make 6', 'Model 6', 2020, 'VIN000000000000066'),
(67, 'Car', 'Make 7', 'Model 7', 2021, 'VIN000000000000067'),
(68, 'Car', 'Make 8', 'Model 8', 2022, 'VIN000000000000068'),
(69, 'Car', 'Make 9', 'Model 9', 2023, 'VIN000000000000069'),
(70, 'Car', 'Make 10', 'Model 10', 2024, 'VIN000000000000070');

-- Insert into Financial_Instrument table for Credit Card (IDs 71-80)
INSERT INTO Financial_Instrument (instrument_type, status)
VALUES 
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active'),
('Credit Card', 'Active');

-- Insert into Credit_Card table using IDs 71-80
INSERT INTO Credit_Card (credit_card_id, expiration_date, credit_limit, current_balance)
VALUES 
(71, '2026-01-01', 17100, 5550),
(72, '2026-01-01', 17200, 5600),
(73, '2026-01-01', 17300, 5650),
(74, '2026-01-01', 17400, 5700),
(75, '2026-01-01', 17500, 5750),
(76, '2026-01-01', 17600, 5800),
(77, '2026-01-01', 17700, 5850),
(78, '2026-01-01', 17800, 5900),
(79, '2026-01-01', 17900, 5950),
(80, '2026-01-01', 18000, 6000);

-- Insert into Financial_Instrument table for Account (IDs 81-90)
INSERT INTO Financial_Instrument (instrument_type, status)
VALUES 
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active'),
('Account', 'Active');

-- Insert into Account table using IDs 81-90
INSERT INTO Account (account_instrument_id, branch_id, account_number, balance, opening_date, account_type, interest_rate)
VALUES 
(81, 2, 9876543281, 13100, '2025-01-01', 'Savings', 1.5),
(82, 1, 9876543282, 13200, '2025-01-01', 'Savings', 2.0),
(83, 2, 9876543283, 13300, '2025-01-01', 'Savings', 2.5),
(84, 1, 9876543284, 13400, '2025-01-01', 'Savings', 1.5),
(85, 2, 9876543285, 13500, '2025-01-01', 'Savings', 2.0),
(86, 1, 9876543286, 13600, '2025-01-01', 'Savings', 2.5),
(87, 2, 9876543287, 13700, '2025-01-01', 'Savings', 1.5),
(88, 1, 9876543288, 13800, '2025-01-01', 'Savings', 2.0),
(89, 2, 9876543289, 13900, '2025-01-01', 'Savings', 2.5),
(90, 1, 9876543290, 14000, '2025-01-01', 'Savings', 1.5);

-- Loan transactions (instrument_id: 1-10)
INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, date_time, description, status)
VALUES 
(1, 'Loan', 'Payment', 1100, '2025-03-08 18:09:00', 'Loan payment 1', 'Completed'),
(2, 'Loan', 'Payment', 1200, '2025-03-07 18:09:00', 'Loan payment 2', 'Completed'),
(3, 'Loan', 'Payment', 1300, '2025-03-06 18:09:00', 'Loan payment 3', 'Completed'),
(4, 'Loan', 'Payment', 1400, '2025-03-05 18:09:00', 'Loan payment 4', 'Completed'),
(5, 'Loan', 'Payment', 1500, '2025-03-04 18:09:00', 'Loan payment 5', 'Completed'),
(6, 'Loan', 'Payment', 1600, '2025-03-03 18:09:00', 'Loan payment 6', 'Completed'),
(7, 'Loan', 'Payment', 1700, '2025-03-02 18:09:00', 'Loan payment 7', 'Completed'),
(8, 'Loan', 'Payment', 1800, '2025-03-01 18:09:00', 'Loan payment 8', 'Completed'),
(9, 'Loan', 'Payment', 1900, '2025-02-28 18:09:00', 'Loan payment 9', 'Completed'),
(10, 'Loan', 'Payment', 2000, '2025-02-27 18:09:00', 'Loan payment 10', 'Completed');

-- Insurance transactions (instrument_id: 41-50)
INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, date_time, description, status)
VALUES 
(41, 'Insurance', 'Payment', 210, '2025-02-26 18:09:00', 'Insurance premium 41', 'Completed'),
(42, 'Insurance', 'Payment', 220, '2025-02-25 18:20:00', 'Insurance premium 42', 'Completed'),
(43, 'Insurance', 'Payment', 230, '2025-02-24 18:09:00', 'Insurance premium 43', 'Completed'),
(44, 'Insurance', 'Payment', 240, '2025-02-23 18:09:00', 'Insurance premium 44', 'Completed'),
(45, 'Insurance', 'Payment', 250, '2025-02-22 18:09:00', 'Insurance premium 45', 'Completed'),
(46, 'Insurance', 'Payment', 260, '2025-02-21 18:40:00', 'Insurance premium 46', 'Completed'),
(47, 'Insurance', 'Payment', 270, '2025-02-20 18:09:00', 'Insurance premium 47', 'Completed'),
(48, 'Insurance', 'Payment', 280, '2025-02-19 18:59:00', 'Insurance premium 48', 'Completed'),
(49, 'Insurance', 'Payment', 290, '2025-02-18 18:21:00', 'Insurance premium 49', 'Completed'),
(50, 'Insurance', 'Payment', 300, '2025-02-17 18:14:00', 'Insurance premium 50', 'Completed');

-- Credit Card transactions (instrument_id: 71-75)
INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, date_time, description, status)
VALUES 
(71, 'Credit Card', 'Payment', 550, '2025-02-16 18:09:00', 'Credit card purchase 71', 'Completed'),
(72, 'Credit Card', 'Payment', 600, '2025-02-15 19:09:00', 'Credit card purchase 72', 'Completed'),
(73, 'Credit Card', 'Payment', 650, '2025-02-14 20:09:00', 'Credit card purchase 73', 'Completed'),
(74, 'Credit Card', 'Payment', 700, '2025-02-13 21:09:00', 'Credit card purchase 74', 'Completed'),
(75, 'Credit Card', 'Payment', 750, '2025-02-12 22:09:00', 'Credit card purchase 75', 'Completed');

-- Account transactions (instrument_id: 81-85)
INSERT INTO [Transaction] (instrument_id, instrument_type, transaction_type, amount, date_time, description, status)
VALUES 
(81, 'Account', 'Deposit', 2100, '2025-02-11 18:09:00', 'Account deposit 81', 'Completed'),
(82, 'Account', 'Deposit', 3200, '2025-02-10 18:09:00', 'Account deposit 82', 'Completed'),
(83, 'Account', 'Deposit', 4300, '2025-02-09 18:09:00', 'Account deposit 83', 'Completed'),
(84, 'Account', 'Deposit', 5400, '2025-02-08 18:09:00', 'Account deposit 84', 'Completed'),
(85, 'Account', 'Deposit', 6500, '2025-02-07 18:09:00', 'Account deposit 85', 'Completed');

-- Insert individual ownership records covering all financial instrument types
INSERT INTO Customer_Financial_Instrument (customer_id, instrument_id, role, enrollment_date)
VALUES 
-- Loan instruments 
(1, 1, 'Owner', '2025-01-15'),  -- Student loan
(2, 11, 'Owner', '2025-01-20'), -- Business loan
(3, 21, 'Owner', '2025-01-25'), -- Vehicle loan
(4, 31, 'Owner', '2025-02-01'), -- Mortgage loan

-- Insurance instruments
(5, 41, 'Owner', '2025-02-05'), -- Health insurance
(6, 51, 'Owner', '2025-02-10'), -- Property insurance
(7, 61, 'Owner', '2025-02-15'), -- Vehicle insurance

-- Credit Card instruments
(8, 71, 'Owner', '2025-02-20'),
(9, 72, 'Owner', '2025-02-21'),
(10, 73, 'Owner', '2025-02-22'),

-- Account instruments (individual ownership)
(1, 81, 'Owner', '2025-02-25'), -- Savings account
(2, 82, 'Owner', '2025-02-26'), -- Checking account
(3, 83, 'Owner', '2025-02-27'), 
(4, 84, 'Owner', '2025-02-28'),
(5, 85, 'Owner', '2025-03-01');

-- Insert joint account ownership records (multiple customers sharing accounts)
INSERT INTO Customer_Financial_Instrument (customer_id, instrument_id, role, enrollment_date)
VALUES
-- Joint Account #1 (3 owners)
(6, 86, 'Owner', '2025-03-02'),
(7, 86, 'Co-Owner', '2025-03-02'),
(8, 86, 'Co-Owner', '2025-03-02'),

-- Joint Account #2 (2 owners)
(9, 87, 'Owner', '2025-03-03'),
(10, 87, 'Co-Owner', '2025-03-03'),

-- Joint Account #3 (3 owners with different enrollment dates)
(1, 88, 'Owner', '2025-03-04'),
(2, 88, 'Co-Owner', '2025-03-05'),
(3, 88, 'Co-Owner', '2025-03-06'),

-- Joint Account #4 (family account)
(4, 89, 'Owner', '2025-03-07'),
(5, 89, 'Co-Owner', '2025-03-07'),
(6, 89, 'Co-Owner', '2025-03-07'),

-- Joint Account #5 (business partners)
(7, 90, 'Owner', '2025-03-08'),
(8, 90, 'Co-Owner', '2025-03-08'),
(9, 90, 'Co-Owner', '2025-03-08'),
(10, 90, 'Co-Owner', '2025-03-08');
