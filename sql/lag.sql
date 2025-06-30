Problem:
Given a table `sales`, for each salesperson show their sales date,
amount, and the difference in amount compared to their previous sale
(ordered by date). Return columns:

  salesperson_id
  sale_date
  amount
  previous_amount
  amount_difference

-------------------------------------------------------------
Table: sales
Columns:
  sale_id INTEGER PRIMARY KEY
  salesperson_id INTEGER
  sale_date DATE
  amount DECIMAL
*/

SELECT
  salesperson_id,
  sale_date,
  amount,
  LAG(amount) OVER (
    PARTITION BY salesperson_id
    ORDER BY sale_date
  ) AS previous_amount,
  amount - LAG(amount) OVER (
    PARTITION BY salesperson_id
    ORDER BY sale_date
  ) AS amount_difference
FROM sales;
