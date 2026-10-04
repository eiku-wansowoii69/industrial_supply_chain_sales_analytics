/*
脚本名称：DWD 层设备数据清洗加载脚本
功能：将 ODS 层（ods_machine_raw）的原始设备数据经过清洗、类型转换和标准化后，
      加载至 DWD 层明细表（dwd_machine_clean）中。
说明：脚本使用 INSERT INTO ... SELECT 语句，实现从原始层到明细层的数据流转；
      处理逻辑包含：去除字段首尾空格（TRIM）、字段类型转换（CAST）、
      基于 UDI 推算事件时间及日期维度键（DATE_ADD、DATE_FORMAT）；
      并通过 WHERE 条件过滤无效产品类型（仅保留 L/M/H）及异常故障标签（仅保留 0/1），
      确保进入明细层的数据质量，为后续多维度关联分析提供可靠基础。
*/
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
