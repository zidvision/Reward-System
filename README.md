# Customer Reward Tier System

## Project Objective

To classify customers into tiered reward levels (Platinum, Gold, Silver, Bronze, Inactive) based on their total spending over the last 6 months. This enables businesses to reward high-value customers, encourage retention, and personalize marketing efforts.

---

## Dataset Used
- `Online Retail`  
By: [Chen, D. (2015). Online Retail [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5BW33.](https://archive.ics.uci.edu/dataset/352/online+retail)
---

## Business Questions Answered
- Who are our top spending customers in the recent 6-month period?
- How can we segment customers based on spending behavior?
- What reward tiers should we assign to incentivize loyal customers?

---

## Process

### 1. Data Cleaning and Preparation
- Cleaned null values, duplicates, and canceled transactions
- Filtered transactions with positive quantity and price
- Created Total_Price column: Total_Price = Quantity * UnitPrice
- Saved the cleaned dataset to CSV/Excel format for database import

[View cleaned dataset](https://github.com/zidvision/Reward-System/blob/main/Data/Online_Retail_Cleaned.zip)

### 2. Database Setup  
- Created a new MySQL database: `Online_Retail_Project`  
- Defined schema for the `Online_Retail` table with fields including invoice, product, pricing, and customer information  
- Loaded the cleaned dataset into MySQL using `LOAD DATA INFILE`

### 3. Customer Spending Calculation  
- Defined a Common Table Expression (CTE) to identify the latest purchase date in the dataset  
- Calculated **Total Spending per Customer** for the most recent 6-month period

### 4. Percentile Ranking  
- Ranked customers by spending using `PERCENT_RANK()` window function  
- Assigned each customer a percentile based on their total spent

### 5. Reward Tier Classification  
- Customers are categorized into the following tiers based on their percentile and amount spent:
  - **Platinum**: Top 10% of customers who spent more than 500  
  - **Gold**: Top 30% of customers who spent more than 200  
  - **Silver**: Top 60% of customers who spent more than 50  
  - **Bronze**: Top 90% of customers who spent more than 0  
  - **Inactive**: Remaining customers

- Created a view `Customer_Reward_Tiers` to store and access these classifications easily

### 6. Querying the Reward View  
To see the result, use the following query:
```sql
SELECT * FROM Customer_Reward_Tiers;
```
[Explore the code](https://github.com/zidvision/Reward-System/blob/main/Code/Customer_Reward_System.sql)

---

## Key Insights  
- Customer reward tiers allow easy identification of high-value and low-engagement customers
- Tier-based customer classification allows the business to focus on its most valuable customers
- Tier thresholds ensure fair segmentation based on both behavior and business-defined value  
- Can be integrated into CRM systems to drive reward-based marketing campaigns through API-based integrations (e.g., Python with HubSpot or Salesforce APIs) or other methods

---

## Conclusion  
By implementing this SQL-based reward tiering system:  
- Businesses can promote loyalty by recognizing top customers  
- Retention strategies become more personalized and cost-efficient  
- Customer analytics is enhanced by incorporating time-based and percentile-based segmentation 

## Tools Used  
- Excel
- MySQL
