/*
脚本名称：DWS 层产品维度建表及初始化脚本
功能：创建数据仓库汇总层（dws）的产品维度表（dws_dim_product），并写入产品类型的
      标准化描述数据，用于与事实表进行多维度关联分析。
说明：脚本使用 DROP TABLE IF EXISTS 判断，表示已存在时先删除再重建，可重复运行；
      初始化数据包含 L/M/H 三类产品质量等级（Low/Medium/High Quality），
      为后续设备故障与产品质量的关联分析提供标准维度支撑。
*/
USE industrial_supply_chain_sales_analytics;

DROP TABLE IF EXISTS dws_dim_product;

CREATE TABLE dws_dim_product (
  product_key   INT AUTO_INCREMENT PRIMARY KEY,
  product_type  VARCHAR(5)  NOT NULL,
  type_desc     VARCHAR(20) NOT NULL,
  UNIQUE KEY uk_product_type (product_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO dws_dim_product (product_type, type_desc) VALUES
  ('L', 'Low Quality'),
  ('M', 'Medium Quality'),
  ('H', 'High Quality');
