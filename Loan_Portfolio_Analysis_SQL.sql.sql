--Dashboard 1
--Key Performance Indicators (KPIs) Requirements:
SELECT *FROM BANK_LOAN_DATA;
--1. Total Loan Aplication
SELECT COUNT(id) AS TOTAL_APLICATIONS FROM bank_loan_data;

SELECT COUNT(id) AS MTD
FROM bank_loan_data
WHERE issue_date >= DATE '2021-12-01'
  AND issue_date < DATE '2022-01-01';

--2. Total Founded Amount
SELECT SUM(loan_amount) AS MTD_Total_Founded_Amount FROM bank_loan_data
WHERE issue_date >= DATE '2021-12-01'
  AND issue_date <= DATE '2021-12-31';

SELECT SUM(loan_amount) AS PMTD_Total_Founded_Amount FROM bank_loan_data
WHERE issue_date >= DATE '2021-11-01'
  AND issue_date <= DATE '2021-11-30';  
  
--3. Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_received FROM bank_loan_data
WHERE issue_date >= DATE '2021-12-01'
  AND issue_date <= DATE '2021-12-31';  

SELECT SUM(total_payment) AS PMTD_Total_Amount_received FROM bank_loan_data
WHERE issue_date >= DATE '2021-11-01'
  AND issue_date <= DATE '2021-11-30'; 

--4. Average Interest Rate
SELECT ROUND(AVG(int_rate),4) * 100 AS MTD_Avg_Interest_Rate FROM bank_loan_data
WHERE issue_date >= DATE '2021-12-01'
  AND issue_date <= DATE '2021-12-31';

SELECT ROUND(AVG(int_rate),4) * 100 AS PMTD_Avg_Interest_Rate FROM bank_loan_data
WHERE issue_date >= DATE '2021-11-01'
  AND issue_date <= DATE '2021-11-30';

--5. Average Debt-to-Income Ratio (DTI)
SELECT ROUND(AVG(dti),4)*100 AS MTD_AVG_DTI FROM bank_loan_data
WHERE issue_date >= DATE '2021-12-01'
  AND issue_date <= DATE '2021-12-31';

SELECT ROUND(AVG(dti),4)*100 AS PMTD_AVG_DTI FROM bank_loan_data
WHERE issue_date >= DATE '2021-11-01'
  AND issue_date <= DATE '2021-11-30';

------------------------------
--6. Good Loan Percentage
SELECT ROUND(
       COUNT(CASE
               WHEN TRIM(loan_status) IN ('Fully Paid', 'Current')
               THEN id
             END) * 100
       / COUNT(*)
       ,2) AS good_loan_percentage
FROM bank_loan_data;

--Good Loan Application

SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current';

--Good Loan Funded Amount

SELECT SUM(loan_amount) AS Good_Loan_Founded_Amount FROM bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current';

-- Good Loan Total Received Amount
SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan_data
WHERE loan_status='Fully Paid' OR loan_status='Current';

--Bad Loans

SELECT ROUND(
       COUNT(CASE
               WHEN TRIM(loan_status) IN ('Charged Off')
               THEN id
             END) * 100
       / COUNT(*)
       ,2) AS good_loan_percentage
FROM bank_loan_data;

--Bad Loans Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status='Charged Off';

-- Bad Total Received Amount
SELECT SUM(loan_amount) AS Bad_Loan_Founded_Amount FROM bank_loan_data
WHERE loan_status='Charged Off';

--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan__Amount_Received FROM bank_loan_data
WHERE loan_status='Charged Off';

--Loan Status

SELECT
    loan_status,
    COUNT(id) AS Total_Loan_Applications,
    SUM(total_payment) AS Total_Amount_Received,
    SUM(loan_amount) AS Total_Funded_Amount,
    ROUND(AVG(int_rate) * 100, 2) AS Interest_Rate,
    ROUND(AVG(dti) * 100, 2) AS DTI
FROM bank_loan_data
GROUP BY loan_status;

SELECT
    loan_status,
    SUM(total_payment) AS MTD_Total_Amount_Received,
    SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE issue_date >= DATE '2021-12-01'
  AND issue_date < DATE '2022-01-01'
GROUP BY loan_status;

SELECT
   
    TO_CHAR(issue_date, 'Month') AS Month_name,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY TO_CHAR(issue_date, 'Month')
ORDER BY MIN(issue_date) DESC;
--Monthly Trends by Issue Date
SELECT
    TO_CHAR(issue_date, 'MM') AS Month_number,
    TO_CHAR(issue_date, 'Month') AS month_name,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY
    TO_CHAR(issue_date, 'MM'),
    TO_CHAR(issue_date, 'Month')
ORDER BY
    TO_CHAR(issue_date, 'MM');
--Regional Analysis by State

SELECT
    address_state,
    COUNT(*) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount,
    ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate,
    ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM bank_loan_data
GROUP BY address_state
ORDER BY total_loan_applications DESC;

--Loan Term Analysis

