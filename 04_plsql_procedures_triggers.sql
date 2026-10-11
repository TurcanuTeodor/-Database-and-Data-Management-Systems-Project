-- 04_plsql_procedures_triggers.sql
-- Advanced PL/SQL logic for finance operations.

SET SERVEROUTPUT ON;

CREATE SEQUENCE income_id_seq START WITH 2010 INCREMENT BY 1;
CREATE SEQUENCE transaction_id_seq START WITH 5011 INCREMENT BY 1;
CREATE SEQUENCE budget_id_seq START WITH 6016 INCREMENT BY 1;

CREATE OR REPLACE FUNCTION f_available_budget(
    p_student_id NUMBER,
    p_category_id NUMBER,
    p_date DATE
) RETURN NUMBER IS
    v_budget NUMBER;
    v_spendings NUMBER;
BEGIN
    SELECT NVL(SUM(amount), 0) INTO v_budget
    FROM t_monthly_budget
    WHERE student_id = p_student_id
      AND category_id = p_category_id
      AND TO_CHAR(start_date, 'MMYYYY') = TO_CHAR(p_date, 'MMYYYY');

    SELECT NVL(SUM(amount), 0) INTO v_spendings
    FROM t_transactions t
    JOIN t_bank_accounts b ON t.account_id = b.account_id
    WHERE b.student_id = p_student_id
      AND t.category_id = p_category_id
      AND UPPER(t.transaction_type) = 'DEBIT'
      AND TO_CHAR(t.transaction_date, 'MMYYYY') = TO_CHAR(p_date, 'MMYYYY');

    RETURN NVL(v_budget, 0) - NVL(v_spendings, 0);
END;
/

CREATE OR REPLACE FUNCTION f_monthly_income(p_student_id NUMBER)
RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(amount), 0) INTO v_total
    FROM t_income
    WHERE student_id = p_student_id
      AND EXTRACT(MONTH FROM income_date) = EXTRACT(MONTH FROM SYSDATE)
      AND EXTRACT(YEAR FROM income_date) = EXTRACT(YEAR FROM SYSDATE);

    RETURN v_total;
END;
/

CREATE OR REPLACE PROCEDURE proced_add_transactions(
    p_account_id NUMBER,
    p_student_id NUMBER,
    p_type VARCHAR2,
    p_amount NUMBER,
    p_details VARCHAR2,
    p_category_id NUMBER
) IS
BEGIN
    INSERT INTO t_transactions (
        transaction_id,
        transaction_date,
        amount,
        transaction_type,
        transaction_details,
        category_id,
        account_id,
        student_id
    )
    VALUES (
        transaction_id_seq.NEXTVAL,
        SYSDATE,
        p_amount,
        p_type,
        p_details,
        p_category_id,
        p_account_id,
        p_student_id
    );
END;
/

CREATE OR REPLACE PROCEDURE p_check_limit(
    p_student_id NUMBER,
    p_category_id NUMBER,
    p_date DATE
) IS
    v_available NUMBER;
BEGIN
    v_available := f_available_budget(p_student_id, p_category_id, p_date);

    IF v_available < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Budget overrun!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No budget overrun.');
    END IF;
END;
/

CREATE OR REPLACE PACKAGE pkg_student_finance AS
    PROCEDURE proced_add_income(p_student_id NUMBER, p_source VARCHAR2, p_amount NUMBER);
    PROCEDURE proced_add_expense(p_account_id NUMBER, p_amount NUMBER, p_details VARCHAR2, p_category_id NUMBER);
    FUNCTION f_get_savings(p_student_id NUMBER, p_date DATE) RETURN NUMBER;
    PROCEDURE proced_list_recent_transactions(p_student_id NUMBER, p_limit NUMBER := 5);
END pkg_student_finance;
/

