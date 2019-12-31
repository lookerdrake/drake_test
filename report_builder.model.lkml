connection: "snowlooker"

include: "*.view.lkml"                       # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: _rb_users {
  label: "Report Builder Explore"

  join: order_items {
    type: left_outer
    relationship: one_to_many
    sql_on: ${_rb_users.id} = ${order_items.user_id} ;;
  }
}
