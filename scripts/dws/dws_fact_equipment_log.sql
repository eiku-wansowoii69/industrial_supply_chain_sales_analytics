USE industrial_supply_chain_sales_analytics;

DROP TABLE IF EXISTS dws_fact_equipment_log;

CREATE TABLE dws_fact_equipment_log (
  log_id                INT AUTO_INCREMENT PRIMARY KEY,
  udi                   INT NOT NULL,
  product_id            VARCHAR(20) NOT NULL,
  product_key           INT NOT NULL,
  date_key              INT NOT NULL,
  event_time            DATETIME NOT NULL,
  air_temp_k            DECIMAL(5,2) NOT NULL,
  process_temp_k        DECIMAL(5,2) NOT NULL,
  rotational_speed_rpm  INT NOT NULL,
  torque_nm             DECIMAL(5,2) NOT NULL,
  tool_wear_min         INT NOT NULL,
  machine_failure       TINYINT NOT NULL,
  twf                   TINYINT NOT NULL,
  hdf                   TINYINT NOT NULL,
  pwf                   TINYINT NOT NULL,
  osf                   TINYINT NOT NULL,
  rnf                   TINYINT NOT NULL,
  UNIQUE KEY uk_udi (udi),
  KEY idx_product_id (product_id),
  KEY idx_product_key (product_key),
  KEY idx_date_key (date_key),
  KEY idx_machine_failure (machine_failure),
  CONSTRAINT fk_fact_product FOREIGN KEY (product_key) REFERENCES dws_dim_product(product_key),
  CONSTRAINT fk_fact_date    FOREIGN KEY (date_key)    REFERENCES dws_dim_date(date_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO dws_fact_equipment_log (
  udi, product_id, product_key, date_key, event_time,
  air_temp_k, process_temp_k, rotational_speed_rpm, torque_nm, tool_wear_min,
  machine_failure, twf, hdf, pwf, osf, rnf
)
SELECT
  c.udi,
  c.product_id,
  p.product_key,
  c.date_key,
  c.event_time,
  c.air_temp_k,
  c.process_temp_k,
  c.rotational_speed_rpm,
  c.torque_nm,
  c.tool_wear_min,
  c.machine_failure,
  c.twf, c.hdf, c.pwf, c.osf, c.rnf
FROM dwd_machine_clean c
JOIN dws_dim_product p ON p.product_type = c.product_type
ORDER BY c.udi;

INSERT INTO dws_fact_equipment_log (
  udi, product_id, product_key, date_key, event_time,
  air_temp_k, process_temp_k, rotational_speed_rpm, torque_nm, tool_wear_min,
  machine_failure, twf, hdf, pwf, osf, rnf
)
SELECT
  c.udi,
  c.product_id,
  p.product_key,
  c.date_key,
  c.event_time,
  c.air_temp_k,
  c.process_temp_k,
  c.rotational_speed_rpm,
  c.torque_nm,
  c.tool_wear_min,
  c.machine_failure,
  c.twf, c.hdf, c.pwf, c.osf, c.rnf
FROM dwd_machine_clean c
JOIN dws_dim_product p ON p.product_type = c.product_type
ORDER BY c.udi;