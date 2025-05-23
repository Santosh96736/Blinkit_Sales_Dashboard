# Blinkit_Sales_Dashboard
-  Analyzing online grocery performance for Blinkit using SQL, Excel & Tableau

## TABLE CONTENTS
1. [PROJECT OVERVIEW](#1-Project-overview)
2. [TECH STACK](#2-Tech-Stack)
3. [PROJECT OBJECTIVE](#3-Project-Objective)
4. [DATASETS USED](#4-Datasets-Used)
5. [DATA CLEANING](#5-Data-Cleaning)
6. [KEY ANALYSIS PERFORMED](#6-Key-Analysis-Performed)
7. [TABLEAU DASHBOARDS](#7-Tableau-Dashboards)
8. [KEY FINDINGS](#8-Key-Findings)
9. [SUGGESTION AND RECOMMENDATION](#9-Suggestion-and-Recommendation)
10. [CONTACT](#10-Contact)

## 1. Project Overview
-   This project analyzes Blinkit's sales, customer behavior, delivery performance, and product demand using a combination of SQL, Excel, and Tableau. The aim is to provide 
    actionable insights for improving operations, increasing customer satisfaction, and boosting profitability.

    Blinkit is one of India’s leading instant delivery platforms, and this project simulates real-world decision-making scenarios by analyzing critical metrics from various 
    business areas like marketing, inventory, and customer feedback.

-   To Download The Dataset Click Here : [Blinkit Sales Dataset](https://www.kaggle.com/datasets/akxiit/blinkit-sales-dataset)

## 2. Tech Stack
- **Languages:** SQL, Excel, Tableau
- **Database:** MySQL
- **Visualization:** Tableau
- **Tools Used for Cleaning & Uploading:** Excel, MySQL Workbench

## 3. Project Objectives
- Evaluate sales and revenue trends over time.
- Understand product demand and top-performing items.
- Analyze customer feedback and retention.
- Track marketing campaign performance and ROI.


## 4. Datasets Used
- The dataset includes the following tables:

   **Datasets**
- `blinkit_orders:` Contains all customer orders 
- `blinkit_order_items:` Product details in each order
- `blinkit_products:` 	Product catalog with prices and categories
- `blinkit_customers:` Customer demographics and region info
- `blinkit_customer_feedback:` 	Ratings and review comments
- `blinkit_inventory:` Inventory availability and stock levels
- `blinkit_inventory_new:` Daily updated inventory data
- `blinkit_marketing_performance:` Campaign costs and conversions
- `blinkit_delivery_performance:` 	Delivery status, delay time, delay reason
  
- A comprehensive schema diagram was created in MySQL Workbench, with primary and foreign keys declared across all tables.
  To Review The Schema and Queries Click Here : [MySQL Schema](https://github.com/Santosh96736/Blinkit_Sales_Dashboard/blob/main/Blinkit_Dataset_Schema.sql)
                                                [MySQL Queries](https://github.com/Santosh96736/Blinkit_Sales_Dashboard/blob/main/Blinkit_Dataset_queries.sql)


## 5. Data Cleaning
- Cleaned and formatted raw .csv files using Excel.

- Handled missing values, duplicates, and formatting inconsistencies.

- Uploaded cleaned data into MySQL using Table Data Import Wizard.

- Ensured referential integrity using primary and foreign keys.


## 6. Key Analysis Performed
- Sales Trend Analysis
- Top Selling Products & Categories
- Customer Segmentation & Retention
- Payment Mode Breakdown
- Delivery Performance by Time
- Marketing ROI and Conversion Analysis
- Customer Ratings & Sentiment Review

## 7. Tableau Dashboards
| **Dashboard** | **Description** |
|----------|-------------|
| 📊 Sales Dashboard| Year-over-year sales, top categories, daily trends |
| 🧑‍🤝‍🧑 Customer Dashboard | Demographics, retention, feedback rating trends |
| 🚚 Delivery Dashboard | Avg delivery time, city-wise delay rates |
- To Preview the Dashboards Click Here : [Sales Dashboards](https://github.com/Santosh96736/Blinkit_Sales_Dashboard/blob/main/Sales%20Dashboard.png)
                                         [Customer Dashboard](https://github.com/Santosh96736/Blinkit_Sales_Dashboard/blob/main/Customer%20and%20Feeback%20Dashboard.png)
                                         [Delivery Dashboard](https://github.com/Santosh96736/Blinkit_Sales_Dashboard/blob/main/Marketing%20and%20Delivery%20Performance%20Dashboard.png)
  ![Sales Dashboard](https://github.com/Santosh96736/Blinkit_Sales_Dashboard/blob/main/Sales%20Dashboard.png)

  
## 8. Key Insights
- **Top Product Categories:** Dairy, grocery, fruits, cold drinks and baby care led the sales chart.
- **YOY Growth:** 2% Vs. Previous Year
- **Retention Rate:**  10% in last 30 days
- **Revenue By Customer Segement:** $694k Regular, We earn more from our regular customer than premium or new customers.
- **Avg Feedback Rating:** 3.34, most of the people gave 3 and 4 rating.
- **Marketing ROI:** Email campaigns had the highest ROI among all channels.
- **AVG Delivery Time:** 4 Minutes Delay


## 9. Suggestion and Recommendation
- **Reallocate Inventory to High-Demand Zones:** Focus on cities like Burhanpur, Orai, and Nizamabad with the highest order volumes and revenue.
- **Reduce Cart Abandonment in Top Cities:** Implement email reminders and checkout incentives to recover abandoned carts.
- **ptimize Marketing Spend:** Increase investment in Social Media and Push Notifications. Reassess spend on Influencer Marketing.
- **Use Feedback to Enhance Experience:** Analyze negative reviews using sentiment analysis to identify common issues and respond proactively.
- **Reward Loyal Customers:** Launch a tiered loyalty program offering exclusive deals and early product access for repeat buyers.
- **Improve Late Delivery Metrics:** Use real-time route optimization and inventory proximity to reduce late deliveries for essential products.
- **Promote Best-Selling Products:** Highlight top-performing items in ads, bundle them in deals, or feature them on landing pages.

## 10. Contact
-  LINKEDIN : [Santosh Kumar Sahu](https://www.linkedin.com/in/santosh-kumar-sahu-data-analyst)
-  EMAIL : [santosh96736@gmail.com](santosh96736@gmail.com)
-  TABLEAU PUBLIC : [Santosh Kumar Sahu](https://public.tableau.com/app/profile/santosh.data.analyst)

