views = ['fact_orders','fact_sales','fact_delivery','fact_feedback','fact_campaign_performance',
         'dim_orders','dim_customers','dim_products','dim_campaign','dim_date']

output_folder = 'tableau_data'
os.makedirs(output_folder, exist_ok=True)

for view in views:
    file_path = os.path.join(output_folder,f"{view}.csv")

    df = pd.read_sql(text(f"SELECT * FROM {view}"), engine)

    df.to_csv(file_path, index = False)

    print(f"{len(df)} rows exported to {file_path}")
