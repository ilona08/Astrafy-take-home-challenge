view: sales_details {
  derived_table: {
    explore_source: orders_segmented {
      column: customer_id { field: sales.customer_id }
      column: count_distinct_orders { field: sales.count_distinct_orders }
      column: count_distinct_products { field: sales.count_distinct_product }
      column: total_qty { field: sales.total_qty }
      column: total_net_sales { field: sales.total_net_sales }
      derived_column: average_order_revenue {
        sql: SAFE_DIVIDE(total_net_sales, count_distinct_orders) ;;
      }
      derived_column: average_qty_per_order {
        sql: SAFE_DIVIDE(total_qty, count_distinct_orders) ;;
      }
    }
  }

  dimension: customer_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.customer_id ;;
  }

  dimension: count_distinct_orders {
    type: number
    sql: ${TABLE}.count_distinct_orders ;;
    description: "Nombre de commandes par client"
  }

  dimension: count_distinct_products {
    type: number
    sql: ${TABLE}.count_distinct_products ;;
    description: "Nombre de produits distincts par client"
  }

  dimension: total_qty {
    type: number
    sql: ${TABLE}.total_qty ;;
    description: "Quantité totale commandée par client"
  }

  dimension: total_net_sales {
    type: number
    sql: ${TABLE}.total_net_sales ;;
    value_format_name: decimal_2
    description: "CA net total par client"
  }

  dimension: average_order_revenue {
    type: number
    sql: ${TABLE}.average_order_revenue ;;
    value_format_name: decimal_2
    description: "Revenu moyen par commande du client"
  }

  dimension: average_qty_per_order {
    type: number
    sql: ${TABLE}.average_qty_per_order ;;
    value_format_name: decimal_1
    description: "Quantité moyenne de produits par commande du client"
  }
}
