view: fct_sales {
  sql_table_name: `my-project-ilona.dbt_astrafy_marts.fct_sales` ;;

  dimension: order_id {
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: product_id {
    type: string
    sql: ${TABLE}.product_id ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension_group: order {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.order_date ;;
  }

  measure: total_net_sales {
    type: sum
    sql: ${TABLE}.net_sales ;;
    value_format_name: decimal_2
    description: "Chiffre d'affaires net total"
  }

  measure: total_qty {
    type: sum
    sql: ${TABLE}.qty ;;
    description: "Quantité totale de produits vendus"
  }

  measure: avg_qty_per_order {
    type: average
    sql: ${TABLE}.qty ;;
    value_format_name: decimal_1
    description: "Quantité moyenne par commande"
  }
}
