"""
Convert Excel source files to CSV seeds for dbt.

Usage:
    pip install pandas openpyxl
    python excel_to_csv.py
"""

import pandas as pd

df_orders = pd.read_excel("origin_data/orders_recrutement.xlsx")
df_orders.to_csv("dbt_astrafy/seeds/orders.csv", index=False)
print("orders.csv generated")

df_sales = pd.read_excel("origin_data/sales_recrutement.xlsx")
df_sales.to_csv("dbt_astrafy/seeds/sales.csv", index=False)
print("sales.csv generated")
