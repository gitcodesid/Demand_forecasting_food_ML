-- Title: Data Extraction & Feature Engineering Pipeline
-- Dialect: PostgreSQL / ANSI SQL Standard
-- Description: Integrates historical sales ledger data with fulfillment center 
--              profiles and meal metadata, dynamically calculating promotional margins.
-- ==============================================================================

WITH RawFulfillmentData AS (
    SELECT 
        t.id,
        t.week,
        t.center_id,
        t.meal_id,
        t.checkout_price,
        t.base_price,
        t.emailer_for_promotion,
        t.homepage_featured,
        t.num_orders,
        -- Feature Engineering: Calculate the financial discount amount
        (t.base_price - t.checkout_price) AS discount_amount,
        -- Dimensional Data from Center Profile
        c.city_code,
        c.region_code,
        c.center_type,
        c.op_area,
        -- Dimensional Data from Meal Profile
        m.category,
        m.cuisine
    FROM demand_forecast.train t
    LEFT JOIN demand_forecast.fulfilment_center_info c 
        ON t.center_id = c.center_id
    LEFT JOIN demand_forecast.meal_info m 
        ON t.meal_id = m.meal_id
)
SELECT 
    id,
    week,
    center_id,
    meal_id,
    checkout_price,
    base_price,
    emailer_for_promotion,
    homepage_featured,
    discount_amount,
    -- Feature Engineering: Safe percentage calculation handling potential zero-division
    CASE 
        WHEN base_price > 0 THEN ROUND((discount_amount / base_price), 4)
        ELSE 0 
    END AS discount_percent,
    -- Feature Engineering: Binary indicator for promotion presence
    CASE 
        WHEN (base_price - checkout_price) > 0 THEN 1 
        ELSE 0 
    END AS is_discount,
    category,
    cuisine,
    center_type,
    op_area,
    num_orders
FROM RawFulfillmentData
ORDER BY week ASC, center_id ASC, meal_id ASC;