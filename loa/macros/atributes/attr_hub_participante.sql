{% macro attr_hub_participante() %}
    
    credit_num_rut_titular  AS partic_num_rut,
    sistema_origen,
    '{{ run_started_at}}' as MDM_fhNew,
    MDM_ProcessNew

{% endmacro %}