-- Title: Monthly User Retention - June to July 2022
-- Description: This query calculates the number of users who were active 
--              in both June and July 2022 (i.e., retained users).
--              It avoids overcounting by selecting distinct user_ids
--              and uses a hardcoded month number to simplify the output 
--              without requiring a GROUP BY clause.

with june_users as (
  -- Select users who were active at least once in June 2022
  select distinct user_id
  from user_actions 
  where extract(year from event_date) = 2022 
    and extract(month from event_date) = 6
),
july_users as (
  -- Select users who were active at least once in July 2022
  select distinct user_id
  from user_actions 
  where extract(year from event_date) = 2022 
    and extract(month from event_date) = 7
)

-- Count how many users were present in both June and July (i.e., retained)
select 
  7 as month,  -- Hardcoded for clarity; avoids GROUP BY
  count(*) as monthly_active_users_retained_from_june
from 
  july_users ju
  inner join june_users ju2 on ju.user_id = ju2.user_id;


-- Actual solution for DataLemur Exercise: 
-- Title: Monthly Active Users Retained - July 2022
-- Description: Counts users active in both June and July 2022 
--              (defined as performing any action in both months).

with june_users as (
  select distinct user_id
  from user_actions 
  where extract(year from event_date) = 2022 
    and extract(month from event_date) = 6
),
july_users as (
  select distinct user_id
  from user_actions 
  where extract(year from event_date) = 2022 
    and extract(month from event_date) = 7
)

select 
  7 as month, 
  count(*) as monthly_active_users
from (
  select ju.user_id
  from july_users ju
  inner join june_users ju2 on ju.user_id = ju2.user_id
) retained_users;

