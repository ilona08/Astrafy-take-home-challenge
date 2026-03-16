view: orders_segmented {
  sql_table_name: `@{gcp_project}.dbt_astrafy_marts.fct_orders_segmented` ;;

  dimension: order_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.order_id ;;
  }

  dimension: customer_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }

  dimension_group: order_date {
    type: time
    timeframes: [date, week, month, quarter, year]
    sql: ${TABLE}.order_date ;;
  }

  dimension: order_segmentation {
    type: string
    sql: ${TABLE}.order_segmentation ;;
    description: "New / Returning / VIP"
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

  measure: count_orders {
    type: count
    drill_fields: [order_id, customer_id, order_date]
    description: "Nombre de commandes"
  }

  measure: count_customers {
    type: count_distinct
    sql: ${customer_id} ;;
    description: "Nombre de clients uniques"
  }
}
