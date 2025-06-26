-- Problem:
-- We are given a summary table (search_frequency) where:
-- - "searches" = number of searches a user made last year
-- - "num_users" = how many users made exactly that number of searches
-- Our goal is to compute the true median number of searches per user.

-- Mistake in the original approach:
-- Filtering by the maximum num_users only gives the mode (most common number of searches),
-- not the median. The median depends on the position of users in the full ordered list,
-- which we simulate using cumulative sums.

-- Solution:
-- 1. Compute the total number of users.
-- 2. Compute the cumulative user count ordered by "searches".
-- 3. Find the median position(s):
--    - If total is odd → one middle user
--    - If total is even → average of the two middle values
-- 4. Select the "searches" value(s) that fall into the median position(s).
-- 5. Return the average of those values (1 or 2), rounded to 1 decimal.

WITH ordered AS (
  SELECT
    searches,
    num_users,
    SUM(num_users) OVER (ORDER BY searches) AS cume,
    SUM(num_users) OVER () AS total
  FROM search_frequency
),
median_rows AS (
  SELECT searches
  FROM ordered
  WHERE 
    -- Even total users: capture the two middle positions
    (total % 2 = 0 AND cume >= total/2 AND cume - num_users < total/2 + 1)
    -- Odd total users: capture the exact middle position
    OR (total % 2 = 1 AND cume >= (total + 1)/2 AND cume - num_users < (total + 1)/2)
)
SELECT ROUND(AVG(searches * 1.0), 1) AS median
FROM median_rows;
