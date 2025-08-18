-- This query calculates the percentage of international phone calls.
-- A call is considered international when the caller and receiver 
-- are in different countries. We join the phone_calls table with 
-- the phone_info table twice: once for the caller and once for the receiver
-- (even though the column is still caller_id, it refers to both roles).
-- We then count how many calls are international and divide that by the total 
-- number of calls. The result is rounded to 1 decimal place and expressed as a percentage.

select 
  round(
    sum(case when caller.country_id <> receiver.country_id then 1 else 0 end) * 100.0 
    / count(*), 1
  ) as international_calls_pct
from 
  phone_calls c
  join phone_info caller 
    on c.caller_id = caller.caller_id
  join phone_info receiver 
    on c.receiver_id = receiver.caller_id;
