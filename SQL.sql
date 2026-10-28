-- ============================================================
-- CUSTOMER SHOPPING BEHAVIOR ANALYSIS
-- SQL Business Analysis
-- Database: customers_behavior
-- Table: customer_shopping
-- ============================================================

-- 1. DATASET OVERVIEW
SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(purchase_amount) AS total_purchase_amount,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    ROUND(AVG(review_rating), 2) AS average_review_rating
FROM customer_shopping;


-- 2. DATA QUALITY: MISSING VALUES
SELECT
    SUM(customer_id IS NULL) AS missing_customer_ids,
    SUM(purchase_amount IS NULL) AS missing_purchase_amounts,
    SUM(review_rating IS NULL) AS missing_review_ratings
FROM customer_shopping;


-- 3. DATA QUALITY: DUPLICATE CUSTOMER IDs
SELECT
    customer_id,
    COUNT(*) AS occurrences
FROM customer_shopping
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 4. DATA QUALITY: INVALID REVIEW RATINGS
SELECT *
FROM customer_shopping
WHERE review_rating IS NOT NULL
  AND (review_rating < 1 OR review_rating > 5);


-- 5. PURCHASE PERFORMANCE BY CATEGORY
SELECT
    category,
    SUM(purchase_amount) AS total_purchase_amount,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    COUNT(*) AS number_of_records,
    ROUND(
        100.0 * SUM(purchase_amount) /
        (SELECT SUM(purchase_amount) FROM customer_shopping),
        2
    ) AS purchase_share_pct
FROM customer_shopping
GROUP BY category
ORDER BY total_purchase_amount DESC;


-- 6. CUSTOMER SPENDING BY GENDER
SELECT
    gender,
    COUNT(*) AS number_of_customers,
    SUM(purchase_amount) AS total_purchase_amount,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount
FROM customer_shopping
GROUP BY gender
ORDER BY total_purchase_amount DESC;


-- 7. SUBSCRIPTION STATUS AND SPENDING
SELECT
    subscription_status,
    COUNT(*) AS number_of_customers,
    SUM(purchase_amount) AS total_purchase_amount,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS average_previous_purchases
FROM customer_shopping
GROUP BY subscription_status
ORDER BY total_purchase_amount DESC;


-- 8. TOP FIVE PRODUCTS BY TOTAL PURCHASE AMOUNT
SELECT
    item_purchased AS product,
    SUM(purchase_amount) AS total_purchase_amount,
    COUNT(*) AS number_of_records,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    ROUND(AVG(review_rating), 2) AS average_review_rating
FROM customer_shopping
GROUP BY item_purchased
ORDER BY total_purchase_amount DESC
LIMIT 5;


-- 9. PRODUCTS WITH ABOVE-AVERAGE PURCHASE AMOUNTS
SELECT
    item_purchased AS product,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount
FROM customer_shopping
GROUP BY item_purchased
HAVING AVG(purchase_amount) > (
    SELECT AVG(purchase_amount)
    FROM customer_shopping
)
ORDER BY average_purchase_amount DESC;


-- 10. TOP THREE PRODUCTS BY ORDER COUNT IN EACH CATEGORY
WITH product_counts AS (
    SELECT
        category,
        item_purchased,
        COUNT(*) AS total_records,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY COUNT(*) DESC, item_purchased
        ) AS product_rank
    FROM customer_shopping
    GROUP BY category, item_purchased
)
SELECT
    category,
    item_purchased AS product,
    total_records,
    product_rank
FROM product_counts
WHERE product_rank <= 3
ORDER BY category, product_rank;


-- 11. SEASONAL PURCHASE PERFORMANCE
SELECT
    season,
    SUM(purchase_amount) AS total_purchase_amount,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    ROUND(
        100.0 * SUM(purchase_amount) /
        (SELECT SUM(purchase_amount) FROM customer_shopping),
        2
    ) AS overall_purchase_share_pct
FROM customer_shopping
GROUP BY season
ORDER BY total_purchase_amount DESC;


-- 12. TOP TWO PRODUCTS BY PURCHASE AMOUNT IN EACH SEASON
WITH seasonal_products AS (
    SELECT
        season,
        item_purchased,
        SUM(purchase_amount) AS total_purchase_amount,
        ROW_NUMBER() OVER (
            PARTITION BY season
            ORDER BY SUM(purchase_amount) DESC, item_purchased
        ) AS product_rank
    FROM customer_shopping
    GROUP BY season, item_purchased
)
SELECT
    season,
    item_purchased AS product,
    total_purchase_amount,
    product_rank
