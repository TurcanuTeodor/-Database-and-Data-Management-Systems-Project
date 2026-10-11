-- 02_data_insertion.sql
-- Load realistic seed data.

INSERT INTO t_student (student_id, first_name, last_name, email, phone_number, birth_date, education_level)
VALUES (1001, 'Theodor', 'Ionescu', 'theodor.ionescu@email.com', 0723456789, TO_DATE('15-05-2003', 'DD-MM-YYYY'), 'Undergraduate');
INSERT INTO t_student (student_id, first_name, last_name, email, phone_number, birth_date, education_level)
VALUES (1002, 'Maria', 'Popescu', 'maria.popescu@email.com', 0723123456, TO_DATE('20-09-2000', 'DD-MM-YYYY'), 'Postgraduate');
INSERT INTO t_student (student_id, first_name, last_name, email, phone_number, birth_date, education_level)
VALUES (1003, 'Andrei', 'Vasilescu', 'andrei.vasilescu@email.com', 0724567890, TO_DATE('10-03-2001', 'DD-MM-YYYY'), 'Undergraduate');
INSERT INTO t_student (student_id, first_name, last_name, email, phone_number, birth_date, education_level)
VALUES (1004, 'Ioana', 'Mihai', 'ioana.mihai@email.com', 0723987654, TO_DATE('30-07-2004', 'DD-MM-YYYY'), 'Undergraduate');
INSERT INTO t_student (student_id, first_name, last_name, email, phone_number, birth_date, education_level)
VALUES (1005, 'Vasile', 'Georgescu', 'vasile.georgescu@email.com', 0723543210, TO_DATE('14-02-2001', 'DD-MM-YYYY'), 'Postgraduate');
INSERT INTO t_student (student_id, first_name, last_name, email, phone_number, birth_date, education_level)
VALUES (1006, 'Elena', 'Dumitru', 'elena.dumitru@email.com', 0724321987, TO_DATE('11-11-2005', 'DD-MM-YYYY'), 'Undergraduate');

INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2001, 'Scholarship', 1500.50, DATE '2025-01-05', 1, 1001);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2002, 'Part-time Job', 1200.00, DATE '2025-01-10', 1, 1002);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2003, 'Freelancing', 1800.75, DATE '2025-01-12', 1, 1003);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2004, 'Allowance', 800.00, DATE '2025-02-20', 1, 1001);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2005, 'Scholarship', 2200.00, DATE '2025-01-01', 1, 1004);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2006, 'Full-time Job', 2500.00, DATE '2025-01-05', 1, 1005);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2007, 'Part-time Job', 1350.25, DATE '2025-02-07', 1, 1006);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2008, 'Allowance', 800.00, DATE '2025-02-10', 1, 1004);
INSERT INTO t_income (income_id, source, amount, income_date, frequency, student_id)
VALUES (2009, 'Full-time Job', 2500.00, DATE '2025-02-12', 1, 1005);

INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (0001, 'Expenses', NULL);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (0002, 'Savings and Investments', NULL);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3001, 'Groceries', 0001);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3002, 'Rent', 0001);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3003, 'Entertainment', 0001);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3004, 'Transportation', 0001);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3005, 'Utilities', 0001);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3006, 'Education', 0001);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3007, 'Healthcare', 0001);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3008, 'Savings', 0002);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3009, 'Insurance', 0002);
INSERT INTO t_categories (category_id, category_name, parent_category_id)
VALUES (3010, 'Subscriptions', 0001);

INSERT INTO t_bank_accounts (account_id, account_number, bank_name, balance, student_id, status)
VALUES (4001, 'RO49AAAA1B31007593840000', 'Raiffeisen Bank', 7200.00, 1001, 'Active');
INSERT INTO t_bank_accounts (account_id, account_number, bank_name, balance, student_id, status)
VALUES (4002, 'RO49AAAA1B31007593843009', 'Alpha Bank', 5400.50, 1002, 'Active');
INSERT INTO t_bank_accounts (account_id, account_number, bank_name, balance, student_id, status)
VALUES (4003, 'RO49AAAA1B31007593840002', 'OTP Bank', 8700.00, 1003, 'Active');
INSERT INTO t_bank_accounts (account_id, account_number, bank_name, balance, student_id, status)
VALUES (4004, 'RO57AAAA1140DE234443SV10', 'BRD Bank', 6600.00, 1004, 'Active');
INSERT INTO t_bank_accounts (account_id, account_number, bank_name, balance, student_id, status)
VALUES (4005, 'RO49AAAA1B31007593841121', 'BCR Bank', 12300.50, 1005, 'Active');
INSERT INTO t_bank_accounts (account_id, account_number, bank_name, balance, student_id, status)
VALUES (4006, 'RO49AAAA1B31007593867605', 'ING Bank', 3200.25, 1006, 'Active');

INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5001, TO_DATE('05-02-2025', 'DD-MM-YYYY'), 150.00, 'Debit', 'Book purchase', 3006, 4001, 1001);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5002, TO_DATE('07-02-2025', 'DD-MM-YYYY'), 50.00, 'Debit', 'Doctor visit', 3007, 4001, 1001);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5003, TO_DATE('09-02-2025', 'DD-MM-YYYY'), 500.00, 'Debit', 'Health insurance', 3007, 4002, 1002);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5004, TO_DATE('11-02-2025', 'DD-MM-YYYY'), 300.00, 'Debit', 'Music streaming subscription', 3010, 4002, 1002);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5005, TO_DATE('13-02-2025', 'DD-MM-YYYY'), 200.00, 'Credit', 'Freelancing payment', 3006, 4003, 1003);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5006, TO_DATE('15-02-2025', 'DD-MM-YYYY'), 450.00, 'Debit', 'Car insurance', 3009, 4003, 1003);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5007, TO_DATE('17-02-2025', 'DD-MM-YYYY'), 100.00, 'Debit', 'Medical supplies', 3007, 4006, 1006);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5008, TO_DATE('19-02-2025', 'DD-MM-YYYY'), 700.00, 'Credit', 'Allowance from parents', 3008, 4004, 1004);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5009, TO_DATE('21-02-2025', 'DD-MM-YYYY'), 250.00, 'Debit', 'Internet subscription', 3010, 4005, 1005);
INSERT INTO t_transactions (transaction_id, transaction_date, amount, transaction_type, transaction_details, category_id, account_id, student_id)
VALUES (5010, TO_DATE('23-02-2025', 'DD-MM-YYYY'), 300.00, 'Debit', 'Dental checkup', 3007, 4006, 1006);

INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6006, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 500.00, 1001, 3003);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6007, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 1500.00, 1002, 3007);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6008, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 1200.00, 1003, 3005);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6009, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 800.00, 1004, 3003);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6010, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 1000.00, 1005, 3008);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6011, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 1500.00, 1006, 3001);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6012, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 1400.00, 1006, 3001);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6013, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 200.00, 1005, 3008);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6014, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 600.00, 1004, 3001);
INSERT INTO t_monthly_budget (budget_id, start_date, end_date, amount, student_id, category_id)
VALUES (6015, TO_DATE('01-02-2025', 'DD-MM-YYYY'), TO_DATE('28-02-2025', 'DD-MM-YYYY'), 150.00, 1003, 3010);

PROMPT Seed data inserted successfully.
