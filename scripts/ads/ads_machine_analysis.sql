/*
脚本名称：ADS 层机器学习分析视图脚本
功能：创建应用数据层（ads_machine_analysis）视图，基于数据仓库汇总层（dws）的事实表与维度表，
      通过星型模型关联，输出用于机器学习预测设备故障的宽表数据。
说明：脚本使用 CREATE OR REPLACE VIEW 语句，表示已存在时替换，可重复运行；
      共关联 4 张表，分为 1 张事实表（dws_fact_equipment_log）和 3 张维度表（dws_dim_product、dws_dim_date、dws_dim_failure_type）；
      输出字段包含设备运行传感器指标、故障标签、产品属性以及详尽的时间维度信息；
      旨在为后续设备故障预测、机器学习模型训练及多维度关联分析提供标准化的特征数据集。
*/
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
