SELECT order_date,
    customer_id,
    order_id,
    product_id,
    net_sales,
    qty 
FROM {{ ref('stg_sales') }} o
WHERE EXTRACT(year FROM order_date)=2023