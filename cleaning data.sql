-- Change columns to lowercase

ALTER TABLE customers
RENAME COLUMN SeniorCitizen TO seniorcitizen;

ALTER TABLE customers
RENAME COLUMN Partner to partner;

ALTER TABLE customers
RENAME COLUMN PhoneService TO phoneservice;

ALTER TABLE customers
RENAME COLUMN MultipleLines to multiplelines;

ALTER TABLE customers
RENAME COLUMN OnlineSecurity TO onlinesecurity;
ALTER TABLE customers
RENAME COLUMN OnlineBackup TO onlinebackup;
ALTER TABLE customers
RENAME COLUMN DeviceProtection TO deviceprotection;
ALTER TABLE customers
RENAME COLUMN TechSupport TO techsupport;
ALTER TABLE customers
RENAME COLUMN StreamingTV TO streamingtv;
ALTER TABLE customers
RENAME COLUMN StreamingMovies TO streamingmovies;
ALTER TABLE customers
RENAME COLUMN Contract to contract;
ALTER TABLE customers
RENAME COLUMN PaperlessBilling to paperlessbilling;
ALTER TABLE customers
RENAME COLUMN PaymentMethod to paymentmethod;
ALTER TABLE customers
RENAME COLUMN MonthlyCharges TO monthlycharges;
ALTER TABLE customers
RENAME COLUMN TotalCharges TO totalcharges;
ALTER TABLE customers
RENAME COLUMN Churn TO churn;
ALTER TABLE customers
RENAME COLUMN InternetService TO internetservice;
ALTER TABLE customers
RENAME COLUMN Dependents TO dependents;

--Change partner, dependents,phoneservice,paperlessbilling to 1's and 0's
-- SELECT partner,




-- check for missing values
SELECT COUNT(*) FROM customers WHERE CustomerID IS NULL OR totalcharges IS NULL;
--There are 11 missing values in the dataset.
--The best approach is to delete these missing values.

--Delete these missing values
DELETE FROM customers 
WHERE customerID IS NULL OR totalcharges IS NULL;

--Let's check for duplicate data
SELECT customerID, COUNT(*) AS count
FROM customers
GROUP BY customerID
HAVING COUNT(*) > 1;
--They are no duplicates in the dataset.

--Dataset is clean. So let us answer the first question.
