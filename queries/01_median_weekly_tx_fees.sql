-- Median Ethereum Transaction Fees (Weekly) Since 2020
-- Uses Snowflake's built-in MEDIAN() function

WITH weekly_fees AS (
    SELECT 
        DATE_TRUNC('week', block_timestamp) AS week_,
        MEDIAN(tx_fee) AS tx_fee_eth
    FROM ethereum.core.fact_transactions
    WHERE block_timestamp >= '2020-01-01'
    AND block_timestamp < '2025-12-08'
    GROUP BY 1
),
weekly_prices AS (
    SELECT 
        DATE_TRUNC('week', hour) AS week_,
        MEDIAN(price) AS median_eth_price
    FROM ethereum.price.ez_prices_hourly
    WHERE is_native = TRUE
    AND hour < '2025-12-08'
        AND hour >= '2020-01-01'
    GROUP BY 1
)
SELECT 
    wf.week_ AS week_start,
    wf.tx_fee_eth AS median_fee_eth,
    wf.tx_fee_eth * COALESCE(wp.median_eth_price, 0) AS median_fee_usd,
    wp.median_eth_price AS eth_price_usd
FROM weekly_fees wf
LEFT JOIN weekly_prices wp ON wf.week_ = wp.week_
ORDER BY wf.week_ ASC;


