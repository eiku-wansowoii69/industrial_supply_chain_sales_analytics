/*
脚本名称：ODS 层设备原始数据加载脚本
功能：将本地 CSV 源文件（ai4i2020.csv）中的设备原始数据批量导入至操作数据存储层
      原始表（ods_machine_raw）中，完成从数据源到 ODS 层的数据装载。
说明：脚本使用 LOAD DATA LOCAL INFILE 语句，实现本地文件的批量加载；
      为后续 DWD 层的数据清洗、类型转换和标准化处理提供原始数据基础。
*/
USE industrial_supply_chain_sales_analytics;

LOAD DATA LOCAL INFILE 'D:/31418/industrial_supply_chain_sales_analytics/datasets/ai4i2020.csv'
INTO TABLE ods_machine_raw
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(UDI, `Product ID`, `Type`, `Air temperature [K]`, `Process temperature [K]`,
 `Rotational speed [rpm]`, `Torque [Nm]`, `Tool wear [min]`, `Machine failure`,
 TWF, HDF, PWF, OSF, RNF);
 