SELECT
    term,
    COUNT(*) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount,
    ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate,
    ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM bank_loan_data
GROUP BY term
ORDER BY term;

--Employee Length Analysis
SELECT
    emp_length,
    COUNT(*) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount,
    ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate,
    ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length DESC;
--Loan Purpose Breakdown
SELECT
    purpose,
    COUNT(*) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount,
    ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate,
    ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose;
--Home Ownership Analysis
SELECT
    home_ownership,
    COUNT(*) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount,
    ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate,
    ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership DESC;

--Dashbord3
--Grid
SELECT
    home_ownership,
    COUNT(*) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount,
    ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate,
    ROUND(AVG(dti) * 100, 2) AS avg_dti
FROM bank_loan_data
WHERE grade='A' AND address_state='CA'
GROUP BY home_ownership
ORDER BY home_ownership DESC;
--Dashboard 4 - Credit Risk Analysis
--23. Charged-Off Loan Rate
SELECT
    ROUND(
        COUNT(CASE
                WHEN loan_status = 'Charged Off'
                THEN id
              END) * 100.0
        / COUNT(*)
    ,2) AS Charged_Off_Rate
FROM bank_loan_data;

-- 24. Charged-Off Funded Amount
SELECT
    SUM(loan_amount) AS Charged_Off_Funded_Amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 25. Average Interest Rate for Charged-Off Loans
SELECT
    ROUND(AVG(int_rate) * 100,2) AS Avg_Interest_Rate_Charged_Off
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 26. Average DTI for Charged-Off Loans
SELECT
    ROUND(AVG(dti) * 100,2) AS Avg_DTI_Charged_Off
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

-- 27. Credit Risk Analysis by Grade
SELECT
    grade,

    COUNT(CASE
            WHEN loan_status='Charged Off'
            THEN id
          END) AS Charged_Off_Loans,

    COUNT(*) AS Total_Loans,

    ROUND(
        COUNT(CASE
                WHEN loan_status='Charged Off'
                THEN id
              END) * 100.0
        / COUNT(*)
    ,2) AS Charged_Off_Rate

FROM bank_loan_data
GROUP BY grade
ORDER BY grade;

-- 28. Credit Risk Analysis by Loan Purpose
SELECT
    purpose,

    COUNT(CASE
            WHEN loan_status='Charged Off'
            THEN id
          END) AS Charged_Off_Loans,

    COUNT(*) AS Total_Loans,

    ROUND(
        COUNT(CASE
                WHEN loan_status='Charged Off'
                THEN id
              END) * 100.0
        / COUNT(*)
    ,2) AS Charged_Off_Rate

FROM bank_loan_data
GROUP BY purpose
ORDER BY Charged_Off_Rate DESC;
-- 29. Credit Risk Analysis by Home Ownership
SELECT
    home_ownership,

    COUNT(CASE
            WHEN loan_status='Charged Off'
            THEN id
          END) AS Charged_Off_Loans,

    COUNT(*) AS Total_Loans,

    ROUND(
        COUNT(CASE
                WHEN loan_status='Charged Off'
                THEN id
              END) * 100.0
        / COUNT(*)
    ,2) AS Charged_Off_Rate

FROM bank_loan_data
GROUP BY home_ownership
ORDER BY Charged_Off_Rate DESC;

-- 30. Top Risk States Analysis
SELECT
    address_state,

    COUNT(CASE
            WHEN loan_status='Charged Off'
            THEN id
          END) AS Charged_Off_Loans,

    SUM(CASE
            WHEN loan_status='Charged Off'
            THEN loan_amount
            ELSE 0
        END) AS Charged_Off_Funded_Amount,

    ROUND(
        COUNT(CASE
                WHEN loan_status='Charged Off'
                THEN id
              END) * 100.0
        / COUNT(*)
    ,2) AS Charged_Off_Rate

FROM bank_loan_data
GROUP BY address_state
ORDER BY Charged_Off_Rate DESC;

-- 31. Grade vs Purpose Risk Matrix (Heatmap)
SELECT
    grade,
    purpose,

    COUNT(*) AS Total_Loans,

    COUNT(CASE
            WHEN loan_status='Charged Off'
            THEN id
          END) AS Charged_Off_Loans,

    ROUND(
        COUNT(CASE
                WHEN loan_status='Charged Off'
                THEN id
              END) * 100.0
        / COUNT(*)
    ,2) AS Charged_Off_Rate

FROM bank_loan_data
GROUP BY
    grade,
    purpose
ORDER BY
    grade,
    purpose;
32. Top 10 Highest Risk Grade-Purpose Combinations
SELECT
    grade,
    purpose,

    ROUND(
        COUNT(CASE
                WHEN loan_status='Charged Off'
                THEN id
              END) * 100
        / COUNT(*)
    ,2) AS Charged_Off_Rate

FROM bank_loan_data
GROUP BY grade,purpose
HAVING COUNT(*) >= 20
ORDER BY Charged_Off_Rate DESC
FETCH FIRST 10 ROWS ONLY;
