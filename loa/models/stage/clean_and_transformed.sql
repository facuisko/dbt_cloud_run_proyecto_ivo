    {{ config(  materialized='ephemeral', alias='clean_and_transformed') }}
    
    
    select 
    {{as_numeric("credit_num_credito_fc")}} as credit_num_credito_fc,
    credit_num_credito_alter,			
    {{as_integer('credit_num_rut_titular')}} as credit_num_rut_titular,		
    credit_dv_rut_titular,		
    {{as_integer('credit_tipo_operacion_fc')}} as credit_tipo_operacion,				
    {{as_integer('credit_plazo_contable')}} as credit_plazo_contable,	 
    {{as_integer('credit_clase_credito')}} as credit_clase_credito,	
    credit_cod_categoria,			
    {{as_integer('credit_est_credito_cdr')}} as credit_est_credito_cdr,	
    credit_est_credito_fc,		
    credit_cod_mda_swf,		
    {{as_date('credit_fec_inicio_operacion','DD/MM/YYYY')}} as credit_fec_inicio_operacion,		
    {{as_date('credit_fec_fin_operacion','DD/MM/YYYY')}} as credit_fec_fin_operacion,		
    {{as_numeric('credit_mon_bruto_mnd_origen')}} as credit_mon_bruto_mnd_origen,	
    {{as_integer('credit_num_cuota_pactada_cap')}} as credit_num_cuota_pactada_cap,				
    {{as_integer('credit_num_cuota_pactada_inter')}} as credit_num_cuota_pactada_inter,
    {{as_numeric('credit_mon_cuota_cap_xvencer')}} as credit_mon_cuota_cap_xvencer,
    {{as_numeric('credit_mon_cuota_inter_xvencer')}} as credit_mon_cuota_inter_xvencer, 	
    {{as_numeric('credit_mon_actual_mnd_origen')}} as credit_mon_actual_mnd_origen,
    {{as_numeric('credit_mon_cuota_cap_xvencer')}} +
    {{as_numeric('credit_mon_cuota_inter_xvencer')}} as credit_mon_valor_cuota,
    'LOA' as sistema_origen,
    MDM_hash as id_registro_stage,			
    MDM_fhNew as credit_fec_actualizacion,
    '{{ run_started_at}}' as MDM_fhNew,
    'dbt_cpc_tbl_credito_dia' as MDM_ProcessNew,
    periodo_dia	

    from {{source('transformation_stage','tbl_credito_dia')}}  --source stage

    where periodo_dia='{{var("periodo")}}'              --partition load
    
    and {{qr_not_null('credit_num_credito_fc') }}             --Warning exclude
    and {{qr_not_null('credit_num_rut_titular')  }}           --Warning exclude
    and {{qr_not_null('credit_mon_bruto_mnd_origen')}}        --Warning exclude
    and {{qr_not_null('credit_mon_actual_mnd_origen') }}      --Warning exclude
    and {{qr_not_null('credit_num_credito_alter') }}          --Warning exclude
