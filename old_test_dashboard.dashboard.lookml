- dashboard: old_test_dashboard
  title: old_test_dashboard
  layout: newspaper
  elements:
  - title: test sort
    name: test sort
    model: core_model
    explore: users
    type: looker_column
    fields: [users.age_tiers_sql, users.count, users.gender]
    pivots: [users.gender]
    filters:
      users.gender: f
    sorts: [users.gender 0, users.age_tiers_sql]
    limit: 500
    query_timezone: America/Los_Angeles
    row: 0
    col: 0
    width: 8
    height: 6
  - title: New Tile
    name: New Tile
    model: core_model
    explore: users
    type: looker_column
    fields: [users.age_tiers_sql, users.count, users.gender]
    pivots: [users.gender]
    sorts: [users.gender 0, users.age_tiers_sql]
    limit: 500
    query_timezone: America/Los_Angeles
    row: 0
    col: 8
    width: 8
    height: 6
  - title: sort all
    name: sort all
    model: core_model
    explore: users
    type: looker_column
    fields: [users.age_tiers_sql, users.count, users.gender]
    pivots: [users.gender]
    sorts: [users.gender desc 0, users.age_tiers_sql, users.count desc 0]
    limit: 500
    query_timezone: America/Los_Angeles
    row: 0
    col: 16
    width: 8
    height: 6
  - title: table_Calc
    name: table_Calc
    model: core_model
    explore: users
    type: looker_column
    fields: [users.age_tiers_sql, users.count, users.gender]
    pivots: [users.gender]
    sorts: [users.gender desc 0, users.age_tiers_sql, users.count desc 0]
    limit: 500
    dynamic_fields: [{table_calculation: hacky_count, label: Hacky Count, expression: "${users.count}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}]
    query_timezone: America/Los_Angeles
    hidden_fields: [users.count]
    row: 6
    col: 0
    width: 8
    height: 6
