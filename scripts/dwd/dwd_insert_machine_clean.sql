USE industrial_supply_chain_sales_analytics;

INSERT INTO dwd_machine_clean (
  udi, product_id, product_type, event_time, date_key,
  air_temp_k, process_temp_k, rotational_speed_rpm,
  torque_nm, tool_wear_min, machine_failure,
  twf, hdf, pwf, osf, rnf
)
SELECT
  CAST(TRIM(UDI) AS UNSIGNED),
  TRIM(`Product ID`),
  TRIM(`Type`),
  DATE_ADD('2024-01-01 00:00:00',
           INTERVAL (CAST(TRIM(UDI) AS UNSIGNED) - 1) * 10 MINUTE),
  CAST(DATE_FORMAT(
         DATE_ADD('2024-01-01 00:00:00',
                  INTERVAL (CAST(TRIM(UDI) AS UNSIGNED) - 1) * 10 MINUTE),
         '%Y%m%d') AS UNSIGNED),
  CAST(TRIM(`Air temperature [K]`) AS DECIMAL(5,2)),
  CAST(TRIM(`Process temperature [K]`) AS DECIMAL(5,2)),
  CAST(TRIM(`Rotational speed [rpm]`) AS UNSIGNED),
  CAST(TRIM(`Torque [Nm]`) AS DECIMAL(5,2)),
  CAST(TRIM(`Tool wear [min]`) AS UNSIGNED),
  CAST(TRIM(`Machine failure`) AS UNSIGNED),
  CAST(TRIM(TWF) AS UNSIGNED),
  CAST(TRIM(HDF) AS UNSIGNED),
  CAST(TRIM(PWF) AS UNSIGNED),
  CAST(TRIM(OSF) AS UNSIGNED),
  CAST(TRIM(RNF) AS UNSIGNED)
FROM ods_machine_raw
WHERE TRIM(`Type`) IN ('L','M','H')
  AND CAST(TRIM(`Machine failure`) AS UNSIGNED) IN (0,1);