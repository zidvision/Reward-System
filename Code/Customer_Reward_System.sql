CREATE DATABASE
Online_Retail_Project;
USE Online_Retail_Project;

CREATE TABLE Online_Retail (
	InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate DATETIME,
    `Year` INT,
    `Month` INT,
    `Day` INT,
    UnitPrice FLOAT,
    CustomerID VARCHAR(20),
    Country VARCHAR(50),
    Total_Price FLOAT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Online_Retail_Cleaned.csv'
INTO TABLE Online_Retail
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE VIEW Customer_Reward_Tiers AS 
WITH MaxDate AS (
	SELECT MAX(InvoiceDate) AS LatestDate FROM Online_Retail
),
Spend AS (
	SELECT o.CustomerID, SUM(o.Total_Price) AS Total_Spent
	FROM Online_Retail o
	JOIN MaxDate m ON o.InvoiceDate >= DATE_SUB(m.LatestDate, INTERVAL 6 MONTH)
	GROUP BY o.CustomerID
),
Percentile_Ranked AS( 
	SELECT CustomerID, Total_Spent, 
		PERCENT_RANK() OVER(ORDER BY Total_Spent DESC) AS Pct_Rank
	FROM Spend
)
SELECT CustomerID, Total_Spent, Pct_Rank,
	CASE
		WHEN Pct_Rank <= 0.10 AND Total_Spent > 500 THEN 'Platinum'
		WHEN Pct_Rank <= 0.30 AND Total_Spent > 200 THEN 'Gold'
		WHEN Pct_Rank <= 0.60 AND Total_Spent > 50 THEN 'Silver'
		WHEN Pct_Rank <= 0.90 AND Total_Spent > 0 THEN 'Bronze'
		ELSE 'Inactive'
	END AS Reward_Tier
FROM Percentile_Ranked;


SELECT *
FROM Customer_Reward_Tiers;
