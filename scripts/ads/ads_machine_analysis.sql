USE industrial_supply_chain_sales_analytics;

CREATE OR REPLACE VIEW ads_machine_analysis AS
SELECT
  -- 事实表字段
  f.udi,
  f.product_id,
  f.event_time,
  f.air_temp_k,
  f.process_temp_k,
  f.rotational_speed_rpm,
  f.torque_nm,
  f.tool_wear_min,
  f.machine_failure,
  f.twf,
  f.hdf,
  f.pwf,
  f.osf,
  f.rnf,

  -- 产品维度字段
  p.product_type,
  p.type_desc,

  -- 时间维度字段
  d.full_date,
  d.year,
  d.quarter,
  d.month,
  d.day,
  d.day_of_week,
  d.week_of_year,
  d.is_weekend
FROM dws_fact_equipment_log f
JOIN dws_dim_product p ON p.product_key = f.product_key
JOIN dws_dim_date    d ON d.date_key    = f.date_key;
