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



 
