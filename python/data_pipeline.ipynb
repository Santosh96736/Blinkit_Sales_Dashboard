import pandas as pd
import os 
from sqlalchemy import create_engine, text

user_name = os.getenv('DB_USER')
user_password = os.getenv('DB_PASSWORD')

engine = create_engine(f'mysql+mysqlconnector://{user_name}:{user_password}@localhost/blinkit_analytics')

def read_file(file_name):
    return pd.read_excel(file_name)

def validation(df):
    print(df.dtypes)
    print(df.isnull().sum())
    print(df.duplicated().sum())
    print(df.describe(include = 'all'))

def load_data(df,table_name):
    with engine.begin() as conn:
        conn.execute(text(f'SET FOREIGN_KEY_CHECKS = 0'))
        conn.execute(text(f"TRUNCATE TABLE {table_name}"))
    
        df.to_sql(table_name, con = conn, if_exists = 'append', method = 'multi', index = False)

        conn.execute(text(f'SET FOREIGN_KEY_CHECKS = 1'))

df_customers = read_file('blinkit_raw_data/blinkit_customers.xlsx')
print(df_customers.head())

validation(df_customers)

print(f"Rows Before Cleaning : {len(df_customers)}")

df_customers['phone'] = df_customers['phone'].astype('str')
df_customers['pincode'] = df_customers['pincode'].astype('str')
print(df_customers.dtypes)

df_customers = df_customers.drop_duplicates(subset= 'email', keep = 'first')

df_customers = df_customers[['customer_id','customer_name','email','phone','address','area','pincode',
                             'registration_date','customer_segment']]

print(f"Rows After Cleaning : {len(df_customers)}")

load_data(df_customers,'customers')

df_products = read_file('blinkit_raw_data/blinkit_products.xlsx')

validation(df_products)

load_data(df_products, 'products')

df_inventory = read_file('blinkit_raw_data/blinkit_inventory.xlsx')
print(df_inventory.head())

validation(df_inventory)

print(f"Rows Before Cleaning : {len(df_inventory)}")

df_inventory = df_inventory[df_inventory['product_id'].isin(df_products['product_id'])]

print(f"Rows After Cleaning : {len(df_inventory)}")

load_data(df_inventory,'inventory')

df_orders = read_file('blinkit_raw_data/blinkit_orders.xlsx')
print(df_orders.head())

validation(df_orders)

print(f"Rows Before Cleaning : {len(df_orders)}")

df_orders = df_orders[df_orders['customer_id'].isin(df_customers['customer_id'])]

df_orders = df_orders[['order_id','customer_id','order_date','order_total','payment_method','store_id']]

print(f"Rows After Cleaning : {len(df_orders)}")

load_data(df_orders,'orders')

df_order_items = read_file('blinkit_raw_data/blinkit_order_items.xlsx')
print(df_order_items.head())

validation(df_order_items)

print(f"Rows Before Cleaning : {len(df_order_items)}")

df_order_items = df_order_items[df_order_items['order_id'].isin(df_orders['order_id'])]

df_order_items = df_order_items[df_order_items['product_id'].isin(df_products['product_id'])]

print(f"Rows After Cleaning : {len(df_order_items)}")

load_data(df_order_items,'order_items')

df_delivery_performance = read_file('blinkit_raw_data/blinkit_delivery_performance.xlsx')
print(df_delivery_performance.head())

validation(df_delivery_performance)

print(f"Rows Before Cleaning : {len(df_delivery_performance)}")

df_delivery_performance = df_delivery_performance[df_delivery_performance['order_id'].isin(df_orders['order_id'])]

print(f"Rows After Cleaning : {len(df_delivery_performance)}")

load_data(df_delivery_performance,'delivery_performance')

df_customer_feedback = read_file('blinkit_raw_data/blinkit_customer_feedback.xlsx')
print(df_customer_feedback.head())

validation(df_customer_feedback)

print(f"Rows Before Cleaning : {len(df_customer_feedback)}")

df_customer_feedback = df_customer_feedback[df_customer_feedback['order_id'].isin(df_orders['order_id'])]

df_customer_feedback = df_customer_feedback[['feedback_id','order_id','rating','feedback_text',
                                             'feedback_category','sentiment','feedback_date']]

print(f"Rows After Cleaning : {len(df_customer_feedback)}")

load_data(df_customer_feedback,'customer_feedback')

df_marketing_performance = read_file('blinkit_raw_data/blinkit_marketing_performance.xlsx')
print(df_marketing_performance.head())

validation(df_marketing_performance)

df_marketing_performance = df_marketing_performance[['campaign_id','campaign_name','date',
                                                     'target_audience','channel','impressions',
                                                     'clicks','conversions','spend','revenue_generated']]

load_data(df_marketing_performance,'marketing_performance')
