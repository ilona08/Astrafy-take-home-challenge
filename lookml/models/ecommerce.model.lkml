connection: "bigquery_connection"

include: "/views/*.view.lkml"

datagroup: training_ecommerce_default_datagroup {
  sql_trigger: SELECT MAX(order_id) FROM `@{gcp_project}.dbt_astrafy_marts.fct_sales`;;
  max_cache_age: "1 month"
}

persist_with: training_ecommerce_default_datagroup
# sert en autre pour rendre les vues définitives, ici le résultat est stocké un mois pour toutes les vues


explore: orders_segmented {
  label: "Commandes 2023"
  description: "Analyse des commandes 2023 avec segmentation client"


  join: sales {
    type: left_outer
    sql_on: ${orders_segmented.order_id} = ${sales.order_id} ;;
    relationship: one_to_many
  }

  join: sales_details {
    type: left_outer
    sql_on: ${orders_segmented.customer_id} = ${sales_details.customer_id} ;;
    relationship: many_to_one
  }
}
