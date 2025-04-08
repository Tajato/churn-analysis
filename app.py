# Deploying the model 

import streamlit as st
import pandas as pd
import pickle

# Load the model 
with open('churn_model.pkl', 'rb') as f:
    log_model = pickle.load(f)

# load sample data to test the model
data = pd.read_csv('sample_customers.csv')  # Saved a sample of the test data in my notebook earlier.
feature_cols = data.columns #storing all the features into this vairbale.

# Streamlit UI 
st.title("Churn Risk Analyzer")

# Let user select a customer
selected_customer = st.selectbox("Select a customer to analyze", data.index)

# Show selected customer’s info
st.subheader("Customer Info")
st.write(data.loc[selected_customer]) #grab that specific row from the data

# Predicting churn
input_data = data.loc[[selected_customer]] #store selected row inside input_data variable
churn_prob = log_model.predict_proba(input_data)[0][1] # so I can pass it into the predict_proba function and store the predictions in chrun_prob
#predict_proba returns a 2d array, so I grab class 1 from the first row([0][1])

# Categorize the churn risk based on the classification threshold.
risk_level = "Low"
if churn_prob > 0.7:
    risk_level = "High"
elif churn_prob > 0.4:
    risk_level = "Medium"

# Displaying the results
st.subheader("Churn Prediction")
st.metric("Churn Probability", f"{churn_prob:.2%}")
st.metric("Risk Level", risk_level)

st.markdown("---")
st.markdown(
    "<div style='text-align: center;'>"
    "Developed by Tahj Gordon • 2025"
    "</div>",
    unsafe_allow_html=True
)
