-- Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

-- Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

-- Notes:
-- Calculate the following percentages:
-- time spent sending / (Time spent sending + Time spent opening)
-- Time spent opening / (Time spent sending + Time spent opening)
-- To avoid integer division in percentages, multiply by 100.0 and not 100.

-- activities Table
-- Column Name   Type
-- activity_id   integer
-- user_id       integer
-- activity_type string ('send', 'open', 'chat')
-- time_spent    float
-- activity_date datetime

SELECT 
  yo.age_bucket,
  ROUND(
    SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) 
    / 
    SUM(CASE WHEN activity_type IN ('send', 'open') THEN time_spent ELSE 0 END) 
    * 100.0, 
  2) AS send_perc,
  ROUND(
    SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) 
    / 
    SUM(CASE WHEN activity_type IN ('send', 'open') THEN time_spent ELSE 0 END) 
    * 100.0, 
  2) AS open_perc
FROM 
  activities a
JOIN 
  age_breakdown yo 
ON 
  a.user_id = yo.user_id
WHERE 
  activity_type IN ('send', 'open')
GROUP BY 
  yo.age_bucket;
