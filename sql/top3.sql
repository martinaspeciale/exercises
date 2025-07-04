/*
------------------------------------------------------------------------------
QUESTION
------------------------------------------------------------------------------
Find the top 3 customers (by total revenue) in each region.
Return columns: region, customer_id, total_revenue, ranking.

------------------------------------------------------------------------------
SCHEMA
------------------------------------------------------------------------------
customers(customer_id, name, region)
orders(order_id, customer_id, order_date, total_amount)

------------------------------------------------------------------------------
EXPLANATION
------------------------------------------------------------------------------
Your goal is to:
1) Aggregate total revenue for each customer in each region.
2) Rank customers within each region by their total revenue.
3) Return the top 3 per region.

Common mistake:
- Using SUM() OVER (PARTITION BY customer_id) will not collapse rows.
  You need GROUP BY to get one row per customer.

Solution steps:
- First, GROUP BY region and customer_id to get total_revenue.
- Second, use RANK() OVER (PARTITION BY region ORDER BY total_revenue DESC)
  to assign rankings.
- Finally, filter where ranking <= 3.

------------------------------------------------------------------------------
*/

WITH customer_totals AS (
    SELECT
        c.region,
        c.customer_id,
        SUM(o.total_amount) AS total_revenue
    FROM
        customers c
        JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY
        c.region,
        c.customer_id
),
ranked_customers AS (
    SELECT
        region,
        customer_id,
        total_revenue,
        RANK() OVER (
            PARTITION BY region
            ORDER BY total_revenue DESC
        ) AS ranking
    FROM
        customer_totals
)
SELECT
    region,
    customer_id,
    total_revenue,
    ranking
FROM
    ranked_customers
WHERE
    ranking <= 3;
