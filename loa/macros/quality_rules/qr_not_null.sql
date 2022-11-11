{% macro qr_not_null(column) %}

    nullif({{column}},'') IS NOT NULL

{% endmacro %}
