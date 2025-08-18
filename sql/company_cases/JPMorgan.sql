-- This query finds the number of cards issued during the launch month 
-- for each credit card. The launch month is defined as the earliest 
-- (year, month) combination per card. The query uses a common table 
-- expression (CTE) with row_number() to identify the first month per card,
-- then filters for only those rows (rn = 1), and finally sorts the results
-- by issued_amount in descending order.

with ranks as (
  select 
    card_name, 
    issued_amount, 
    row_number() over(
      partition by card_name 
      order by issue_year, issue_month 
    ) as rn
  from 
    monthly_cards_issued 
)

select 
  card_name, 
  issued_amount
from 
  ranks
where 
  rn = 1 
order by 
  issued_amount desc;
