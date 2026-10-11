# Student Finance Database Project

This project models a simple student finance system. It stores student records, income entries, spending categories, bank accounts, transaction history, and monthly budget limits.

## Project goal

The database is designed to help track:

- student profiles
- income sources
- bank accounts
- transaction records
- categories of spending
- monthly budgets
- basic financial validation and reporting

## Technical focus

The project uses:

- relational schema design
- foreign keys and constraints
- SQL queries for reporting
- views and indexes
- PL/SQL procedures, functions, and triggers

## File structure

- 00_master_run.sql — runs the project scripts in order
- 01_schema_design.sql — creates the schema
- 02_data_insertion.sql — inserts sample data
- 03_reporting_and_business_rules.sql — reporting and validation rules
- 04_plsql_procedures_triggers.sql — PL/SQL logic and automation
- PROJECT_SUMMARY.md — short project summary
- ERD.svg — entity relationship diagram

## Execution order

Run the scripts in this order inside Oracle SQL Developer:

1. 01_schema_design.sql
2. 02_data_insertion.sql
3. 03_reporting_and_business_rules.sql
4. 04_plsql_procedures_triggers.sql

You can also run the master script:

- 00_master_run.sql
