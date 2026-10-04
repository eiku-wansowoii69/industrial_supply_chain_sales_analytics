/*
脚本名称：ODS 层设备原始数据建表脚本
功能：创建操作数据存储层（ods）的设备原始数据表（ods_machine_raw），用于承接从源
      系统导入的未经清洗的原始设备运行记录。
说明：脚本使用 DROP TABLE IF EXISTS 判断，表示已存在时先删除再重建，可重复运行；
      所有字段均采用 TEXT 类型，保持原始数据的原貌，不做类型转换与约束限制，
      为后续 DWD 层的清洗、去空、类型转换和标准化处理提供原始数据来源。
*/

-- CREATE DATABASE industrial_supply_chain_sales_analytics
--   DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

USE industrial_supply_chain_sales_analytics;

DROP TABLE IF EXISTS ods_machine_raw;

CREATE TABLE ods_machine_raw (
  UDI                      TEXT,
  `Product ID`             TEXT,
  `Type`                   TEXT,
  `Air temperature [K]`    TEXT,
  `Process temperature [K]` TEXT,
  `Rotational speed [rpm]` TEXT,
  `Torque [Nm]`            TEXT,
  `Tool wear [min]`        TEXT,
  `Machine failure`        TEXT,
  TWF TEXT,
  HDF TEXT,
  PWF TEXT,
  OSF TEXT,
  RNF TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
