/*
脚本名称：DWS 层故障类型维度建表及初始化脚本
功能：创建数据仓库汇总层（dws）的故障类型维度表（dws_dim_failure_type），并写入设备
      各类故障的标准化编码与描述数据，用于与事实表进行多维度关联分析。
说明：脚本使用 DROP TABLE IF EXISTS 判断，表示已存在时先删除再重建，可重复运行；
      初始化数据包含 5 类故障：TWF（工具磨损故障）、HDF（散热故障）、PWF（电源故障）、
      OSF（过载故障）、RNF（随机故障）；
      为后续设备故障类型的多维统计、故障占比分析等场景提供标准化维度支撑。
*/
USE industrial_supply_chain_sales_analytics;

DROP TABLE IF EXISTS dws_dim_failure_type;

CREATE TABLE dws_dim_failure_type (
  failure_code  VARCHAR(5) PRIMARY KEY,
  failure_name  VARCHAR(30) NOT NULL,
  description   VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO dws_dim_failure_type (failure_code, failure_name, description) VALUES
  ('TWF', 'Tool Wear Failure',        '工具磨损故障'),
  ('HDF', 'Heat Dissipation Failure', '散热故障'),
  ('PWF', 'Power Failure',            '电源故障'),
  ('OSF', 'Overstrain Failure',       '过载故障'),
  ('RNF', 'Random Failure',           '随机故障');
