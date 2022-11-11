{{ config ( materialized='incremental',  
            alias='hub_credito',
            unique_key =['credit_num_credito_fc'],
            merge_update_columns = ['credit_num_credito_fc'],
            labels={'key': 'etiqueta_prueba'},
            schema='cpc')}} --,
            --on_schema_change='append_new_columns')}} --sync_all_columns --[['link_credito_partic','credit_num_credito_fc']

select

    distinct {{ attr_hub_credito() }}

from 
    
    {{ ref('clean_and_transformed') }}
