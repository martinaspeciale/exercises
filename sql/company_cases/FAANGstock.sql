/*
Problem Description:

The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets.
As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

For each FAANG stock, display:
- the ticker symbol,
- the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices.

Ensure that the results are sorted by ticker symbol.

Table: stock_prices

Schema:
- date (datetime): The specified date (mm/dd/yyyy) of the stock data.
- ticker (varchar): The stock ticker symbol (e.g., AAPL) for the corresponding company.
- open (decimal): The opening price of the stock at the start of the trading day.
- high (decimal): The highest price reached by the stock during the trading day.
- low (decimal): The lowest price reached by the stock during the trading day.
- close (decimal): The closing price of the stock at the end of the trading day.

Example Output:
ticker   | highest_mth | highest_open | lowest_mth | lowest_open
---------------------------------------------------------------
AAPL     | May-2023    | 176.76       | Jan-2023   | 142.28

Solution:
*/

-- Step 1: Create a CTE to extract the month-year string ('Mon-YYYY') along with ticker and open price
WITH month_data AS (
    SELECT 
        ticker,
        TO_CHAR(date, 'Mon-YYYY') AS mth_year,
        open
    FROM stock_prices
),

-- Step 2: Find the highest open price for each ticker along with the corresponding month-year
max_open AS (
    SELECT 
        md.ticker,
        md.mth_year AS highest_mth,
        md.open AS highest_open
    FROM month_data md
    JOIN (
        -- Subquery to get the maximum open price per ticker
        SELECT ticker, MAX(open) AS max_open
        FROM month_data
        GROUP BY ticker
    ) mo
    ON md.ticker = mo.ticker AND md.open = mo.max_open
),

-- Step 3: Find the lowest open price for each ticker along with the corresponding month-year
min_open AS (
    SELECT 
        md.ticker,
        md.mth_year AS lowest_mth,
        md.open AS lowest_open
    FROM month_data md
    JOIN (
        -- Subquery to get the minimum open price per ticker
        SELECT ticker, MIN(open) AS min_open
        FROM month_data
        GROUP BY ticker
    ) mi
    ON md.ticker = mi.ticker AND md.open = mi.min_open
)

-- Step 4: Join the highest and lowest results together and sort by ticker
SELECT 
    m.ticker,
    m.highest_mth,
    m.highest_open,
    n.lowest_mth,
    n.lowest_open
FROM max_open m
JOIN min_open n
ON m.ticker = n.ticker
ORDER BY m.ticker;
