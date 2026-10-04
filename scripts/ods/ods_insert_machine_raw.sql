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
 
