{% macro as_numeric(column) %}

safe_cast(REPLACE({{column}},',','.') as NUMERIC)

{% endmacro %}