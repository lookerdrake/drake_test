connection: "parameterized_snowflake"

# include all the views
include: "Views/*.view"

datagroup: drake_test_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: drake_test_project_default_datagroup



explore: order_items {
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_facts_table {
    type: left_outer
    sql_on:  ${users.id} = ${user_facts_table.user_id} ;;
    relationship:  one_to_one
  }


}

explore: users {
  }

explore: _rb_users {
  sql_always_where: ${id} > 0 ;;
  hidden: yes
  label: "Report Builder Explore"

  join: order_items {
    type: left_outer
    relationship: one_to_many
    sql_on: ${_rb_users.id} = ${order_items.user_id} ;;
  }
}
