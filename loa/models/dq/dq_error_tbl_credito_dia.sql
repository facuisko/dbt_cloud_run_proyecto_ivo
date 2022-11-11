{{ config(  materialized='incremental',schema='dq', alias='tbl_credito_dia_dq') }}


WITH regla_1 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_num_credito_fc' as dq_error_columnname,		
    'WARNING EXCLUDE' as dq_error_notification,		
    '1' as dq_error_code,	
    'El Numero de Operacion FC no esta informado o largo no valido' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where LENGTH(credit_num_credito_fc) = 0
    and periodo_dia='{{var("periodo")}}'

    ),

    regla_2 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_num_credito_alter' as dq_error_columnname,		
    'WARNING EXCLUDE' as dq_error_notification,		
    '2' as dq_error_code,	
    'El Numero Operación alternativo no esta informado' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where credit_num_credito_alter = ''
    and periodo_dia='{{var("periodo")}}'

    ),
    
    regla_3 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_num_rut_titular' as dq_error_columnname,		
    'WARNING EXCLUDE' as dq_error_notification,		
    '3' as dq_error_code,	
    'El rut titular no esta informado' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where nullif(credit_num_rut_titular,'') IS NULL
    and periodo_dia='{{var("periodo")}}'

    ),
   


    regla_4 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_fec_inicio_operacion' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '4' as dq_error_code,	
    'La categoría crédito no esta informada' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where nullif(credit_fec_inicio_operacion,'') IS NULL
    and periodo_dia='{{var("periodo")}}'

    ),

    regla_5 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_fec_inicio_operacion' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '5' as dq_error_code,	
    'La fecha de inicio de operación no es menor a la fecha de término de operación' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where safe_cast(credit_fec_fin_operacion as DATE format 'DD/MM/YYYY') <= safe_cast(credit_fec_inicio_operacion as DATE format 'DD/MM/YYYY')

    and periodo_dia='{{var("periodo")}}'

    ),

    regla_6 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_fec_fin_operacion' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '6' as dq_error_code,	
    'La Fecha de Término Operación no esta informada' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where nullif(credit_fec_fin_operacion,'') IS NULL
    and periodo_dia='{{var("periodo")}}'

    ),

    regla_7 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_fec_fin_operacion' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '7' as dq_error_code,	
    'La fecha de termino de operación no es mayor a la fecha de inicio de operación' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where safe_cast(credit_fec_fin_operacion as DATE format 'DD/MM/YYYY') <= safe_cast(credit_fec_inicio_operacion as DATE format 'DD/MM/YYYY')
    and periodo_dia='{{var("periodo")}}'

    ),


    regla_8 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_cod_mda_swf' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '8' as dq_error_code,	
    'El Tipo de Moneda no esta informado' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where credit_cod_mda_swf = ''
    and periodo_dia='{{var("periodo")}}'

    ),


    regla_9 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_mon_bruto_mnd_origen' as dq_error_columnname,		
    'WARNING EXCLUDE' as dq_error_notification,		
    '9' as dq_error_code,	
    'El Monto Bruto no esta informado' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where nullif(credit_mon_bruto_mnd_origen,'') IS NULL
    and periodo_dia='{{var("periodo")}}'

    ),

    regla_10 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_est_credito_fc' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '10' as dq_error_code,	
    'El Estado Operación no esta informado' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where credit_est_credito_fc = ''
    and periodo_dia='{{var("periodo")}}'

    ),


    regla_11 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_cod_categoria' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '11' as dq_error_code,	
    'La categoría crédito no esta informada' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where credit_cod_categoria = ''
    and periodo_dia='{{var("periodo")}}'

    ),

    regla_12 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_cod_categoria' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '12' as dq_error_code,	
    'La categoría crédito no esta entre los siguientes rangos: CRE, CRP, CRD, LOA, 007, 019, 006' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where credit_cod_categoria NOT IN ('CRE', 'CRP', 'CRD', 'LOA', '007', '019', '006')
    and periodo_dia='{{var("periodo")}}'

    ),

    regla_13 as(
    
    select 	
    MDM_fhNew as load_date,
    periodo_dia as data_date	,
    'credit_plazo_contable' as dq_error_columnname,		
    'WARNING' as dq_error_notification,		
    '13' as dq_error_code,	
    'El plazo contable no esta informado' as dq_error_descripcion,
    stage_table.*
    from {{source('transformation_stage','tbl_credito_dia')}} stage_table
    where nullif(credit_plazo_contable,'') IS NULL
    and periodo_dia='{{var("periodo")}}'

    ),

    regla_14 as (

        select 	
        MDM_fhNew as load_date,
        periodo_dia as data_date	,
        'credit_plazo_contable' as dq_error_columnname,		
        'WARNING' as dq_error_notification,		
        '14' as dq_error_code,	
        'El plazo contable no esta entre los siguientes rangos: 3 o 4' as dq_error_descripcion,
        stage_table.*
        from {{source('transformation_stage','tbl_credito_dia')}} stage_table
        where credit_plazo_contable NOT IN ('3', '4')
        and periodo_dia='{{var("periodo")}}' 
    ),
    
    regla_15 as (

        select 	
        MDM_fhNew as load_date,
        periodo_dia as data_date	,
        'credit_tipo_operacion_fc' as dq_error_columnname,		
        'WARNING' as dq_error_notification,		
        '15' as dq_error_code,	
        'El Tipo Operación esta no informado' as dq_error_descripcion,
        stage_table.*
        from {{source('transformation_stage','tbl_credito_dia')}} stage_table
        where nullif(credit_tipo_operacion_fc,'') IS NULL
        and periodo_dia='{{var("periodo")}}' 
    ),
    regla_16 as (

        select 	
        MDM_fhNew as load_date,
        periodo_dia as data_date	,
        'credit_num_cuota_pactada_cap' as dq_error_columnname,		
        'WARNING' as dq_error_notification,		
        '16' as dq_error_code,	
        'La Cantidad Cuotas Pactadas capital no esta informada' as dq_error_descripcion,
        stage_table.*
        from {{source('transformation_stage','tbl_credito_dia')}} stage_table
        where nullif(credit_num_cuota_pactada_cap,'') IS NULL
        and periodo_dia='{{var("periodo")}}' 
    ),
    regla_17 as (

        select 	
        MDM_fhNew as load_date,
        periodo_dia as data_date	,
        'credit_num_cuota_pactada_cap' as dq_error_columnname,		
        'WARNING' as dq_error_notification,		
        '17' as dq_error_code,	
        'La Cantidad Cuotas Pactadas capital no es mayor o igual 1' as dq_error_descripcion,
        stage_table.*
        from {{source('transformation_stage','tbl_credito_dia')}} stage_table
        where {{as_integer('credit_num_cuota_pactada_cap')}} < 1
        and periodo_dia='{{var("periodo")}}' 
    ),

    regla_18 as (

        select 	
        MDM_fhNew as load_date,
        periodo_dia as data_date	,
        'credit_mon_actual_mnd_origen' as dq_error_columnname,		
        'WARNING EXCLUDE' as dq_error_notification,		
        '18' as dq_error_code,	
        'El Saldo Actual Moneda Origen no esta informado' as dq_error_descripcion,
        stage_table.*
        from {{source('transformation_stage','tbl_credito_dia')}} stage_table
        where nullif(credit_mon_actual_mnd_origen,'') IS NULL
        and periodo_dia='{{var("periodo")}}' 
    ),

    regla_19 as (

        select 	
        MDM_fhNew as load_date,
        periodo_dia as data_date	,
        'credit_est_credito_cdr' as dq_error_columnname,		
        'WARNING' as dq_error_notification,		
        '19' as dq_error_code,	
        'El estado operación FC no esta informado' as dq_error_descripcion,
        stage_table.*
        from {{source('transformation_stage','tbl_credito_dia')}} stage_table
        where nullif(credit_est_credito_cdr,'') IS NULL
        and periodo_dia='{{var("periodo")}}' 
    )
    

