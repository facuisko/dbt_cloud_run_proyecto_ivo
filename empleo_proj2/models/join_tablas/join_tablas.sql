{{config(materialized='table') }}


select
p.fecha as Fecha,
p.codigo_departamento_indec as CodDepto,
p.clae2 as Clae,
p.puestos as Jobs,
s.w_mean as Wages,
p.puestos * s.w_mean as WagesAmount
from prueba_1.puestos as p inner join prueba_1.salarios as s
on p.fecha = s.fecha 
and p.codigo_departamento_indec = s.codigo_departamento_indec
and p.clae2 = s.clae2


