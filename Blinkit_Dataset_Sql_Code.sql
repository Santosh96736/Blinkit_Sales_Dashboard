CREATE DATABASE Blinkit;

USE Blinkit;

CREATE TABLE Products(
product_id INT,
product_name VARCHAR(30),	
category VARCHAR(31),	
brand VARCHAR(42),	
price DECIMAL(10,2),	
mrp DECIMAL(10,2),
margin_percentage INT,
shelf_life_days INT,
min_stock_level INT,
max_stock_level INT,
PRIMARY KEY (Product_id)
);

CREATE TABLE Inventory(
product_id INT NOT NULL,
date DATE,	
stock_received INT,
damaged_stock INT,
FOREIGN KEY (product_id) REFERENCES Products (product_id),
PRIMARY KEY (product_id, date)
);

CREATE TABLE New_Inventory(
inventory_id INT AUTO_INCREMENT,
product_id INT NOT NULL,
date DATE,	
stock_received INT,
damaged_stock INT,
PRIMARY KEY (inventory_id),
FOREIGN KEY (product_id) REFERENCES Products (product_id)
);


CREATE TABLE Customers(
customer_id INT,
customer_name VARCHAR(33),
email VARCHAR(45),	
phone VARCHAR(15),	
address VARCHAR(72),	
area VARCHAR(38),	
pincode INT,	
registration_date DATE,	
customer_segment ENUM("Inactive", "New", "Premium", "Regular"),	
total_orders INT,
avg_order_value DECIMAL(10,2),
PRIMARY KEY (customer_id)
);


CREATE TABLE Marketing_Performance(
campaign_id	INT,
campaign_name VARCHAR(31),
date DATE,	
target_audience ENUM("All", "Inactive", "New Users", "Premium"),
channel VARCHAR(22),	
impressions INT,
clicks INT,
conversions INT,
spend DECIMAL(10,2),
revenue_generated DECIMAL(10,2),
roas DECIMAL(10,2),
PRIMARY KEY (campaign_id)
);

