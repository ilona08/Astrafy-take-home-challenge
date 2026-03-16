--table des commandes avec les quantités de ventes
SELECT *
FROM {{ ref('int_sales') }}
WHERE EXTRACT(year FROM order_date)=2023