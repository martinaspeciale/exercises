-- We want to calculate a 3-day rolling average of tweet counts for each user.
-- The rolling window includes the current date and the previous 2 days.
-- We partition by user_id to calculate each user's rolling average separately.
-- We order by tweet_date so the rolling window moves through time.
-- RANGE BETWEEN INTERVAL '2 day' PRECEDING AND CURRENT ROW means:
--    For each row, consider all rows where tweet_date is within 2 days before the current tweet_date.
-- Finally, we round the result to 2 decimal places.

SELECT
    user_id,
    tweet_date,
    ROUND(
        AVG(tweet_count) OVER (
            PARTITION BY user_id
            ORDER BY tweet_date
            RANGE BETWEEN INTERVAL '2 day' PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_avg
FROM tweets
ORDER BY user_id, tweet_date;
