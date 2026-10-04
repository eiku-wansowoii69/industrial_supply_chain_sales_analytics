/*
脚本名称：DWS 层时间维度建表及初始化脚本
功能：创建数据仓库汇总层（dws）的时间维度表（dws_dim_date），并基于递归方式生成
      指定日期范围内的连续日期数据，用于与事实表进行多维度关联分析。
说明：脚本使用 DROP TABLE IF EXISTS 判断，表示已存在时先删除再重建，可重复运行；
      共 1 张表（dws_dim_date），包含日期主键（date_key）、完整日期、年/季/月/日、
      星期、年内周数及是否周末等标准时间属性；
      通过 WITH RECURSIVE 递归生成 2024-01-01 至 2024-03-10 的连续日期序列；
      为后续设备故障的时间趋势分析、周期性统计等多维度分析提供标准时间维度支撑。
*/
USE industrial_supply_chain_sales_analytics;

DROP TABLE IF EXISTS dws_dim_date;

CREATE TABLE dws_dim_date (
  date_key     INT PRIMARY KEY,
  full_date    DATE     NOT NULL,
  year         SMALLINT NOT NULL,
  quarter      TINYINT  NOT NULL,
  month        TINYINT  NOT NULL,
  day          TINYINT  NOT NULL,
  day_of_week  TINYINT  NOT NULL,
  week_of_year TINYINT  NOT NULL,
  is_weekend   TINYINT  NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO dws_dim_date (date_key, full_date, year, quarter, month, day, day_of_week, week_of_year, is_weekend)
WITH RECURSIVE seq AS (
  SELECT DATE('2024-01-01') AS dt
  UNION ALL
  SELECT DATE_ADD(dt, INTERVAL 1 DAY) FROM seq WHERE dt < '2024-03-10'
)
SELECT
  CAST(DATE_FORMAT(dt, '%Y%m%d') AS UNSIGNED),
  dt,
  YEAR(dt),
  QUARTER(dt),
  MONTH(dt),
  DAY(dt),
  WEEKDAY(dt) + 1,
  WEEK(dt, 3),
  IF(WEEKDAY(dt) IN (5, 6), 1, 0)
FROM seq;
