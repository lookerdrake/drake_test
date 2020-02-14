view: users {
  sql_table_name: {{ _user_attributes['user_database'] }}.public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    label: "@{age_label}"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_group {
    type: tier
    style: integer
    tiers: [13, 21, 30, 60]
    sql: ${age} ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: '{{ _user_attributes['user_database'] }}' ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_num,
      quarter,
      year
    ]
    sql: TO_DATE(${TABLE}."Created Date") ;;
  }


  measure: distinct_count {
    type: count_distinct
    sql: ${id} ;;
  }



  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: drill_by_state {
    hidden: yes
    type: sum
    sql: 1 ;;
    drill_fields: [state, gender, count]
  }


  measure: count {
    value_format_name: decimal_0
    type: count


    drill_fields: [zip, gender, count]
    link: {
      label: "Drill with filters"
      url: "{{link}}&f['users.country']={{ _filters['users.country'] }}"
    }
    link: {
      label: "1. Drill with good looks"
      url: "/looks/13"
    }
    link: {
      label: "Drill by Zipcode"
      url: "
      {{link}}&pivots=users.gender&f[users.country]=USA&sorts=users.count+desc+0,users.gender&limit=10&vis=%7B%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22normal%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22series_types%22%3A%7B%7D%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Atrue%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%7D&filter_config=%7B%22users.country%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22USA%22%7D%2C%7B%7D%5D%2C%22id%22%3A0%2C%22error%22%3Afalse%7D%5D%7D&origin=share-expanded
      "
    }
    link: {
      label: "Drill by State"
      url: "
      {{ drill_by_state._link }}&pivots=users.gender&sorts=users.count+desc+0,users.gender&limit=10&column_limit=50&vis=%7B%22color_application%22%3A%7B%22collection_id%22%3A%22d754397b-2c05-4470-bbbb-05eb4c2b15cd%22%2C%22palette_id%22%3A%22b0768e0d-03b8-4c12-9e30-9ada6affc357%22%2C%22options%22%3A%7B%22steps%22%3A5%7D%7D%2C%22x_axis_gridlines%22%3Afalse%2C%22y_axis_gridlines%22%3Atrue%2C%22show_view_names%22%3Afalse%2C%22show_y_axis_labels%22%3Atrue%2C%22show_y_axis_ticks%22%3Atrue%2C%22y_axis_tick_density%22%3A%22default%22%2C%22y_axis_tick_density_custom%22%3A5%2C%22show_x_axis_label%22%3Atrue%2C%22show_x_axis_ticks%22%3Atrue%2C%22y_axis_scale_mode%22%3A%22linear%22%2C%22x_axis_reversed%22%3Afalse%2C%22y_axis_reversed%22%3Afalse%2C%22plot_size_by_field%22%3Afalse%2C%22trellis%22%3A%22%22%2C%22stacking%22%3A%22normal%22%2C%22limit_displayed_rows%22%3Afalse%2C%22legend_position%22%3A%22center%22%2C%22point_style%22%3A%22none%22%2C%22show_value_labels%22%3Atrue%2C%22label_density%22%3A25%2C%22x_axis_scale%22%3A%22auto%22%2C%22y_axis_combined%22%3Atrue%2C%22ordering%22%3A%22none%22%2C%22show_null_labels%22%3Afalse%2C%22show_totals_labels%22%3Atrue%2C%22show_silhouette%22%3Afalse%2C%22totals_color%22%3A%22%23808080%22%2C%22type%22%3A%22looker_column%22%7D&filter_config=%7B%7D&origin=share-expanded
      "
    }


  }

  measure: summary_count {
    type: sum
    sql:  1 ;;
    html:
    <div style="width:100%"> <details>
    <summary style="outline:none">{{ count._rendered_value }}
    </summary><font color=”black"> Avg. Age: <strong>{{ avg_age._rendered_value }}</strong> </font>
    <br/>
    <font color=”black">Max Age: <strong>{{ max_age._rendered_value }}</strong>  </font>
    </details>
    </div>




  ;;
  }

  measure: max_age {
    type: max
    value_format_name: decimal_0
    sql: concat('$',${age}) ;;
    html: "test tooltip" ;;
  }

  parameter: goal {
    type: number
    default_value: "1200"
  }

  filter: meets_state_filter {
    type: string
  }

  dimension: meets_state {
    type: yesno
    sql: {% condition meets_state_filter %} ${state} {% endcondition %} ;;
  }

  measure: pct_attainment {
    type: number
    value_format_name: percent_0
    sql: 1.0*${count} / {% parameter goal %} ;;
  }

   measure: avg_age {
     value_format_name: decimal_2
     type: average
     sql: ${age} ;;
   }
 }
