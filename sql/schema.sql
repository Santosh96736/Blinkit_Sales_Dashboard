CREATE DATABASE IF NOT EXISTS blinkit_analytics;

USE blinkit_analytics;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(100) NOT NULL,
    area VARCHAR(50) NOT NULL,
    pincode VARCHAR(6) NOT NULL,
    registration_date DATE NOT NULL,
    customer_segment VARCHAR(20) NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (customer_id),
    CONSTRAINT uq_email UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS products (
    product_id INT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    mrp DECIMAL(10 , 2 ) NOT NULL,
    margin_percentage DECIMAL(5 , 2 ) NOT NULL,
    shelf_life_days INT NOT NULL,
    min_stock_level INT NOT NULL,
    max_stock_level INT NOT NULL,
    CONSTRAINT pk_products PRIMARY KEY (product_id),
    CONSTRAINT chk_products_price CHECK (price > 0),
    CONSTRAINT chk_products_mrp CHECK (mrp > 0),
    CONSTRAINT chk_products_mrp_price CHECK (mrp >= price),
    CONSTRAINT chk_products_margin_percentage CHECK (margin_percentage BETWEEN 0 AND 100),
    CONSTRAINT chk_products_shelf_life_days CHECK (shelf_life_days > 0),
    CONSTRAINT chk_products_min_stock_level CHECK (min_stock_level >= 0),
    CONSTRAINT chk_products_max_stock_level CHECK (max_stock_level > 0),
    CONSTRAINT chk_products_stock_level CHECK (max_stock_level >= min_stock_level)
);


CREATE TABLE IF NOT EXISTS inventory (
    product_id INT,
    date DATE NOT NULL,
    stock_received INT NOT NULL,
    damaged_stock INT NOT NULL,
    CONSTRAINT pk_inventory PRIMARY KEY (product_id , date),
    CONSTRAINT fk_inventory_products FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    CONSTRAINT chk_inventory_stock_received CHECK (stock_received >= 0),
    CONSTRAINT chk_inventory_damaged_stock CHECK (damaged_stock >= 0)
);


CREATE TABLE IF NOT EXISTS orders (
    order_id BIGINT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    order_total DECIMAL(10 , 2 ) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    store_id INT NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id),
    CONSTRAINT chk_orders_order_total CHECK (order_total > 0)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_id BIGINT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT pk_order_items PRIMARY KEY (order_id , product_id),
    CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT fk_order_items_products FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    CONSTRAINT chk_order_items_quantity CHECK (quantity > 0),
    CONSTRAINT chk_order_items_unit_price CHECK (unit_price > 0)
);

CREATE TABLE IF NOT EXISTS delivery_performance (
    order_id BIGINT,
    delivery_partner_id INT NOT NULL,
    promised_time DATETIME NOT NULL,
    actual_time DATETIME NOT NULL,
    delivery_time_minutes INT NOT NULL,
    distance_km DECIMAL(5 , 2 ) NOT NULL,
    delivery_status VARCHAR(50) NOT NULL,
    reasons_if_delayed VARCHAR(50) NOT NULL,
    CONSTRAINT pk_delivery_performance PRIMARY KEY (order_id),
    CONSTRAINT fk_delivery_performance_orders FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT chk_delivery_perfomance_distance_km CHECK (distance_km > 0)
);


CREATE TABLE IF NOT EXISTS customer_feedback (
    feedback_id INT,
    order_id BIGINT NOT NULL,
    rating INT NOT NULL,
    feedback_text VARCHAR(150) NOT NULL,
    feedback_category VARCHAR(50) NOT NULL,
    sentiment VARCHAR(50) NOT NULL,
    feedback_date DATE NOT NULL,
    CONSTRAINT pk_customer_feedback PRIMARY KEY (feedback_id),
    CONSTRAINT fk_customer_feedback_orders FOREIGN KEY (order_id)
        REFERENCES orders (order_id),
    CONSTRAINT chk_customer_feedback_rating CHECK (rating BETWEEN 1 AND 5)
);


CREATE TABLE IF NOT EXISTS marketing_performance (
    campaign_id INT,
    campaign_name VARCHAR(100) NOT NULL,
    date DATE NOT NULL,
    target_audience VARCHAR(50) NOT NULL,
    channel VARCHAR(50) NOT NULL,
    impressions INT NOT NULL,
    clicks INT NOT NULL,
    conversions INT NOT NULL,
    spend DECIMAL(10 , 2 ) NOT NULL,
    revenue_generated DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT pk_marketing_performance PRIMARY KEY (campaign_id , date),
    CONSTRAINT chk_marketing_performance_impressions CHECK (impressions >= 0),
    CONSTRAINT chk_marketing_performance_clicks CHECK (clicks >= 0),
    CONSTRAINT chk_marketing_performance_conversions CHECK (conversions >= 0),
    CONSTRAINT chk_marketing_performance_impressions_clicks CHECK (clicks <= impressions),
    CONSTRAINT chk_marketing_performance_clicks_conversions CHECK (conversions <= clicks),
    CONSTRAINT chk_marketing_performance_spend CHECK (spend >= 0),
    CONSTRAINT chk_marketing_performance_revenue_generated CHECK (revenue_generated >= 0)
);