FROM seasonal_products
WHERE product_rank <= 2
ORDER BY season, product_rank;


-- 13. PURCHASE AMOUNT SHARE OF EACH PRODUCT WITHIN ITS SEASON
SELECT
    season,
    item_purchased AS product,
    SUM(purchase_amount) AS product_purchase_amount,
    ROUND(
        100.0 * SUM(purchase_amount) /
        SUM(SUM(purchase_amount)) OVER (PARTITION BY season),
        2
    ) AS seasonal_product_share_pct
FROM customer_shopping
GROUP BY season, item_purchased
ORDER BY season, seasonal_product_share_pct DESC;


-- 14. PURCHASE PERFORMANCE BY SHIPPING TYPE
SELECT
    shipping_type,
    COUNT(*) AS number_of_records,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    SUM(purchase_amount) AS total_purchase_amount
FROM customer_shopping
GROUP BY shipping_type
ORDER BY average_purchase_amount DESC;


-- 15. DISCOUNT USAGE BY PRODUCT
SELECT
    item_purchased AS product,
    COUNT(*) AS total_records,
    SUM(CASE
        WHEN discount_applied = 'Yes' THEN 1
        ELSE 0
    END) AS discounted_records,
    ROUND(
        100.0 * SUM(CASE
            WHEN discount_applied = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS discount_rate_pct
FROM customer_shopping
GROUP BY item_purchased
ORDER BY discount_rate_pct DESC;


-- 16. PURCHASE AMOUNT BY CATEGORY AND DISCOUNT STATUS
SELECT
    category,
    discount_applied,
    COUNT(*) AS number_of_records,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    SUM(purchase_amount) AS total_purchase_amount
FROM customer_shopping
GROUP BY category, discount_applied
ORDER BY category, discount_applied;


-- 17. Customer Segmentation by Purchase History

SELECT
    CASE
        WHEN previous_purchases <= 5 THEN 'Newer'
        WHEN previous_purchases <= 25 THEN 'Returner'
        ELSE 'Loyal'
    END AS customer_segment,
    COUNT(*) AS number_of_customers,
    ROUND(AVG(previous_purchases), 2) AS average_previous_purchases
FROM customer_shopping
GROUP BY customer_segment
ORDER BY COUNT(*) DESC;


-- 18. PURCHASE AMOUNT BY CUSTOMER AGE GROUP
SELECT
    age_group,
    COUNT(*) AS number_of_records,
    SUM(purchase_amount) AS total_purchase_amount,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount
FROM customer_shopping
GROUP BY age_group
ORDER BY total_purchase_amount DESC;


-- 19. TOP CATEGORY BY AVERAGE PURCHASE AMOUNT IN EACH AGE GROUP
WITH age_category_analysis AS (
    SELECT
        age_group,
        category,
        ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
        ROW_NUMBER() OVER (
            PARTITION BY age_group
            ORDER BY AVG(purchase_amount) DESC, category
        ) AS category_rank
    FROM customer_shopping
    GROUP BY age_group, category
)
SELECT
    age_group,
    category,
    average_purchase_amount
FROM age_category_analysis
WHERE category_rank = 1
ORDER BY age_group;


-- 20. PURCHASE AMOUNT BY FREQUENCY OF PURCHASE
SELECT
    frequency_of_purchases,
    COUNT(*) AS number_of_records,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    SUM(purchase_amount) AS total_purchase_amount
FROM customer_shopping
GROUP BY frequency_of_purchases
ORDER BY average_purchase_amount DESC;


-- 21. CATEGORY PERFORMANCE BY SUBSCRIPTION STATUS
WITH category_totals AS (
    SELECT
        subscription_status,
        category,
        SUM(purchase_amount) AS total_purchase_amount,
        RANK() OVER (
            PARTITION BY subscription_status
            ORDER BY SUM(purchase_amount) DESC
        ) AS category_rank
    FROM customer_shopping
    GROUP BY subscription_status, category
)
SELECT
    subscription_status,
    category,
    total_purchase_amount
FROM category_totals
WHERE category_rank = 1
ORDER BY subscription_status;


-- 22. PURCHASE AMOUNT BY GENDER AND SUBSCRIPTION STATUS
SELECT
    gender,
    subscription_status,
    COUNT(*) AS number_of_records,
    ROUND(AVG(purchase_amount), 2) AS average_purchase_amount,
    SUM(purchase_amount) AS total_purchase_amount
FROM customer_shopping
GROUP BY gender, subscription_status
ORDER BY gender, subscription_status;