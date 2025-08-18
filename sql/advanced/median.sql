-- Step 1: Create a cumulative distribution of users ordered by search count
WITH ordered AS (
  SELECT
    searches,                  -- the number of searches made
    num_users,                 -- how many users made that number of searches
    SUM(num_users) OVER (ORDER BY searches) AS cume_users -- cumulative user count
  FROM search_frequency
),

-- Step 2: Calculate total number of users
total AS (
  SELECT SUM(num_users) AS total_users
  FROM search_frequency
),

-- Step 3: Determine the median position(s)
-- If the number of users is odd → 1 position
-- If even → 2 middle positions (to average)
median_pos AS (
  SELECT
    total_users,
    CASE 
      WHEN total_users % 2 = 1 THEN [ (total_users + 1) / 2 ]         -- odd → single median position
      ELSE [ total_users / 2, total_users / 2 + 1 ]                   -- even → two middle positions
    END AS median_positions
  FROM total
),

-- Step 4: Expand data to find which searches correspond to those median positions
expanded AS (
  SELECT 
    o.searches,
    o.cume_users,
    t.total_users
  FROM ordered o
  CROSS JOIN total t
),

-- Step 5: Unnest the median positions, and pick the lowest `searches` value
-- where the cumulative users have reached or passed the median position.
median_rows AS (
  SELECT searches
  FROM expanded, UNNEST(
    CASE
      WHEN total_users % 2 = 1 THEN [ (total_users + 1) / 2 ]
      ELSE [ total_users / 2, total_users / 2 + 1 ]
    END
  ) AS pos
  WHERE pos <= cume_users
  QUALIFY ROW_NUMBER() OVER (PARTITION BY pos ORDER BY cume_users) = 1
)

-- Step 6: Average the median search values (1 or 2), round to 1 decimal
SELECT ROUND(AVG(searches), 1) AS median
FROM median_rows;
