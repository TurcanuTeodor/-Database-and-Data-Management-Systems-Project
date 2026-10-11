-- 03_reporting_and_business_rules.sql
-- Reporting layer and constraint setup.

ALTER TABLE t_student ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE t_transactions MODIFY transaction_details VARCHAR2(100) NOT NULL;
ALTER TABLE t_income ADD CONSTRAINT check_income_amount CHECK (amount > 0);
ALTER TABLE t_bank_accounts MODIFY status DEFAULT 'Active';

UPDATE t_bank_accounts SET status = 'Active' WHERE status IS NULL;

CREATE OR REPLACE VIEW v_student_income_expenses AS
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    NVL(exp.total_expenses, 0) AS total_expenses,
    NVL(inc.total_income, 0) AS total_income
FROM t_student s
LEFT JOIN (
    SELECT student_id, SUM(amount) AS total_expenses
    FROM t_transactions
    WHERE UPPER(transaction_type) = 'DEBIT'
    GROUP BY student_id
) exp ON exp.student_id = s.student_id
LEFT JOIN (
    SELECT student_id, SUM(amount) AS total_income
    FROM t_income
    GROUP BY student_id
) inc ON inc.student_id = s.student_id;

CREATE OR REPLACE VIEW v_active_accounts AS
SELECT b.account_id,
       b.account_number,
       b.bank_name,
       b.balance,
       b.student_id
FROM t_bank_accounts b
WHERE b.account_id IN (
    SELECT DISTINCT t.account_id
    FROM t_transactions t
    WHERE t.transaction_date >= ADD_MONTHS(SYSDATE, -6)
);

CREATE INDEX idx_student_ed_level ON t_student (education_level);
CREATE INDEX idx_transaction_date ON t_transactions (transaction_date);
CREATE INDEX idx_budget_student_category ON t_monthly_budget (student_id, category_id);

SELECT category_id,
       category_name,
       parent_category_id,
       LEVEL AS category_level,
       SYS_CONNECT_BY_PATH(category_name, ' -> ') AS category_path
FROM t_categories
START WITH parent_category_id IS NULL
CONNECT BY PRIOR category_id = parent_category_id;

SELECT s.student_id,
       s.first_name,
       s.last_name,
       NVL(SUM(i.amount), 0) AS total_income,
       NVL(SUM(t.amount), 0) AS total_spent
FROM t_student s
LEFT JOIN t_income i ON s.student_id = i.student_id
LEFT JOIN t_transactions t ON s.student_id = t.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY s.student_id;

SELECT c.category_name,
       NVL(SUM(t.amount), 0) AS total_spent
FROM t_categories c
LEFT JOIN t_transactions t ON c.category_id = t.category_id
GROUP BY c.category_name
ORDER BY total_spent DESC;

PROMPT Reporting and business rules complete.
