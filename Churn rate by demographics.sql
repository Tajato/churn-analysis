--Churn rate by demographics
--What's the churn rate by gender?

SELECT gender, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, -- Case statement allows me to count only rows where the customer has chruned.
                                                                                                                       --So if churn = 'yes', then 1, which simply means if churn = yes, count this row and ignore the others.
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate --divide churn customers by total customer in order to get churn rate by gender ( I grouped the results by gender)
FROM customers
GROUP BY gender; 

-- What's the churn rate by senior citizenship status
SELECT seniorcitizen, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
FROM customers
GROUP BY seniorcitizen;


-- Churn rate by partner
SELECT partner, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
FROM customers
GROUP BY partner;

-- Churn rate by dependents
SELECT dependents, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
FROM customers
GROUP BY dependents;

--churn rate by tenure
SELECT tenure, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
FROM customers
GROUP BY tenure
ORDER BY 3 desc;
