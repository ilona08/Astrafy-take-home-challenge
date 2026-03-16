-- =========================================
-- DATA QUALITY CHECKS
-- =========================================

-- 1. Doublons sur order_id dans orders
select order_id
from(
  select count(*) as nb, order_id
from {{ ref('stg_orders') }}
group by 2)
where nb > 1

-- résultats : 0


-- 2. Doublons sur order_id + product_id dans sales
select *
from(
  select count(*) as nb, product_id,order_id
from {{ ref('stg_sales') }}
group by 2,3)
where nb > 1

-- résultats : 0


-- 3. Vérifier l'absence de valeur aberrantes
select min(net_sales),max(net_sales)
from {{ ref('stg_orders') }}

-- résultats : "f0_": "1.7747","f1_": "824.0119"


select min(qty),max(qty)
from {{ ref('stg_sales') }}

-- résultats : "f0_": "1","f1_": "50"


-- 4. Vérifier la plage de dates dans orders
select min(order_date),max(order_date)
from {{ ref('stg_orders') }}

-- résultats : "f0_": "2022-07-09","f1_": "2023-12-31"


-- 5. Vérifier la plage de dates dans sales
select min(order_date),max(order_date)
from {{ ref('stg_sales') }}

-- résultats : "f0_": "2022-07-09","f1_": "2023-12-31"


-- 6. Commandes sans lignes de vente associées
select o.order_id
from {{ ref('stg_orders') }} o
left join {{ ref('stg_sales') }} s on o.order_id=s.order_id
where s.order_id is null
group by 1

-- résultats : 0