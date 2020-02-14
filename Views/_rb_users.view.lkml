include: "users.view"

view: _rb_users {
  label: "Dynamic Report Builder"
  extends: [users]

  ## parameters for dynamic-ness
  parameter: dimension_selector {
    label: "Group By"
    type: unquoted
    default_value: "Quarter"

    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Quarter"
      value: "quarter"
    }
    allowed_value: {
      label: "Gender"
      value: "gender"
    }
    allowed_value: {
      label: "Age Group"
      value: "age_group"
    }
    allowed_value: {
      label: "Country"
      value: "country"
    }

  }

  parameter: pivot_selector {
    label: "Pivot Selector"
    type: unquoted
    default_value: "Quarter"


    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Quarter"
      value: "quarter"
    }
    allowed_value: {
      label: "Gender"
      value: "gender"
    }
    allowed_value: {
      label: "Age Group"
      value: "age_group"
    }
    allowed_value: {
      label: "Country"
      value: "country"
    }

  }



  parameter: measure_selector {
    label: "Calculation"
    type: unquoted

    default_value: "tot_revenue"
    allowed_value: {
      label: "Number of Users"
      value: "num_users"
    }
    allowed_value: {
      label: "Avg. User Age"
      value: "avg_age"
    }
    allowed_value: {
      label: "Total Revenue"
      value: "tot_revenue"
    }
    allowed_value: {
      label: "Avg. Sale Price"
      value: "avg_sale_price"
    }
    allowed_value: {
      label: "Number of Orders"
      value: "num_orders"
    }
  }

  dimension: dynamic_dimension {
    label_from_parameter: dimension_selector
    sql: @{dynamic_dimension};;
  }

  dimension: dynamic_pivot {
    label_from_parameter: pivot_selector
    sql: @{dynamic_pivot} ;;
  }

  measure: dynamic_measure {
    label_from_parameter: measure_selector
    type: number
    sql:
        {% if measure_selector._parameter_value == 'num_users' %}
          ${count}
        {% elsif measure_selector._parameter_value == 'avg_age' %}
          ${avg_age}
        {% elsif measure_selector._parameter_value == 'tot_revenue' %}
          ${order_items.total_revenue}
        {% elsif measure_selector._parameter_value == 'avg_sale_price' %}
          ${order_items.avg_sale_price}
        {% elsif measure_selector._parameter_value == 'num_orders' %}
          ${order_items.count}
        {% else %}
          ${order_items.total_revenue}
        {% endif %}
    ;;
    html:
        {% if measure_selector._parameter_value == 'num_users' %}
          {{count._rendered_value }}
        {% elsif measure_selector._parameter_value == 'avg_age' %}
          {{avg_age._rendered_value }}
        {% elsif measure_selector._parameter_value == 'tot_revenue' %}
           {{order_items.total_revenue._rendered_value }}
        {% elsif measure_selector._parameter_value == 'avg_sale_price' %}
           {{order_items.avg_sale_price._rendered_value }}
        {% elsif measure_selector._parameter_value == 'num_orders' %}
           {{order_items.count._rendered_value }}
        {% else %}
          {{order_items.total_revenue._rendered_value }}
        {% endif %};;
  }


  parameter: measure_1 {
    type: unquoted
  }

  parameter: operator_1 {
    type: number
  }

  measure: custom_measure_1 {
    type: number
    sql:
    {% if measure_1._parameter_value == 'count' %}
      ${count}
    {% else %}
      ${avg_age}
    {% endif %}

     - {% parameter operator_1 %} ;;










  }










}
