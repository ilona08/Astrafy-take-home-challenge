SELECT order_date,
order_id,
customer_id,
product_id,
qty,
net_sales
FROM {{ ref('stg_sales') }}

