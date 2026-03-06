--What is the number of orders in the year 2023? 

select count(distinct order_id)
from `dbt_astrafy_staging.stg_orders`
where extract(year from order_date)=2023

--résultat : 2573