select * from regla_1
union all
select * from regla_2 
union all
select * from regla_3
union all
select * from regla_4 
union all
select * from regla_5 
union all
select * from regla_6 
union all
select * from regla_7 
union all
select * from regla_8 
union all
select * from regla_9 
union all
select * from regla_10
union all
select * from regla_11
union all
select * from regla_12
union all
select * from regla_13
union all
select * from regla_14
union all
select * from regla_15
union all
select * from regla_16
union all
select * from regla_17
union all
select * from regla_18
union all
select * from regla_19


-- 1  val DQ_Credit_Num_Credito_Fc_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_credito_fc,"El Numero de Operacion FC no esta informado o largo no valido","LENGTH(credit_num_credito_fc) != 0",1,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_num_credito_fc;CRI=C1;REG=R1")

-- 2  val DQ_Credit_Num_Credito_Alter_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_credito_alter,"El Numero Operación alternativo no esta informado","credit_num_credito_alter <> ''",2,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_num_credito_alter;CRI=C1;REG=R1")

--3 val DQ_Credit_Num_Rut_Titular_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_rut_titular,"El rut titular no esta informado","credit_num_rut_titular IS NOT NULL",3,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_num_rut_titular;CRI=C1;REG=R1")

--4  val DQ_Credit_Fec_Inicio_Operacion_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_fec_inicio_operacion,"La Fecha de Inicio Operación no esta informada","credit_fec_inicio_operacion IS NOT NULL",4,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_inicio_operacion;CRI=C1;REG=R1")
--5  val DQ_Credit_Fec_Inicio_Operacion_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_fec_inicio_operacion,"La fecha de inicio de operación no es menor a la fecha de término de operación","credit_fec_inicio_operacion < credit_fec_fin_operacion",5,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_inicio_operacion;CRI=C1;REG=R1")


