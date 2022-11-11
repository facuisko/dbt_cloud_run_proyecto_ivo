{% macro as_date(column, _format) %}

safe_cast({{column}} as DATE FORMAT "{{_format}}")

{% endmacro %}