-- Vehicle theft in Argentina, 2022-2023
-- Portfolio version of the original SQLite analysis.
-- Assumes a table named dnrpa.

SELECT COUNT(*) AS total_records FROM dnrpa;

SELECT Año_Robo AS year, COUNT(*) AS records
FROM dnrpa
GROUP BY Año_Robo
ORDER BY year;

SELECT registro_seccional_provincia AS province, COUNT(*) AS records
FROM dnrpa
GROUP BY registro_seccional_provincia
ORDER BY records DESC
LIMIT 10;

SELECT automotor_marca_limpio AS make, COUNT(*) AS records
FROM dnrpa
WHERE automotor_marca_limpio IS NOT NULL AND TRIM(automotor_marca_limpio) <> ''
GROUP BY automotor_marca_limpio
ORDER BY records DESC
LIMIT 15;

SELECT marca_modelo_limpio AS make_model, COUNT(*) AS records
FROM dnrpa
WHERE marca_modelo_limpio IS NOT NULL AND TRIM(marca_modelo_limpio) <> ''
GROUP BY marca_modelo_limpio
ORDER BY records DESC
LIMIT 15;

SELECT titular_genero AS holder_gender, COUNT(*) AS records,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct
FROM dnrpa
GROUP BY titular_genero
ORDER BY records DESC;

SELECT automotor_origen AS vehicle_origin, titular_genero AS holder_gender, COUNT(*) AS records
FROM dnrpa
GROUP BY automotor_origen, titular_genero
ORDER BY vehicle_origin, records DESC;

SELECT automotor_anio_modelo AS model_year, COUNT(*) AS records
FROM dnrpa
WHERE automotor_anio_modelo BETWEEN 1980 AND 2023
GROUP BY automotor_anio_modelo
ORDER BY model_year;

SELECT COUNT(*) AS flagged_birth_year_records
FROM dnrpa
WHERE titular_anio_nacimiento <= 1934 OR titular_anio_nacimiento >= 2005;

SELECT titular_domicilio_localidad AS locality, COUNT(*) AS records
FROM dnrpa
WHERE UPPER(titular_domicilio_provincia) = 'BUENOS AIRES'
GROUP BY titular_domicilio_localidad
ORDER BY records DESC
LIMIT 15;
