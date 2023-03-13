--Average Revenue Per User  who churn
SELECT AVG(totalcharges) AS avg_revenue_per_user_churn
FROM customers
WHERE churn = 'Yes';