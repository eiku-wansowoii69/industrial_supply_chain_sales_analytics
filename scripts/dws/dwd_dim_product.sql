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
