CREATE VIEW fact_orders AS
    SELECT 
        order_id, order_total
    FROM
        orders;

CREATE VIEW fact_sales AS
    SELECT 
        order_id,
        product_id,
        unit_price,
        quantity,
        (quantity * unit_price) AS gross_revenue
    FROM
        order_items;

CREATE VIEW fact_delivery AS
    SELECT 
        dp.order_id,
        dp.delivery_time_minutes,
        TIMESTAMPDIFF(MINUTE, o.order_date, dp.actual_time) AS delivery_time_min,
        dp.distance_km,
        dp.delivery_status
    FROM
        delivery_performance AS dp
	JOIN 
		orders AS o
        ON o.order_id = dp.order_id;

CREATE VIEW fact_feedback AS
    SELECT 
        feedback_id, order_id, rating, sentiment, feedback_date
    FROM
        customer_feedback;

CREATE VIEW fact_marketing AS
    SELECT 
        campaign_id,
        date AS campaign_date,
        impressions,
        clicks,
        conversions,
        spend,
        revenue_generated
    FROM
        marketing_performance;


CREATE VIEW dim_orders AS
    SELECT 
        order_id,
        customer_id,
        DATE(order_date) AS order_date,
        HOUR(order_date) AS order_hour,
        payment_method
    FROM
        orders;

CREATE VIEW dim_customers AS
    SELECT 
        customer_id, customer_segment, area, pincode
    FROM
        customers;

CREATE VIEW dim_products AS
    SELECT 
        product_id, product_name, category, brand
    FROM
        products;

CREATE VIEW dim_campaign AS
    SELECT DISTINCT
        campaign_id, campaign_name, channel, target_audience
    FROM
        marketing_performance;

CREATE VIEW dim_date AS
    SELECT DISTINCT
        full_date,
        YEAR(full_date) AS year,
        MONTH(full_date) AS month,
        DAYNAME(full_date) AS day_name
    FROM
        (SELECT 
            DATE(order_date) AS full_date
        FROM
            orders UNION SELECT 
            feedback_date AS full_date
        FROM
            customer_feedback UNION SELECT 
            date AS full_date
        FROM
            marketing_performance) AS all_dates;
