view: sales {
  sql_table_name: `@{gcp_project}.dbt_astrafy_marts.fct_sales` ;;

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: order_date {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.order_date ;;
  }

  dimension: net_sales {
    type: number
    sql: ${TABLE}.net_sales ;;
  }

  measure: total_net_sales {
    type: sum
    sql: ${TABLE}.net_sales ;;
    value_format_name: decimal_2
    description: "Chiffre d'affaires net total"
  }

  measure: total_qty {
    type: sum
    sql: ${TABLE}.qty  ;;
    description: "Quantité totale de produits vendus par commande"
  }

  measure: count_distinct_orders {
    type: count_distinct
    sql: ${TABLE}.order_id ;;
    drill_fields: [order_id, customer_id, product_id, order_date]
    description: "Nombre de commande distinct"
  }

  measure: count_distinct_product {
    type: count_distinct
    sql: ${TABLE}.product_id ;;
    drill_fields: [order_id, customer_id, product_id, order_date]
    description: "Nombre de produits distinct"
  }

  measure: avg_qty_per_order {
  type: average
  sql: ${TABLE}.qty ;;
  value_format_name: decimal_1
  description: "Quantité moyenne de produit par commande"
  }
}
