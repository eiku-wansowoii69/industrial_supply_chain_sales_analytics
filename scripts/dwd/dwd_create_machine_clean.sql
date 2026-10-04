/*
脚本名称：DWD 层设备数据清洗建表脚本
功能：创建数据仓库明细层（dwd_machine_clean）表，用于存储经过清洗、类型转换和标准化后的
      设备运行明细数据及故障标签。
说明：脚本使用 DROP TABLE IF EXISTS 判断，表示已存在时先删除再重建，可重复运行；
      共 1 张表，作为设备传感器数据的核心明细事实表；
      表内包含设备主键（udi）、产品信息、时间维度键（date_key）以及各项传感器指标和故障标签；
      并针对产品类型、时间维度和故障状态建立了索引，以提升后续多维度关联分析的查询效率。
*/
USE industrial_supply_chain_sales_analytics;

DROP TABLE IF EXISTS dwd_machine_clean;

CREATE TABLE dwd_machine_clean (
  udi                   INT          NOT NULL,
  product_id            VARCHAR(20)  NOT NULL,
  product_type          VARCHAR(5)   NOT NULL,
  event_time            DATETIME     NOT NULL,
  date_key              INT          NOT NULL,
  air_temp_k            DECIMAL(5,2) NOT NULL,
  process_temp_k        DECIMAL(5,2) NOT NULL,
  rotational_speed_rpm  INT          NOT NULL,
  torque_nm             DECIMAL(5,2) NOT NULL,
  tool_wear_min         INT          NOT NULL,
  machine_failure       TINYINT      NOT NULL,
  twf                   TINYINT      NOT NULL,
  hdf                   TINYINT      NOT NULL,
  pwf                   TINYINT      NOT NULL,
  osf                   TINYINT      NOT NULL,
  rnf                   TINYINT      NOT NULL,
  PRIMARY KEY (udi),
  KEY idx_product_type (product_type),
  KEY idx_date_key (date_key),
  KEY idx_machine_failure (machine_failure)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
