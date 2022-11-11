--Tipo de Tabla

{{ config ( materialized='incremental',  
            alias='link_credito_partic',
            unique_key =['credit_num_credito_fc','partic_num_rut'],
            merge_update_columns =['credit_num_credito_fc','partic_num_rut'],
            schema='cpc')}} --,
           -- on_schema_change='append_new_columns')}} 


select 

    distinct {{attr_link_credito_partic()}}

from 

    {{ ref('clean_and_transformed') }}