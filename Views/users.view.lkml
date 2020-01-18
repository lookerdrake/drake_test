view: users {
  sql_table_name:{{ _user_attributes['user_database'] }}.public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
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
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: TO_DATE(${TABLE}."Created Date") ;;
  }


  measure: distinct_count {
    type: count_distinct
    sql: ${id} ;;
  }

  parameter: start_date {
    type: date
    label: "Start Date"
    description: "Use this for the custom filter things"
  }

  parameter: end_date {
    type: date
  }

  dimension: meets_date_filter {
    type: yesno
    hidden: no
    sql: ${created_date} >= {% parameter start_date %} AND ${created_date} < {% parameter end_date %}
    ;;
  }

  # choose the filters
  measure: custom_timeframe_count {
    type: count_distinct
    group_label: "Custom Filter Measures"
    sql: ${id} ;;
    filters: {
      field: meets_date_filter
      value: "Yes"
    }
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

  measure: count {
    value_format_name: decimal_0
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
  }

  measure: avg_age {
    value_format_name: decimal_2
    type: average
    sql: ${age} ;;
  }
}

## Creating a derived table in order to create new dimensions about the user.
## This is particularly useful when you need an aggregate function, such as finding
## the date when a user first ordered an item.
## We'll use the User ID as the primary key to join to the users table
view: user_facts_table {
  derived_table: {
    sql:
    SELECT
      u.id as user_id,
      u.created_at as user_createdAt,

      CASE
        WHEN MIN(oi.created_at) is NOT NULL THEN TRUE
        ELSE FALSE
      END as has_user_ordered,

      MIN(oi.created_at) as first_order,
      DATEDIFF(day, DATE(u.created_at), MIN(DATE(oi.created_at))) days_to_first_order,

      CASE
        WHEN DATEDIFF(day, DATE(u.created_at), MIN(DATE(oi.created_at))) <= 30 THEN TRUE
        ELSE FALSE
      END as ordered_within_30

      FROM users as u
      LEFT JOIN order_items as oi ON(u.id = oi.user_id)
      GROUP BY 1,2
      ;;
    }

    dimension: user_id {
      type:  string
      primary_key: yes
      sql:  ${TABLE}.user_id ;;
    }

    dimension_group: user_creation {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql: ${TABLE}.user_createdAt ;;
    }

    dimension_group: user_first_order {
      type: time
      timeframes: [
        raw,
        time,
        date,
        week,
        month,
        quarter,
        year
      ]
      sql:  ${TABLE}.first_order ;;
    }

    dimension: user_days_to_first_order {
      type: number
      sql:  ${TABLE}.days_to_first_order ;;
    }

    dimension: user_ordered_within_30 {
      type: yesno
      sql:  ${TABLE}.ordered_within_30 ;;
      }

    measure: user_count {
      type:  count
    }

    measure: users_ordering_within_30_days {
      type:  sum
      drill_fields: [user_id, user_days_to_first_order]
      sql:
      CASE
        WHEN ${TABLE}.has_user_ordered is TRUE
          AND ${TABLE}.ordered_within_30 is TRUE
          THEN 1
        ELSE 0 END;;
    }

    measure: users_not_ordering_within_30_days {
      type:  sum
      sql:  CASE WHEN ${TABLE}.ordered_within_30 is FALSE THEN 1 ELSE 0 END ;;
    }

  }
