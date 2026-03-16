view: sales_details {
  derived_table: {
    sql:
      SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS count_distinct_orders,
        COUNT(DISTINCT product_id) AS count_distinct_products,
        SUM(qty) AS total_qty,
        SUM(net_sales) AS total_net_sales,
        SAFE_DIVIDE(SUM(net_sales), COUNT(DISTINCT order_id)) AS average_order_revenue,
        SAFE_DIVIDE(SUM(qty), COUNT(DISTINCT order_id)) AS average_qty_per_order
      FROM `my-project-ilona.dbt_astrafy_marts.fct_sales`
      GROUP BY customer_id
    ;;
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
