-- What is the average tenure of customers who churned?

SELECT AVG(tenure) as avg_tenure_churn 
from customers
WHERE churn = 'Yes';
