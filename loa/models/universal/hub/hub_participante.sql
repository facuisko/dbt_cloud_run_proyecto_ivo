
--Tipo de Tabla

{{ config ( materialized='incremental',  
            alias='hub_participante',
            unique_key =['partic_num_rut'],
            merge_update_columns = ['partic_num_rut'])}} --,
            -- on_schema_change='append_new_columns')}} 

-- Carga

select

    distinct {{ attr_hub_participante() }}
   
from 
    
     {{ ref('clean_and_transformed') }}
 
 