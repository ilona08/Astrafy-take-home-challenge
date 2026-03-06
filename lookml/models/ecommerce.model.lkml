connection: "bigquery_connection"

include: "/views/*.view.lkml"

explore: fct_orders_segmented {
  label: "Commandes 2023"
  description: "Analyse des commandes 2023 avec segmentation client"


  join: fct_sales {
    type: left_outer
    sql_on: ${fct_orders_segmented.order_id} = ${fct_sales.order_id} ;;
    relationship: one_to_many
  }
}