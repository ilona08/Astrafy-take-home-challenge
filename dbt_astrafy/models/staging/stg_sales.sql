with source as (
    select * from {{ ref('sales') }}
)

select
    date_date as order_date,
    CAST(order_id  AS STRING) as order_id,
    CAST(customer_id  AS STRING) as customer_id,
    CAST(products_id  AS STRING) as product_id,
    qty,
    net_sales
from source