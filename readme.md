# Analyzing & Predicting Customer Churn 

For this project, I am a data analyst at a tech company. My task is to analyze customer churn at the company and see if I could predict customers who have a high potential of churn.
Churn refers to the rate at which customers stop doing business with a company, and it is an important metric for a business to track. This is because it costs more to acquire new customers than just retain the ones you already have. That is my task today to analyze these customers and identify who will churn so we do not have to take the more expensive route of acquiring new customers. The goal is to retain customers by all means. Reducing churn increases revenue because customers keep paying for the service. It is important to have the lowest churn rate as possible.

I will perform exploratory analysis of this dataset and apply regression analysis, hypothesis testing to answer the proposed questions to present insights and make necessary recommendations.

Dataset: I got this dataset from Kaggle. You can look at it here: https://www.kaggle.com/datasets/blastchar/telco-customer-churn.

## Tools Used:
- SQL
- Python, Jupyter Notebooks
- Tableau
---
## Exploratory Data Analysis Questions:
- What is the average revenue per user?
- What is the average revenue per user that churns out?
- What is the average customer lifespan?
- What is the average tenure of churned customers?
- What is the overall churn rate?
- How does churn rate vary by customer demographics(partner,gender etc)?
- How does contract type affect churn rate?
- How does monthly charges affect churn rate?
- What services are mostly associated with churn rate?
- Predictive Model using Logistic Regression Model to identify customers who are at risk of churning.
---
## Findings, Insights & Recommendations
I will now repeat the questions so you can follow along, the code I wrote to answer the question, the answer and my recommendation for specific questions.
- What is the average revenue per user?
    ``` SQL
        SELECT AVG(totalcharges) AS avg_revenue_per_user
        FROM customers
        WHERE churn = 'No';
    ```
    The average revenue per user is $2555.
---
- What is the average revenue per user that churns out?
    ``` SQL
        SELECT AVG(totalcharges) AS avg_revenue_per_user_churn
        FROM customers
        WHERE churn = 'Yes';
    ```
    The average revenue per user that churns out is $1531.
---
- What is the average customer lifespan?
  ```SQL
    SELECT AVG(tenure) AS avg_cust_life FROM customers;
     ```
    The average customer lifespan is 32 months.
---
- What is the average tenure of churned customers?
```SQL
    SELECT AVG(tenure) as avg_tenure_churn 
    FROM customers
    WHERE churn = 'Yes';
```
    The average tenure of churned customers is 17 months. 
---
- What is the overall churn rate?
  ``` SQL
     WITH 
    num_churn AS (
        SELECT COUNT(*) as cnt FROM customers WHERE churn = 'Yes'
    ), 
    total_cus AS (
        SELECT COUNT(*) as cnt FROM customers
    )
   SELECT (CAST(num_churn.cnt AS FLOAT) / CAST(total_cus.cnt AS FLOAT) * 100) as churn_rate
   FROM num_churn, total_cus; 
   ```
  The churn rate is 26.5%.
---
- How does churn rate vary by customer demographics?
    - Let's look at churn rate by gender.
    ``` SQL
        SELECT gender, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
       FROM customers
       GROUP BY gender;
    ```
    This query returns a table showing churn rate for males as 26.2%, while for females the churn rate is 26.9%. There isn't really any difference in their churn rate and this is why later on, gender was not a selected feature for the predictive model.

    - Let's look at churn rate by senior citizens.
    ```SQL
       SELECT seniorcitizen, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
       FROM customers
       GROUP BY seniorcitizen;
    ```
    This query returns a table showing 41.6% churn rate for customers who are senior citizens and 23.6% churn rate for customers who are not senior citizens. This suggests that senior citizens are more likely to churn. This could be for a variety of reasons such as senior citizens struggling with understanding the technology. I would revise product/services to ensure they are catering to senior citizens too.
  
  - Let's look at churn rate by partners.
  ```SQL
     SELECT partner, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
     FROM customers
     GROUP BY partner;
  ```
  This query returns a churn rate for customers with partners as 19.7% and those without partners as 32.9%. Based on these numbers, it seems having partners increases customer loyalty.

  - Let's look at churn rate by dependents
