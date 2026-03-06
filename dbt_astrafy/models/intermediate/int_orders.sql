SELECT o.order_date,
    o.order_id,
    o.customer_id,
    o.net_sales,
    qty_product
FROM {{ ref('stg_orders') }} o
LEFT JOIN
  (
    SELECT order_id, COUNT(DISTINCT product_id) AS qty_product
    FROM {{ ref('stg_sales') }}
    GROUP BY 1
  ) s
  ON o.order_id = s.order_id
WHERE EXTRACT(year FROM order_date) in (2022,2023)