CREATE OR REPLACE PACKAGE BODY pkg_student_finance AS

    PROCEDURE proced_add_income(p_student_id NUMBER, p_source VARCHAR2, p_amount NUMBER) IS
    BEGIN
        INSERT INTO t_income (income_id, source, amount, income_date, student_id)
        VALUES (income_id_seq.NEXTVAL, p_source, p_amount, SYSDATE, p_student_id);
    END;

    PROCEDURE proced_add_expense(p_account_id NUMBER, p_amount NUMBER, p_details VARCHAR2, p_category_id NUMBER) IS
        v_student_id NUMBER;
    BEGIN
        SELECT student_id INTO v_student_id
        FROM t_bank_accounts
        WHERE account_id = p_account_id;

        INSERT INTO t_transactions (
            transaction_id,
            transaction_date,
            amount,
            transaction_type,
            transaction_details,
            category_id,
            account_id,
            student_id
        )
        VALUES (
            transaction_id_seq.NEXTVAL,
            SYSDATE,
            p_amount,
            'Debit',
            p_details,
            p_category_id,
            p_account_id,
            v_student_id
        );
    END;

    FUNCTION f_get_savings(p_student_id NUMBER, p_date DATE) RETURN NUMBER IS
        v_income NUMBER;
        v_expenses NUMBER;
    BEGIN
        SELECT NVL(SUM(amount), 0) INTO v_income
        FROM t_income
        WHERE student_id = p_student_id
          AND EXTRACT(MONTH FROM income_date) = EXTRACT(MONTH FROM p_date)
          AND EXTRACT(YEAR FROM income_date) = EXTRACT(YEAR FROM p_date);

        SELECT NVL(SUM(amount), 0) INTO v_expenses
        FROM t_transactions t
        JOIN t_bank_accounts b ON t.account_id = b.account_id
        WHERE b.student_id = p_student_id
          AND UPPER(t.transaction_type) = 'DEBIT'
          AND EXTRACT(MONTH FROM t.transaction_date) = EXTRACT(MONTH FROM p_date)
          AND EXTRACT(YEAR FROM t.transaction_date) = EXTRACT(YEAR FROM p_date);

        RETURN v_income - v_expenses;
    END;

    PROCEDURE proced_list_recent_transactions(p_student_id NUMBER, p_limit NUMBER) IS
    BEGIN
        FOR r IN (
            SELECT *
            FROM t_transactions
            WHERE account_id IN (
                SELECT account_id FROM t_bank_accounts WHERE student_id = p_student_id
            )
            ORDER BY transaction_date DESC
            FETCH FIRST p_limit ROWS ONLY
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Date: ' || r.transaction_date || ', Amount: ' || r.amount || ', Type: ' || r.transaction_type);
        END LOOP;
    END;

END pkg_student_finance;
/

CREATE OR REPLACE TRIGGER trg_before_insert_trans
BEFORE INSERT ON t_transactions
BEGIN
    DBMS_OUTPUT.PUT_LINE('A transaction insert is about to occur by user: ' || USER);
END;
/

CREATE OR REPLACE TRIGGER trg_after_delete_income
AFTER DELETE ON t_income
BEGIN
    DBMS_OUTPUT.PUT_LINE('Income records have been deleted by user: ' || USER);
END;
/

CREATE OR REPLACE TRIGGER trg_check_amount
BEFORE INSERT OR UPDATE ON t_transactions
FOR EACH ROW
BEGIN
    IF :NEW.amount < 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Amount cannot be negative.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_update_balance
AFTER INSERT ON t_transactions
FOR EACH ROW
BEGIN
    IF :NEW.transaction_type = 'Debit' THEN
        UPDATE t_bank_accounts
        SET balance = balance - :NEW.amount
        WHERE account_id = :NEW.account_id;
    ELSIF :NEW.transaction_type = 'Credit' THEN
        UPDATE t_bank_accounts
        SET balance = balance + :NEW.amount
        WHERE account_id = :NEW.account_id;
    END IF;
END;
/

PROMPT PL/SQL procedures and triggers complete.
