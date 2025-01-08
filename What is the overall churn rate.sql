-- What is the overall churn rate for the company?
WITH 
    num_churn AS (
        SELECT COUNT(*) as cnt FROM customers WHERE churn = 'Yes' --Calculate the number of customers who churn. COUNT(*) counts all the rows in the table where churn = 'yes
    ), 
    total_cus AS (
        SELECT COUNT(*) as cnt FROM customers -- calculate the total number of customers. COUNT(*) counts all the rows in the table.
    )
SELECT (CAST(num_churn.cnt AS FLOAT) / CAST(total_cus.cnt AS FLOAT) * 100) as churn_rate -- churn rate = num_churn / total_cus.
FROM num_churn, total_cus;

-- Before this polished query, the churn rate was 0. 
--But this didn't make sense when we had 1869 people who churned in the dataset.
--So, I had to add CAST AS FLOAT because it seems decimal values were being truncated
--Anyway, churn rate is 26.5%. 26% of customers are leaving and this could plummet the revenue.
--I suggest conducting a survey to see where the product/service can be improved.
--But prevention is better than cure, so let's find out who is at risk of churning
--Then we could reach out to those customers and try to get them to stay
--We can offer them a loyalty program, target them with marketing campaigns or
--general incentives.
--Later on, we will use a predictive model identify at risk customers

