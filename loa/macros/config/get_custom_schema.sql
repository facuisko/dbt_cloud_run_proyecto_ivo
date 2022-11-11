{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{- 'produccion_' ~ node.fqn[1] -}}

    {%- else -%}

        {{- 'produccion_' ~ node.fqn[1] -}}_{{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}