SELECT * FROM dnrpa

SELECT DISTINCT automotor_marca_descripcion FROM dnrpa
SELECT DISTINCT automotor_modelo_codigo FROM dnrpa
SELECT tramite_tipo, count (tramite_tipo) as total FROM dnrpa
GROUP BY tramite_tipo
ORDER By total desc

SELECT  registro_seccional_provincia, count (registro_seccional_provincia) as total FROM dnrpa
GROUP BY registro_seccional_provincia
ORDER by TOTAL desc

SELECT  titular_genero, count (titular_genero) as total 
FROM dnrpa
where registro_seccional_provincia like 'Buenos Aires'
GROUP BY titular_genero
ORDER by TOTAL desc
