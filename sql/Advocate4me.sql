-- UnitedHealth Group (UHG) has a program called Advocate4Me,
-- which allows policy holders (or, members) to call an advocate
-- and receive support for their health care needs – whether that's:
-- - claims and benefits support,
-- - drug coverage,
-- - pre- and post-authorisation,
-- - medical records,
-- - emergency assistance,
-- - or member portal services.

-- Calls to the Advocate4Me call centre are classified into various categories,
-- but some calls cannot be neatly categorised.
-- These uncategorised calls are labeled as “n/a”, or are left empty (NULL)
-- when the support agent does not enter anything into the call category field.

-- Task:
-- Write a query to calculate the percentage of calls that cannot be categorised.
-- Round the result to 1 decimal place (e.g., 45.0, 48.5, 57.7).

-- Table: callers
-- Columns:
-- - policy_holder_id (integer)
-- - case_id (varchar)
-- - call_category (varchar)
-- - call_date (timestamp)
-- - call_duration_secs (integer)

SELECT 
  ROUND(
    SUM(CASE 
          WHEN call_category IS NULL OR call_category = 'n/a' THEN 1 
          ELSE 0 
        END) * 100.0 / COUNT(*), 
    1
  ) AS uncategorised_call_pct
FROM 
  callers;
