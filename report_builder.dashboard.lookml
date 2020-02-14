- dashboard: report_builder
  title: Report Builder
  layout: newspaper
  elements:
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: " <b> <font size = \"7\"> Report Builder \n\nUse this to create any\
      \ report you'd like. It will be created in two formats:\n<li> A visualization\n\
      <li> A data table"
    row: 0
    col: 0
    width: 24
    height: 4
  - title: Report
    name: Report
    model: core_model
    explore: _rb_users
    type: looker_column
    fields: [_rb_users.dynamic_dimension, _rb_users.dynamic_measure, _rb_users.dynamic_pivot]
    pivots: [_rb_users.dynamic_pivot]
    filters:
      _rb_users.created_year: 1 years ago for 1 years
    sorts: [_rb_users.dynamic_pivot 0, _rb_users.dynamic_dimension]
    limit: 10
    column_limit: 5
    query_timezone: America/Los_Angeles
    color_application:
      collection_id: da8306b5-3b46-48aa-9ead-a3b32292f35c
      palette_id: 75905e81-dadc-472c-b9a2-a201f788d55d
      options:
        steps: 5
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    y_axes: [{label: '', orientation: left, series: [{axisId: _rb_users.dynamic_measure,
            id: UK - _rb_users.dynamic_measure, name: UK}, {axisId: _rb_users.dynamic_measure,
            id: USA - _rb_users.dynamic_measure, name: USA}], showLabels: true, showValues: true,
        unpinAxis: true, tickDensity: default, tickDensityCustom: 5, type: linear}]
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    label_value_format: '0.00'
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#808080"
    listen:
      Pivot: _rb_users.pivot_selector
      Dimension: _rb_users.dimension_selector
      Calculation: _rb_users.measure_selector
    row: 4
    col: 0
    width: 24
    height: 12
  filters:
  - name: Pivot
    title: Pivot
    type: field_filter
    default_value: gender
    allow_multiple_values: true
    required: false
    model: core_model
    explore: _rb_users
    listens_to_filters: []
    field: _rb_users.pivot_selector
  - name: Dimension
    title: Dimension
    type: field_filter
    default_value: age^_group
    allow_multiple_values: true
    required: false
    model: core_model
    explore: _rb_users
    listens_to_filters: []
    field: _rb_users.dimension_selector
  - name: Calculation
    title: Calculation
    type: field_filter
    default_value: avg^_age
    allow_multiple_values: true
    required: false
    model: core_model
    explore: _rb_users
    listens_to_filters: []
    field: _rb_users.measure_selector
