# Data Quality Checks

Requêtes exécutées dans BigQuery pour valider la qualité des données sources.

## 1. Doublons sur order_id dans orders

```sql
select order_id
from(
  select count(*) as nb, order_id
  from stg_orders
  group by 2)
where nb > 1
```

**Résultat : 0 doublon**

## 2. Doublons sur order_id + product_id dans sales

```sql
select *
from(
  select count(*) as nb, product_id, order_id
  from stg_sales
  group by 2, 3)
where nb > 1
```

**Résultat : 0 doublon**

## 3. Valeurs aberrantes

```sql
select min(net_sales), max(net_sales)
from stg_orders
```

**Résultat : min = 1.7747, max = 824.0119**

```sql
select min(qty), max(qty)
from stg_sales
```

**Résultat : min = 1, max = 50**

## 4. Plage de dates dans orders

```sql
select min(order_date), max(order_date)
from stg_orders
```

**Résultat : 2022-07-09 — 2023-12-31**

## 5. Plage de dates dans sales

```sql
select min(order_date), max(order_date)
from stg_sales
```

**Résultat : 2022-07-09 — 2023-12-31**

## 6. Commandes sans lignes de vente associées

```sql
select o.order_id
from stg_orders o
left join stg_sales s on o.order_id = s.order_id
where s.order_id is null
group by 1
```

**Résultat : 0 commande orpheline**
