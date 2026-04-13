import pandas as pd
import os 
from sqlalchemy import create_engine, text

user_name = os.getenv('DB_USER')
user_password = os.getenv('DB_PASSWORD')

engine = create_engine(f'mysql+mysqlconnector://{user_name}:{user_password}@localhost/blinkit_analytics')

def read_excel_file(file_name):
    return pd.read_excel(file_name)

def validate_data(df):
    print(df.dtypes)
    print(df.isnull().sum())
    print(df.duplicated().sum())
    print(df.describe(include = 'all'))

def load_to_mysql(df,table_name):
    with engine.begin() as conn:
        conn.execute(text(f'SET FOREIGN_KEY_CHECKS = 0'))
        conn.execute(text(f"TRUNCATE TABLE {table_name}"))
    
        df.to_sql(table_name, con = conn, if_exists = 'append', method = 'multi', index = False)

        conn.execute(text(f'SET FOREIGN_KEY_CHECKS = 1'))

customers_df = read_excel_file('blinkit_raw_data/blinkit_customers.xlsx')
print(customers_df.head())

validate_data(customers_df)

print(f"Rows Before Cleaning : {len(customers_df)}")

customers_df['phone'] = customers_df['phone'].astype('str')
customers_df['pincode'] = customers_df['pincode'].astype('str')
print(customers_df.dtypes)

customers_df = customers_df.drop_duplicates(subset= 'email', keep = 'first')

customers_df = customers_df[['customer_id','customer_name','email','phone','address','area','pincode',
                             'registration_date','customer_segment']]

print(f"Rows After Cleaning : {len(customers_df)}")

load_to_mysql(customers_df,'customers')

products_df = read_excel_file('blinkit_raw_data/blinkit_products.xlsx')

validate_data(products_df)

load_to_mysql(products_df, 'products')

inventory_df = read_excel_file('blinkit_raw_data/blinkit_inventory.xlsx')
print(inventory_df.head())

validate_data(inventory_df)

print(f"Rows Before Cleaning : {len(inventory_df)}")

inventory_df = inventory_df[inventory_df['product_id'].isin(products_df['product_id'])]

print(f"Rows After Cleaning : {len(inventory_df)}")

load_to_mysql(inventory_df,'inventory')

orders_df = read_excel_file('blinkit_raw_data/blinkit_orders.xlsx')
print(orders_df.head())

validate_data(orders_df)

print(f"Rows Before Cleaning : {len(orders_df)}")

orders_df = orders_df[orders_df['customer_id'].isin(customers_df['customer_id'])]

orders_df = orders_df[['order_id','customer_id','order_date','order_total','payment_method','store_id']]

print(f"Rows After Cleaning : {len(orders_df)}")

load_to_mysql(orders_df,'orders')

order_items_df = read_excel_file('blinkit_raw_data/blinkit_order_items.xlsx')
print(order_items_df.head())

validate_data(order_items_df)

print(f"Rows Before Cleaning : {len(order_items_df)}")

order_items_df = order_items_df[order_items_df['order_id'].isin(orders_df['order_id'])]

order_items_df = order_items_df[order_items_df['product_id'].isin(products_df['product_id'])]

print(f"Rows After Cleaning : {len(order_items_df)}")

load_to_mysql(order_items_df,'order_items')

delivery_performance_df = read_excel_file('blinkit_raw_data/blinkit_delivery_performance.xlsx')
print(delivery_performance_df.head())

validate_data(delivery_performance_df)

print(f"Rows Before Cleaning : {len(delivery_performance_df)}")

delivery_performance_df = delivery_performance_df[delivery_performance_df['order_id'].isin(orders_df['order_id'])]

print(f"Rows After Cleaning : {len(delivery_performance_df)}")

load_to_mysql(delivery_performance_df,'delivery_performance')

customer_feedback_df = read_excel_file('blinkit_raw_data/blinkit_customer_feedback.xlsx')
print(customer_feedback_df.head())

validate_data(customer_feedback_df)

print(f"Rows Before Cleaning : {len(customer_feedback_df)}")

customer_feedback_df = customer_feedback_df[customer_feedback_df['order_id'].isin(orders_df['order_id'])]

customer_feedback_df = customer_feedback_df[['feedback_id','order_id','rating','feedback_text',
                                             'feedback_category','sentiment','feedback_date']]

print(f"Rows After Cleaning : {len(customer_feedback_df)}")

load_to_mysql(customer_feedback_df,'customer_feedback')

marketing_performance_df = read_excel_file('blinkit_raw_data/blinkit_marketing_performance.xlsx')
print(marketing_performance_df.head())

validate_data(marketing_performance_df)

marketing_performance_df = marketing_performance_df[['campaign_id','campaign_name','date',
                                                     'target_audience','channel','impressions',
                                                     'clicks','conversions','spend','revenue_generated']]

load_to_mysql(marketing_performance_df,'marketing_performance')
