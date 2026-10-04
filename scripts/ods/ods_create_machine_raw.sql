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