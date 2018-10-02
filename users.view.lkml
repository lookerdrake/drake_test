view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
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
    sql: ${TABLE}.created_at ;;
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
    type: count
    drill_fields: [id, first_name, last_name, events.count, order_items.count]
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
      END as ordered_within_30_days

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