CREATE TABLE Orders(
order_id BIGINT,	
customer_id INT NOT NULL,	
order_date DATETIME,
promised_delivery_time DATETIME,	
actual_delivery_time DATETIME,
delivery_status ENUM("ON Time", "Slightly Delayed", "Significantly Delayed"),
order_total DECIMAL(10,2),
payment_method ENUM("Card", "Cash", "UPI", "Wallet"),
delivery_partner_id INT,
store_id INT,
PRIMARY KEY (order_id),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Order_Items(
order_id BIGINT NOT NULL,
product_id INT NOT NULL,
quantity INT,	
unit_price DECIMAL(10,2),
PRIMARY KEY (order_id, product_id),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Delivery_Performance(
order_id BIGINT NOT NULL,	
delivery_partner_id INT,	
promised_time DATETIME,	
actual_time DATETIME,	
delivery_time_minutes INT,	
distance_km INT,	
delivery_status ENUM("ON Time", "Slightly Delayed", "Significantly Delayed"),	
reasons_if_delayed ENUM("No Issue", "Traffic"),
PRIMARY KEY (order_id, delivery_partner_id, promised_time),
FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Customer_Feedback(
feedback_id INT,	
order_id BIGINT NOT NULL,	
customer_id INT NOT NULL,	
rating INT,	
feedback_text VARCHAR(61),	
feedback_category ENUM("App Experience", "Customer Service", "Delivery", "Product Quality"),	
sentiment ENUM("Negative", "Neutral", "Positive"),	
feedback_date DATE,
PRIMARY KEY (feedback_id),
FOREIGN KEY (order_id) REFERENCES Orders(order_id),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- SALES PERFORMANCE DASHBOARD 

-- KPI QUERIES

-- TOTAL GROSS REVENUE 
SELECT ROUND(SUM(quantity * unit_price),0) AS gross_revenue
FROM Order_Items;

-- TOTAL UNITS SOLD 
SELECT SUM(quantity) AS total_units
FROM Order_Items;

-- AVERAGE ORDER VALUES
SELECT ROUND(SUM(quantity * unit_price) / (SELECT COUNT(DISTINCT order_id) FROM Orders),0) AS avg_order_value
FROM Order_Items;


-- YEAR-OVER-YEAR GROWTH RATE 
WITH current_year_data AS (SELECT YEAR(order_date) AS year, SUM(oi.quantity * oi.unit_price) AS current_year_revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE YEAR(order_date) = (SELECT MAX(YEAR(order_date)) FROM Orders)
GROUP BY year),

previous_year_data AS (SELECT YEAR(order_date) AS year, SUM(oi.quantity * oi.unit_price) AS previous_year_revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE YEAR(order_date) = (SELECT MAX(YEAR(order_date)) FROM Orders) - 1
GROUP BY year)

SELECT CONCAT(ROUND(((current_year_revenue - previous_year_revenue) / previous_year_revenue),2) * 100, "%") AS yoy_growth_rate
FROM current_year_data, previous_year_data;

-- END OF KPI QUERIES

-- VISUAL QUERIES

-- MONTHLY SALES TREND
SELECT DATE_FORMAT(o.order_date, "%Y-%m") AS order_month,
	   SUM(oi.quantity * oi.unit_price) AS gross_revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month DESC;


-- UNITSOLD BY CATEGORY
WITH product_data AS(SELECT YEAR(o.order_date) AS year, oi.product_id, SUM(oi.quantity) AS quantity
FROM Order_Items oi
JOIN Orders o ON oi.order_id = o.order_id
GROUP BY year, product_id)

SELECT year, category, SUM(quantity) AS total_unit_sold
FROM product_data pd
JOIN products p ON p.product_id = pd.product_id
GROUP BY year, category
ORDER BY year DESC, total_unit_sold DESC;

-- REVENUE BY PAYMENT METHOD
SELECT YEAR(o.order_date) AS year,o.payment_method, SUM(oi.quantity * oi.unit_price) AS total_revenue, 
 CONCAT(ROUND((SUM(oi.quantity * oi.unit_price)/ 
SUM(SUM(oi.quantity * oi.unit_price)) 
        OVER (PARTITION BY YEAR(o.order_date))) * 100,1), "%") AS revenue_percentage
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY year, payment_method
ORDER BY year DESC, revenue_percentage DESC; 

-- REVENUE BY AREA
SELECT YEAR(o.order_date) AS year, c.area, SUM(oi.quantity * oi.unit_price) AS revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON oi.order_id = o.order_id
GROUP BY year, c.area
ORDER BY year DESC, revenue DESC;


-- CUSTOMER AND FEEDBACK DASHBOARD 

-- KPI QUERIES

-- TOTAL CUSTOMER  
SELECT COUNT(DISTINCT customer_id) AS total_customer
FROM Customers;

-- CUSTOMER RETENTION RATE (LAST 30 DAYS)
SELECT CONCAT(ROUND(((COUNT(DISTINCT c.customer_id) / 
                       (SELECT COUNT(DISTINCT customer_id) FROM Customers)) * 100),2),"%") AS retention_rate
FROM Customers c 
JOIN Orders o ON o.customer_id = c.customer_id
WHERE o.order_date >= (SELECT MAX(DATE(order_date)) FROM  Orders) - INTERVAL 1 MONTH;

-- TOTAL FEEDBACK
SELECT COUNT(DISTINCT feedback_Id) AS total_feedback
FROM Customer_Feedback;

-- AVERAGE FEEDBACK RATE
SELECT ROUND(AVG(rating),2) AS avg_feedback
FROM Customer_Feedback;

-- CHART QUERIES

-- MONTHLY ACTIVE CUSTOMERS
SELECT DATE_FORMAT(o.order_date, "%Y-%m") AS year, COUNT(DISTINCT c.customer_id) AS customer_count
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY year
ORDER BY year;

-- REVENUE BY CUSTOMER SEGMENT 
SELECT YEAR(o.order_date) AS year, customer_segment, SUM(oi.quantity * oi.unit_price) AS revenue
FROM Order_Items oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY year, customer_segment
ORDER BY year DESC, revenue DESC;

-- TOP CATEGORY BY CUSTOMER SATISFACTION (AVG. RATING)
SELECT YEAR(cf.feedback_date) AS year, p.category, ROUND(AVG(cf.rating),2) AS avg_rating
FROM Products p 
JOIN Order_Items oi ON p.product_id = oi.product_id
JOIN Customer_Feedback cf ON cf.order_id = oi.order_id
GROUP BY year, p.category
ORDER BY year DESC, avg_rating DESC; 

-- FEEDBACK COUNT BY RATING (DISTRIBUTION OF RATING)
SELECT YEAR(feedback_date) AS year,rating, COUNT(*) AS feedback_count
FROM Customer_Feedback
GROUP BY year,rating
ORDER BY year DESC, feedback_count DESC;

-- MARKETING AND DELIVERY PERFORMANCE DASHBOARD

-- KPI QUERIES

-- TOTAL MARKETING SPEND
SELECT ROUND(SUM(spend)) AS total_spend
FROM Marketing_Performance;

-- AVERAGE ROAS (RETURN ON AD SPEND)
SELECT ROUND(SUM(revenue_generated) / SUM(spend),2) AS avg_roas
FROM Marketing_Performance;

-- AVERAGE DELIVERY TIME
SELECT ROUND(AVG(delivery_time_minutes)) AS avg_delivery_delay
FROM Delivery_Performance;

-- ON TIME DELIVERY RATE 
SELECT CONCAT(ROUND(((SELECT COUNT(order_id) FROM delivery_performance WHERE delivery_status = "ON Time") / 
               COUNT(order_id)) * 100,2),"%") AS ontime_rate
FROM Delivery_Performance;

-- CHART QUERIES

-- SPEND VS. REVENUE GENERATED
SELECT DATE_FORMAT(date, "%Y-%m") AS month, SUM(spend) AS total_spend, SUM(revenue_generated) AS total_revenue_generated
FROM Marketing_Performance
GROUP BY month
ORDER BY month DESC, total_revenue_generated DESC;

-- REVENUE GENERATED BY CHANNEL
SELECT YEAR(date) AS year, channel, SUM(revenue_generated) AS total_revenue_generated,
       CONCAT(ROUND(SUM(revenue_generated)/ 
	   SUM(SUM(revenue_generated)) OVER(PARTITION BY YEAR(date) ORDER BY YEAR(date)) * 100,1),"%") AS revenue_percentage
FROM Marketing_Performance
GROUP BY year, channel
ORDER BY total_revenue_generated DESC, year DESC;

-- MONTHLY AVERAGE DELIVERY TIME
SELECT DATE_FORMAT(dp.actual_time, "%Y-%m") AS year, 
	ROUND(AVG(delivery_time_minutes)) AS avg_delivery_time
FROM Delivery_Performance dp
JOIN Orders o ON o.order_id = dp.order_id
GROUP BY year
ORDER BY year DESC, avg_delivery_time;

-- ORDER PERCENTAGE BY DELIVERY STATUS
SELECT YEAR(actual_time) AS year, delivery_status, COUNT(order_id) AS order_count,
       CONCAT(ROUND((COUNT(order_id) / 
       SUM(COUNT(order_id))OVER(PARTITION BY YEAR(actual_time) ORDER BY YEAR(actual_time))) * 100,1), "%") AS order_percentage,
       ROUND(AVG(delivery_time_minutes)) AS avg_delivery_delay
FROM Delivery_Performance
GROUP BY year, delivery_status
ORDER BY year DESC, order_count DESC;

 