```SQL
     SELECT dependents, COUNT(*) AS total_customers, COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) AS churned_customers, 
       COUNT(CASE WHEN churn = 'Yes' THEN 1 ELSE NULL END) / CAST(COUNT(*) AS FLOAT) * 100 AS churn_rate
    FROM customers
    GROUP BY dependents;
```
##### The churn rate for customers with dependents is 15.5% and those without dependents is 31.2%. Based on these numbers, it seems like customers with dependents are more likely to stay at the company. And those without dependents would leave. I recommend marketing campaigns that are targeted at those customers without dependents.
---

- How does contract type affect churn rate?
```SQL
    SELECT contract, 
    AVG(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)  * 100 as       churn_rate
    FROM customers
    GROUP BY contract;
```
#### They are 3 contract types in the dataset. Month-to-month, one year and two year. Customers with a month-to-month contract has a churn rate of 42.7%, customers with a one year contract have a churn rate of 11.2%, customers with a two year contract have a churn rate of 2.8%. Based on these numbers, customers with a longer contract are less likely to churn. Customers with a month-to-month contract are more likely to churn. I recommend to create marketing campaigns that targetted at customers who have a month-to-month contract and encourage them to sign longer contracts. Provide incentives to encourage them to sign longer contracts. Additionally, for future references, for new customers, I would encourage them to sign longer contract before signing on.
---
- How does monthly charges affect churn rate?
```SQL
    SELECT churn, AVG(monthlycharges) as monthly_charges
    from customers
    GROUP BY churn;
```
* The average monthly charge for those who churn is $74. And the average charge for those who do not churn is $61.
This seems that customers are more likely to churn if they are paying more in monthly charges. To validate the truthfulness of this statement, we will conduct hypothesis testing to test the statistical signifance between churn and monthly charges. We want to make sure that this is not just due to chance and this statistical test will tell us if it is due to chance or if it is not.
We will use pearson's correlation statistical test to test this hypothesis using Python. 

  I will provide a brief summary of the test here. You can check the "Corr, Hypoth, Prediction" file to see more details about my hypothesis test. The null hypothesis for this test is: There is no statistical significance between churn and monthly charges. The p value for this test is 6.760843118056653e-60. This is way less than the significance level which is 0.05. Therefore, we can reject the null hypothesis. We can conclude that there is a statistical significance between churn and monthly charges and it's not just due to chance.

  Based on these results, I recommend revising pricing strategies to ensure the pricing is reasonable for customers. Because customers may be leaving because of high monthly charges. I suggest lowering prices or offering discounts to retain these customers. It wouldn't hurt to improve customer service either to ensure that customer's needs are being met and the pricing matches up with the service being provided.
---
- What services are mostly associated with churn?

  To answer this question, I found the correlation coefficients for all the services in relation to churn. 
   You can check my jupyter notebook file to see more details of my Python code. However, based on the coefficients, internetservice has the highest positive coefficient of 0.3 and tenure has the highest negative coefficient of -0.3. Coefficients closer to 1 or -1 suggests a strong correlation.

   My Python code sorted these values so if you view the Python code in the "Corr,Hypoth,Prediction" Jupyter Notebook, it will be more obvious to you to see which services are mostly associated with churn.

The last thing I did in this project was to use a Logistic Regression Model to predict customer churn. I suggest looking at the Jupyter Notebook file to get more details about the model. 

I mostly showed my SQL code because this project was mostly a SQL project. But I still demonstrated my knowledge of hypothesis testing and regression analysis using Python. 

---
## Final Words & Recommendations
In conclusion, the churn rate is 26.5%. Based on my analysis, senior citizens are most likely to churn. Customers with a month-to-month contract are most likely to churn. Customers with high monthly charges are most likely to churn. 
Based on these insights, as mentioned before, I suggest the company to:
 - Revise pricing strategies and ensure that value is being provided to customers. The company could consider lowering prices or offering discounts to retain customers who may be leaving because of high monthly charges.
 - Target promotions and marketing campaigns towards senior citizens and offer them incentives to encourage them to stay. I would recommend to tailor services to senior citizens needs. It would be helpful to let senior citizens fill a survey out though to figure out why exactly are they leaving.
 - Encourage current customers and new customers to sign longer contracts because shorter contract customers are more likely to churn. Offer incentives or discounts to encourage customers to sign longer contracts.
 
 Above all, implementing my recommendations will help to reduce the churn rate. However, in addition to these recommendations, improving customer service will always help. Attending to customer needs and serving them in the best way possible will help to preclude customers from leaving. Consequently, reducing churn and improving revenue.

 Thanks for reading. Please remember to open my Jupyter Notebook to see my Python code. I enjoyed this project so much. I learn a lot about predictive modeling.




