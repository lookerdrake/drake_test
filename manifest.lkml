project_name: "snowflake"

constant: connection {
  value: "{{ _user_attributes['database'] }} "
}

# # Use local_dependency: To enable referencing of another project
# # on this instance with include: statements
#
# local_dependency: {
#   project: "name_of_other_project"
# }
