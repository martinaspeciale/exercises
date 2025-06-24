-- You are given a table 'measurements' containing sensor data collected multiple times per day.
-- Table columns:
--   measurement_id (integer)
--   measurement_value (decimal)
--   measurement_time (datetime)

-- Goal:
--   For each day, calculate:
--     - Sum of odd-numbered measurements (1st, 3rd, 5th, etc.)
--     - Sum of even-numbered measurements (2nd, 4th, 6th, etc.)

WITH clean_ AS (
  SELECT 
    measurement_id, 
    measurement_value, 
    measurement_time,
    ROW_NUMBER() OVER (
      PARTITION BY CAST(measurement_time AS DATE)
      ORDER BY measurement_time
    ) AS rn 
  FROM measurements
)

SELECT 
  CAST(measurement_time AS DATE) AS measurement_day,
  SUM(CASE WHEN rn % 2 = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
  SUM(CASE WHEN rn % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM clean_
GROUP BY CAST(measurement_time AS DATE)
ORDER BY measurement_day;
