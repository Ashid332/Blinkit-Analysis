-- ============================================================
-- Blinkit Analysis: SQL Queries
-- ============================================================
-- These queries demonstrate analytical SQL skills for exploring
-- the Blinkit grocery sales dataset

-- Query 1: Total sales by outlet type
-- Shows revenue contribution by outlet type with transaction counts
SELECT 
    outlet_type,
    COUNT(*) as transaction_count,
    SUM(item_outlet_sales) as total_sales,
    ROUND(AVG(item_outlet_sales), 2) as avg_sales,
    ROUND(MIN(item_outlet_sales), 2) as min_sales,
    ROUND(MAX(item_outlet_sales), 2) as max_sales
FROM blinkit_sales
GROUP BY outlet_type
ORDER BY total_sales DESC;

-- Query 2: Sales analysis by product fat content
-- Analyzes revenue impact of product fat content categories
SELECT 
    item_fat_content,
    COUNT(DISTINCT item_type) as unique_categories,
    COUNT(*) as total_items,
    ROUND(SUM(item_outlet_sales), 2) as total_sales,
    ROUND(AVG(item_outlet_sales), 2) as avg_sales,
    ROUND(STDDEV(item_outlet_sales), 2) as sales_std_dev
FROM blinkit_sales
GROUP BY item_fat_content
ORDER BY total_sales DESC;

-- Query 3: Top 10 product categories by revenue
-- Identifies highest revenue-generating product categories
SELECT 
    item_type,
    COUNT(*) as items_sold,
    ROUND(SUM(item_outlet_sales), 2) as total_sales,
    ROUND(AVG(item_outlet_sales), 2) as avg_sales,
    ROUND(MAX(item_outlet_sales), 2) as max_sale
FROM blinkit_sales
GROUP BY item_type
ORDER BY total_sales DESC
LIMIT 10;

-- Query 4: Location type impact on sales
-- Compares performance across urban, suburban, and rural locations
SELECT 
    outlet_location_type,
    COUNT(DISTINCT outlet_identifier) as outlet_count,
    COUNT(*) as total_transactions,
    ROUND(SUM(item_outlet_sales), 2) as total_sales,
    ROUND(AVG(item_outlet_sales), 2) as avg_transaction_value,
    ROUND(SUM(item_outlet_sales) / COUNT(DISTINCT outlet_identifier), 2) as sales_per_outlet
FROM blinkit_sales
GROUP BY outlet_location_type
ORDER BY total_sales DESC;

-- Query 5: Visibility impact on sales performance
-- Demonstrates correlation between product shelf visibility and sales
SELECT 
    CASE 
        WHEN item_visibility = 0 THEN 'No Visibility'
        WHEN item_visibility <= 0.05 THEN 'Very Low (0-5%)'
        WHEN item_visibility <= 0.10 THEN 'Low (5-10%)'
        WHEN item_visibility <= 0.15 THEN 'Medium (10-15%)'
        ELSE 'High (15%+)'
    END as visibility_category,
    COUNT(*) as items,
    ROUND(AVG(item_outlet_sales), 2) as avg_sales,
    ROUND(SUM(item_outlet_sales), 2) as total_sales
FROM blinkit_sales
GROUP BY visibility_category
ORDER BY avg_sales DESC;

-- Query 6: Outlet size performance analysis
-- Compares sales across different outlet sizes
SELECT 
    outlet_size,
    COUNT(DISTINCT outlet_identifier) as outlet_count,
    COUNT(*) as total_transactions,
    ROUND(SUM(item_outlet_sales), 2) as total_sales,
    ROUND(AVG(item_outlet_sales), 2) as avg_sales_per_item,
    ROUND(SUM(item_outlet_sales) / COUNT(DISTINCT outlet_identifier), 2) as avg_sales_per_outlet
FROM blinkit_sales
WHERE outlet_size IS NOT NULL
GROUP BY outlet_size
ORDER BY total_sales DESC;

-- Query 7: Product MRP impact (price point analysis)
-- Shows sales distribution across different product price points
SELECT 
    CASE
        WHEN item_mrp < 50 THEN 'Budget (<50)'
        WHEN item_mrp < 100 THEN 'Value (50-100)'
        WHEN item_mrp < 150 THEN 'Mid-Range (100-150)'
        ELSE 'Premium (150+)'
    END as price_segment,
    COUNT(*) as items_sold,
    ROUND(SUM(item_outlet_sales), 2) as total_sales,
    ROUND(AVG(item_outlet_sales), 2) as avg_sales,
    ROUND(AVG(item_mrp), 2) as avg_price
FROM blinkit_sales
GROUP BY price_segment
ORDER BY total_sales DESC;

-- Query 8: Combined analysis - Outlet type and location impact
-- Multi-dimensional analysis showing outlet type performance by location
SELECT 
    outlet_type,
    outlet_location_type,
    COUNT(DISTINCT outlet_identifier) as outlet_count,
    COUNT(*) as transactions,
    ROUND(SUM(item_outlet_sales), 2) as total_sales,
    ROUND(AVG(item_outlet_sales), 2) as avg_sales,
    ROUND(SUM(item_outlet_sales) / COUNT(DISTINCT outlet_identifier), 2) as sales_per_outlet
FROM blinkit_sales
GROUP BY outlet_type, outlet_location_type
ORDER BY total_sales DESC;
