{% macro as_integer(column) %}

safe_cast({{column}} AS INTEGER)

{% endmacro %}