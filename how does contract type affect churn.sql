--How does contract type affect churn?
SELECT contract, AVG(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) * 100 as churn_rate
FROM customers
GROUP BY contract;
