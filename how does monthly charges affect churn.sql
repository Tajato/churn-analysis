--How does monthly charges affect churn?

SELECT churn, AVG(monthlycharges) as monthly_charges
from customers
GROUP BY churn;


--The average monthly charge for those who are churning is
--74, while 61 for those who do not churn
--So, this means that those who churn pay more in monthly charges
--However, we are going to use hypothesis testing to find out
--if this is a statistical relationship or it's just chance.
