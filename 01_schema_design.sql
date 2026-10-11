-- 01_schema_design.sql
-- Create the database schema.

DROP TABLE t_monthly_budget CASCADE CONSTRAINTS;
DROP TABLE t_transactions CASCADE CONSTRAINTS;
DROP TABLE t_bank_accounts CASCADE CONSTRAINTS;
DROP TABLE t_income CASCADE CONSTRAINTS;
DROP TABLE t_categories CASCADE CONSTRAINTS;
DROP TABLE t_student CASCADE CONSTRAINTS;

CREATE TABLE t_student (
    student_id NUMBER(4) CONSTRAINT stud_id PRIMARY KEY,
    first_name VARCHAR2(30),
    last_name VARCHAR2(30),
    email VARCHAR2(50),
    phone_number VARCHAR2(20),
    birth_date DATE,
    education_level VARCHAR2(20)
);

CREATE TABLE t_income (
    income_id NUMBER(4) CONSTRAINT inc_id PRIMARY KEY,
    source VARCHAR2(50),
    amount NUMBER(10,2),
    income_date DATE,
    frequency NUMBER(10),
    student_id NUMBER(4) CONSTRAINT inc_stud_fk REFERENCES t_student(student_id)
);

CREATE TABLE t_categories (
    category_id NUMBER(4) CONSTRAINT categ_pk PRIMARY KEY,
    category_name VARCHAR2(50),
    parent_category_id NUMBER(4) REFERENCES t_categories(category_id)
);

CREATE TABLE t_bank_accounts (
    account_id NUMBER(4) CONSTRAINT accnt_pk PRIMARY KEY,
    account_number VARCHAR2(22) UNIQUE,
    bank_name VARCHAR2(50),
    balance NUMBER(10,2),
    student_id NUMBER(4) CONSTRAINT accnt_stud_fk REFERENCES t_student(student_id),
    status VARCHAR2(15) DEFAULT 'Active'
);

CREATE TABLE t_transactions (
    transaction_id NUMBER(4) CONSTRAINT trans_pk PRIMARY KEY,
    transaction_date DATE,
    amount NUMBER(10,2),
    transaction_type VARCHAR2(20),
    transaction_details VARCHAR2(100),
    category_id NUMBER(4) CONSTRAINT trans_categ_fk REFERENCES t_categories(category_id),
    account_id NUMBER(4) CONSTRAINT trans_accnt_fk REFERENCES t_bank_accounts(account_id),
    student_id NUMBER(4) CONSTRAINT trans_stud_fk REFERENCES t_student(student_id)
);

CREATE TABLE t_monthly_budget (
    budget_id NUMBER(4) CONSTRAINT budg_pk PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    amount NUMBER(10,2),
    student_id NUMBER(4) CONSTRAINT mb_stud_fk REFERENCES t_student(student_id),
    category_id NUMBER(4) CONSTRAINT mb_categ_fk REFERENCES t_categories(category_id)
);

PROMPT Schema creation complete.
