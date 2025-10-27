1. Age & Gender Spending Patterns
Identify which age and gender combinations have the highest purchasing power and average transaction value.

SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35' 
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END as Age_Group,
    Gender,
    COUNT(*) as total_clientes,
    AVG(`Purchase Amount (USD)`) as valor_medio_compra,
    SUM(`Purchase Amount (USD)`) as valor_total_gasto
FROM shopping_behavior_updated 
GROUP BY Age_Group, Gender 
ORDER BY valor_medio_compra DESC;

2. Payment Method Preferences by Generation
Analyze how payment method preferences evolve across different age groups and their correlation with purchase amounts.



3. Category Performance by Age Segment
Determine which product categories generate the highest revenue from different age segments and their satisfaction levels.



4. Subscription Impact on Customer Value
Measure how subscription status and purchase frequency affect spending behavior across different demographic segments.



5. Discount Effectiveness Analysis
Evaluate how discounts and promo codes impact purchase behavior and total revenue across age groups and genders.



6. Seasonal Shopping Behavior by Demographics
Understand how seasonal trends affect purchasing patterns, spending, and satisfaction across different age segments.



7. Shipping Preferences & Customer Satisfaction
Analyze the relationship between shipping methods, customer satisfaction, and spending behavior by demographic segments.



8. Geographic High-Value Customer Mapping
Identify locations with the highest-value customers and understand their demographic characteristics and purchasing power.



9. Purchase Frequency vs. Spending Analysis
Examine the correlation between purchase frequency and average transaction value across different customer segments.



10. Customer Segment Performance Ranking
Rank customer segments by key performance indicators to identify the most valuable demographic combinations for targeted marketing.