--6  val DQ_Credit_Fec_Fin_Operacion_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_fec_fin_operacion,"La Fecha de Término Operación no esta informada","credit_fec_fin_operacion IS NOT NULL",6,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_fin_operacion;CRI=C1;REG=R1")
--7  val DQ_Credit_Fec_Fin_Operacion_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_fec_fin_operacion,"La fecha de termino de operación no es mayor a la fecha de inicio de operación","credit_fec_fin_operacion > credit_fec_inicio_operacion",7,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_fin_operacion;CRI=C1;REG=R1")



--8 val DQ_Credit_Cod_Mda_Swf_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_cod_mda_swf,"El Tipo de Moneda no esta informado","credit_cod_mda_swf <> ''",8,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_cod_mda_swf;CRI=C1;REG=R1")
--9 val DQ_Credit_Mon_Bruto_Mnd_Origen_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_mon_bruto_mnd_origen,"El Monto Bruto no esta informado","credit_mon_bruto_mnd_origen IS NOT NULL",9,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_mon_bruto_mnd_origen;CRI=C1;REG=R1")
--10 val DQ_Credit_Est_Credito_Fc_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_est_credito_fc,"El Estado Operación no esta informado", "credit_est_credito_fc <> ''",10,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_est_credito_fc;CRI=C1;REG=R1")
-- 11 val DQ_Credit_Cod_Categoria_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_cod_categoria,"La categoría crédito no esta informada","credit_cod_categoria <> ''",11,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_cod_categoria;CRI=C1;REG=R1")
-- 12 val DQ_Credit_Cod_Categoria_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_cod_categoria, "La categoría crédito no esta entre los siguientes rangos: CRE, CRP, CRD, LOA, 007, 019, 006", "credit_cod_categoria IN ('CRE', 'CRP', 'CRD', 'LOA', '007', '019', '006')",12, huemulType_DQQueryLevel.Row, huemulType_DQNotification.WARNING,true, "COL=credit_cod_categoria;CRI=C5;REG=R1")
--13 val DQ_Credit_Plazo_Contable_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_plazo_contable,"El plazo contable no esta informado","credit_plazo_contable IS NOT NULL",13,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_plazo_contable;CRI=C1;REG=R1") 
-- 14 val DQ_Credit_Plazo_Contable_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_plazo_contable, "El plazo contable no esta entre los siguientes rangos 3 o 4", "credit_plazo_contable IN ('3', '4')",14, huemulType_DQQueryLevel.Row, huemulType_DQNotification.WARNING,true, "COL=credit_plazo_contable;CRI=C5;REG=R1")
-- 15 val DQ_Credit_Tipo_Operacion_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_tipo_operacion,"El Tipo Operación esta no informado","credit_tipo_operacion IS NOT NULL",15,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_tipo_operacion;CRI=C1;REG=R1")
-- 16 val DQ_Credit_Num_Cuota_Pactada_Cap_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_cuota_pactada_cap,"La Cantidad Cuotas Pactadas capital no esta informada","credit_num_cuota_pactada_cap IS NOT NULL",16,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_num_cuota_pactada_cap;CRI=C1;REG=R1")
-- 17 val DQ_Credit_Num_Cuota_Pactada_Cap_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_num_cuota_pactada_cap,"La Cantidad Cuotas Pactadas capital no es mayor o igual 1","credit_num_cuota_pactada_cap >= 1",17,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_num_cuota_pactada_cap;CRI=C1;REG=R1")
-- 18 val DQ_Credit_Mon_Actual_Mnd_Origen_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_mon_actual_mnd_origen,"El Saldo Actual Moneda Origen no esta informado","credit_mon_actual_mnd_origen IS NOT NULL",18,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_mon_actual_mnd_origen;CRI=C1;REG=R1")
-- 19 val DQ_Credit_Est_Credito_Cdr_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_est_credito_cdr,"El estado operación FC no esta informado","credit_est_credito_cdr IS NOT NULL",19,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_est_credito_cdr;CRI=C1;REG=R1")

