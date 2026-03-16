--What is the number of orders per month in the year 2023?

select count(distinct order_id), extract(month from order_date) as month
 from {{ ref('stg_orders') }}
where extract(year from order_date)=2023
group by 2
order by 2

/* résultat :
 [{
  "f0_": "232",
  "month": "1"
}, {
  "f0_": "176",
  "month": "2"
}, {
  "f0_": "203",
  "month": "3"
}, {
  "f0_": "188",
  "month": "4"
}, {
  "f0_": "172",
  "month": "5"
}, {
  "f0_": "169",
  "month": "6"
}, {
  "f0_": "193",
  "month": "7"
}, {
  "f0_": "167",
  "month": "8"
}, {
  "f0_": "212",
  "month": "9"
}, {
  "f0_": "223",
  "month": "10"
}, {
  "f0_": "389",
  "month": "11"
}, {
  "f0_": "249",
  "month": "12"
}]

*/