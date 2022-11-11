{% macro attr_sat_credito_dia() %}

    credit_num_credito_fc,		
    credit_num_credito_alter,		
    credit_num_rut_titular,			
    credit_dv_rut_titular,		
    credit_tipo_operacion,		
    credit_plazo_contable, 		
    credit_clase_credito, 		
    credit_cod_categoria,		
    credit_est_credito_cdr,	
    credit_est_credito_fc,		
    credit_cod_mda_swf,		
    credit_fec_inicio_operacion,		
    credit_fec_fin_operacion,
    credit_mon_bruto_mnd_origen, 		
    credit_num_cuota_pactada_cap,		
    credit_num_cuota_pactada_inter,			
    credit_mon_cuota_cap_xvencer, --ellos lo dejan en NULL 	
    credit_mon_cuota_inter_xvencer, --ellos lo dejan en NULL 		
    credit_mon_actual_mnd_origen, 	
    credit_mon_valor_cuota,
    sistema_origen,			
    credit_fec_actualizacion,
    --id_registro_stage,
    '{{ run_started_at}}' as MDM_fhNew,
    MDM_ProcessNew,
    periodo_dia
    
{% endmacro %}
