project_name: "snowflake"

constant: connection {
  value: "{{ _user_attributes['database'] }} "
}

constant: age_label {
  value: "
      {% if _user_attributes['user_instance'] == 'Emory' %}
        Emory
      {% elsif _user_attributes['user_instance'] == 'Fairview' %}
        Fairview Health
      {% elsif _user_attributes['user_instance'] == 'Mercynet' %}
        Mercy Net
      {% elsif _user_attributes['user_instance'] == 'Honor Health' %}
        Honor Health
      {% elsif _user_attributes['user_instance'] == 'Marshfield' %}
        Marshfield Health
      {% elsif _user_attributes['user_instance'] == 'NYP' %}
        NYP
      {% elsif _user_attributes['user_instance'] == 'PHS' %}
        PHS
      {% elsif _user_attributes['user_instance'] == 'SCL' %}
        SCL
      {% elsif _user_attributes['user_instance'] == 'Wellspan' %}
        Wellspan Health
      {% elsif _user_attributes['user_instance'] == 'Stanford' %}
        Stanford Health
      {% elsif _user_attributes['user_instance'] == 'Sick kids' %}
        Sick Kids
      {% elsif _user_attributes['user_instance'] == 'Dignity Health' %}
        Dignity Health
      {% elsif _user_attributes['user_instance'] == 'Sutter Health' %}
        Sutter Health
      {% elsif _user_attributes['user_instance'] == 'Natividad' %}
        Natividad Health
      {% else %}
        Age
      {% endif %}"
}

constant: emory_age {
  value: "Label: Emory"
}

constant: fairview_age {
  value: "'{{ _user_attributes['user_instance'] }}'"
}

constant: mercynet_age {
  value: "Label: Mercynet"
}

constant: honorhealth_age {
  value: "Label: Honor Health"
}

constant: marshfield_age {
  value: "Label: MarshField"
}

constant: scl_age {
  value: "Label: SCL"
}

constant: nyp_age {
  value: "Label: NYP"
}

constant: phs_age {
  value: "Label: PHS"
}

constant: wellspan_age {
  value: "Label: Wellspan"
}

constant: stanford_age {
  value: "Label: Stanford"
}

constant: sickkids_age {
  value: "Label: Sickkids"
}

constant: dignity_age {
  value: "Label: Dignity"
}

constant: sutter_age {
  value: "Label: Sutter"
}

constant: natividad_age {
  value: "Label: Natividad"
}


constant: dynamic_dimension {
  value: "
  {% if dimension_selector._parameter_value == 'week' %}
          ${created_week}
        {% elsif dimension_selector._parameter_value == 'month' %}
          ${created_month}
        {% elsif dimension_selector._parameter_value == 'quarter' %}
          ${created_quarter}
        {% elsif dimension_selector._parameter_value == 'gender' %}
          ${gender}
        {% elsif dimension_selector._parameter_value == 'age_group' %}
          ${age_group}
        {% elsif dimension_selector._parameter_value == 'country' %}
          ${country}
        {% else %}
          ${created_quarter}
        {% endif %}"
}

constant: dynamic_pivot {
  value: "
  {% if pivot_selector._parameter_value == 'week' %}
          ${created_week}
        {% elsif pivot_selector._parameter_value == 'month' %}
          ${created_month}
        {% elsif pivot_selector._parameter_value == 'quarter' %}
          ${created_quarter}
        {% elsif pivot_selector._parameter_value == 'gender' %}
          ${gender}
        {% elsif pivot_selector._parameter_value == 'age_group' %}
          ${age_group}
        {% elsif pivot_selector._parameter_value == 'country' %}
          ${country}

        {% else %}
          ${created_quarter}
        {% endif %}"
}

application: ef_lab {
  label: "Hello, World!"
  # file: "exercise1_wo_chatty.js"
  # file: "exercise1_with_chatty.js"
  url: "http://localhost:8080/bundle.js"
}

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
