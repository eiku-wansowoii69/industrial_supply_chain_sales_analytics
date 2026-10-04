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