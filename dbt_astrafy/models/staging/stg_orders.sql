with source as (
    select * from {{ ref('orders') }}
)

select
    date_date as order_date,
    CAST(orders_id  AS STRING) as order_id,
    CAST(customers_id  AS STRING) as customer_id,
    net_sales
from source