--),

/*
  val DQ_Credit_Num_Credito_Fc_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_credito_fc,"El Numero de Operacion FC no esta informado o largo no valido","LENGTH(credit_num_credito_fc) != 0",1,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_num_credito_fc;CRI=C1;REG=R1")

  val DQ_Credit_Num_Credito_Alter_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_credito_alter,"El Numero Operación alternativo no esta informado","credit_num_credito_alter <> ''",2,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_num_credito_alter;CRI=C1;REG=R1")

  val DQ_Credit_Num_Rut_Titular_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_rut_titular,"El rut titular no esta informado","credit_num_rut_titular IS NOT NULL",3,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_num_rut_titular;CRI=C1;REG=R1")

  val DQ_Credit_Fec_Inicio_Operacion_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_fec_inicio_operacion,"La Fecha de Inicio Operación no esta informada","credit_fec_inicio_operacion IS NOT NULL",4,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_inicio_operacion;CRI=C1;REG=R1")
  val DQ_Credit_Fec_Inicio_Operacion_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_fec_inicio_operacion,"La fecha de inicio de operación no es menor a la fecha de término de operación","credit_fec_inicio_operacion < credit_fec_fin_operacion",5,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_inicio_operacion;CRI=C1;REG=R1")

  val DQ_Credit_Fec_Fin_Operacion_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_fec_fin_operacion,"La Fecha de Término Operación no esta informada","credit_fec_fin_operacion IS NOT NULL",6,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_fin_operacion;CRI=C1;REG=R1")
  val DQ_Credit_Fec_Fin_Operacion_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_fec_fin_operacion,"La fecha de termino de operación no es mayor a la fecha de inicio de operación","credit_fec_fin_operacion > credit_fec_inicio_operacion",7,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_fec_fin_operacion;CRI=C1;REG=R1")

  val DQ_Credit_Cod_Mda_Swf_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_cod_mda_swf,"El Tipo de Moneda no esta informado","credit_cod_mda_swf <> ''",8,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_cod_mda_swf;CRI=C1;REG=R1")

  val DQ_Credit_Mon_Bruto_Mnd_Origen_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_mon_bruto_mnd_origen,"El Monto Bruto no esta informado","credit_mon_bruto_mnd_origen IS NOT NULL",9,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_mon_bruto_mnd_origen;CRI=C1;REG=R1")

  val DQ_Credit_Est_Credito_Fc_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_est_credito_fc,"El Estado Operación no esta informado", "credit_est_credito_fc <> ''",10,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_est_credito_fc;CRI=C1;REG=R1")

  val DQ_Credit_Cod_Categoria_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_cod_categoria,"La categoría crédito no esta informada","credit_cod_categoria <> ''",11,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_cod_categoria;CRI=C1;REG=R1")
  val DQ_Credit_Cod_Categoria_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_cod_categoria, "La categoría crédito no esta entre los siguientes rangos: CRE, CRP, CRD, LOA, 007, 019, 006", "credit_cod_categoria IN ('CRE', 'CRP', 'CRD', 'LOA', '007', '019', '006')",12, huemulType_DQQueryLevel.Row, huemulType_DQNotification.WARNING,true, "COL=credit_cod_categoria;CRI=C5;REG=R1")

  val DQ_Credit_Plazo_Contable_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_plazo_contable,"El plazo contable no esta informado","credit_plazo_contable IS NOT NULL",13,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_plazo_contable;CRI=C1;REG=R1")
  val DQ_Credit_Plazo_Contable_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_plazo_contable, "El plazo contable no esta entre los siguientes rangos 3 o 4", "credit_plazo_contable IN ('3', '4')",14, huemulType_DQQueryLevel.Row, huemulType_DQNotification.WARNING,true, "COL=credit_plazo_contable;CRI=C5;REG=R1")

  val DQ_Credit_Tipo_Operacion_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_tipo_operacion,"El Tipo Operación esta no informado","credit_tipo_operacion IS NOT NULL",15,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_tipo_operacion;CRI=C1;REG=R1")

  val DQ_Credit_Num_Cuota_Pactada_Cap_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_num_cuota_pactada_cap,"La Cantidad Cuotas Pactadas capital no esta informada","credit_num_cuota_pactada_cap IS NOT NULL",16,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_num_cuota_pactada_cap;CRI=C1;REG=R1")
  val DQ_Credit_Num_Cuota_Pactada_Cap_NO_VALID_VALUE: huemul_DataQuality = new huemul_DataQuality(credit_num_cuota_pactada_cap,"La Cantidad Cuotas Pactadas capital no es mayor o igual 1","credit_num_cuota_pactada_cap >= 1",17,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_num_cuota_pactada_cap;CRI=C1;REG=R1")

  val DQ_Credit_Mon_Actual_Mnd_Origen_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_mon_actual_mnd_origen,"El Saldo Actual Moneda Origen no esta informado","credit_mon_actual_mnd_origen IS NOT NULL",18,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING_EXCLUDE,true,"COL=credit_mon_actual_mnd_origen;CRI=C1;REG=R1")

  val DQ_Credit_Est_Credito_Cdr_NO_VALID: huemul_DataQuality = new huemul_DataQuality(credit_est_credito_cdr,"El estado operación FC no esta informado","credit_est_credito_cdr IS NOT NULL",19,huemulType_DQQueryLevel.Row,huemulType_DQNotification.WARNING,true,"COL=credit_est_credito_cdr;CRI=C1;REG=R1")
  */
