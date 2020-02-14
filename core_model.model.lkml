connection: "parameterized_snowflake"

# include all the views
include: "Views/*.view"
include: "*.dashboard"
include: "*datagroups.view"
include: "accessgrants.view"



explore: always_filters {
  extension: required
  always_filter: {
    filters: {
      field: users.gender
      value: "Male"
    }
    filters: {
      field: users.state
      value: "Colorado"
    }
  }
}










explore: order_items {

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  #join: postings_with_access {
  #  type: inner
  #  sql_on:
  #  {% if _user_attributes['role'] == 'Admin' %}
  #    1 = 1
  #  {% else %}
  #  user_id = posting_id
  #  {% endif %};;
  #}

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
