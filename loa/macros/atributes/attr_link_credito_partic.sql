{% macro attr_link_credito_partic() %}

    credit_num_credito_fc,
    credit_num_rut_titular AS partic_num_rut,
    'LOA' AS sistema_origen,
    periodo_dia AS link_fec_ingreso,
    --id_registro_stage,	
    '{{ run_started_at}}' as MDM_fhNew,
    MDM_ProcessNew

{% endmacro %}
