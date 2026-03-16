WITH
  orders_2023 AS (
    SELECT
      order_id,
      customer_id,
      order_date,
      net_sales
    FROM {{ ref('stg_orders') }}
    WHERE EXTRACT(YEAR FROM order_date) = 2023
  ),
  orders_prior AS (
    SELECT
      o1.order_id,
      o1.customer_id,
      o1.order_date,
      o1.net_sales,
      COUNT(o2.order_id) AS nb_orders_prior_12m
    FROM orders_2023 o1
    LEFT JOIN {{ ref('stg_orders') }} o2  -- toute la table, 2022 inclus
      ON
        o1.customer_id = o2.customer_id
        AND o2.order_date >= DATE_SUB(o1.order_date, INTERVAL 12 MONTH)
        AND o2.order_date < o1.order_date
    GROUP BY 1, 2, 3,4
  )
SELECT
  order_date,
  customer_id as client_id,
  order_id,
  net_sales,
  CASE
    WHEN nb_orders_prior_12m = 0 THEN 'New'
    WHEN nb_orders_prior_12m BETWEEN 1 AND 3 THEN 'Returning'
    ELSE 'VIP'
    END AS order_segmentation
FROM orders_prior
