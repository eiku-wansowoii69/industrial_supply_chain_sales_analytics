USE industrial_supply_chain_sales_analytics;

DROP TABLE IF EXISTS dws_dim_date;

CREATE TABLE dws_dim_date (
  date_key     INT PRIMARY KEY,
  full_date    DATE     NOT NULL,
  year         SMALLINT NOT NULL,
  quarter      TINYINT  NOT NULL,
  month        TINYINT  NOT NULL,
  day          TINYINT  NOT NULL,
  day_of_week  TINYINT  NOT NULL,
  week_of_year TINYINT  NOT NULL,
  is_weekend   TINYINT  NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO dws_dim_date (date_key, full_date, year, quarter, month, day, day_of_week, week_of_year, is_weekend)
WITH RECURSIVE seq AS (
  SELECT DATE('2024-01-01') AS dt
  UNION ALL
  SELECT DATE_ADD(dt, INTERVAL 1 DAY) FROM seq WHERE dt < '2024-03-10'
)
SELECT
  CAST(DATE_FORMAT(dt, '%Y%m%d') AS UNSIGNED),
  dt,
  YEAR(dt),
  QUARTER(dt),
  MONTH(dt),
  DAY(dt),
  WEEKDAY(dt) + 1,
  WEEK(dt, 3),
  IF(WEEKDAY(dt) IN (5, 6), 1, 0)
FROM seq;