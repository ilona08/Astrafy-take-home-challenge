--What is the average number of products per order for each month of the year 2023?
select round(count(product_id)/count(distinct o.order_id),2) as avg_product_per_order, extract(month from order_date) as month
 from {{ ref('stg_orders') }} o
 left join (select order_id,product_id from {{ ref('stg_sales') }} ) s on o.order_id=s.order_id
where extract(year from order_date)=2023
group by 2
order by 2

/* résultat :
[{
  "avg_product_per_order": "7.93",
  "month": "1"
}, {
  "avg_product_per_order": "7.96",
  "month": "2"
}, {
  "avg_product_per_order": "7.87",
  "month": "3"
}, {
  "avg_product_per_order": "8.64",
  "month": "4"
}, {
  "avg_product_per_order": "8.55",
  "month": "5"
}, {
  "avg_product_per_order": "7.95",
  "month": "6"
}, {
  "avg_product_per_order": "7.64",
  "month": "7"
}, {
  "avg_product_per_order": "8.38",
  "month": "8"
}, {
  "avg_product_per_order": "7.89",
  "month": "9"
}, {
  "avg_product_per_order": "7.54",
  "month": "10"
}, {
  "avg_product_per_order": "6.39",
  "month": "11"
}, {
  "avg_product_per_order": "6.41",
  "month": "12"
}]
*/