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
