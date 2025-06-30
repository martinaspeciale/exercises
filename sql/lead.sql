Given a table `website_traffic`, calculate for each day the number
of visitors, and show the number of visitors on the following day
(using LEAD). Also calculate the difference to the next day.

Return columns:

  date
  visitors
  next_day_visitors
  diff_to_next

-------------------------------------------------------------
Table: website_traffic
Columns:
  id INTEGER PRIMARY KEY
  date DATE
  visitors INTEGER
*/

SELECT
  date,
  visitors,
  LEAD(visitors) OVER (
    ORDER BY date
  ) AS next_day_visitors,
  visitors - LEAD(visitors) OVER (
    ORDER BY date
  ) AS diff_to_next
FROM website_traffic;
