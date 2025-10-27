1. What is the distribution of customers across different age groups?
(Group into categories: 18-25, 26-35, 36-45, 46-55, 55+)

SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END AS age_group,
    COUNT(*) as total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shopping_behavior_updated), 2) as percentage
FROM shopping_behavior_updated
GROUP BY age_group
ORDER BY age_group;

2. What is the average purchase amount and total revenue by gender?

SELECT 
    Gender,
    ROUND(AVG(`Purchase Amount (USD)`), 2) as avg_purchase_amount,
    COUNT(*) as total_transactions,
    SUM(`Purchase Amount (USD)`) as total_revenue
FROM shopping_behavior_updated
GROUP BY Gender
ORDER BY avg_purchase_amount DESC;

3. What are the top 5 best-selling products by total revenue?

SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END AS age_group,
    SUM(`Purchase Amount (USD)`) as total_revenue,
    COUNT(*) as total_sales
FROM shopping_behavior_updated
GROUP BY age_group
ORDER BY total_revenue DESC;

4. How is gender distributed within each age group?

SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END AS age_group,
    Gender,
    COUNT(*) as customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY 
        CASE 
            WHEN Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN Age BETWEEN 26 AND 35 THEN '26-35'
            WHEN Age BETWEEN 36 AND 45 THEN '36-45'
            WHEN Age BETWEEN 46 AND 55 THEN '46-55'
            ELSE '55+'
        END), 2) as percentage_in_age_group
FROM shopping_behavior_updated
GROUP BY age_group, Gender
ORDER BY age_group, customer_count DESC;

5. How can customers be segmented based on their spending levels, and what are the characteristics of each segment?

SELECT 
    CASE 
        WHEN `Purchase Amount (USD)` < 50 THEN 'Low Spender (<$50)'
        WHEN `Purchase Amount (USD)` BETWEEN 50 AND 100 THEN 'Medium Spender ($50-$100)'
        WHEN `Purchase Amount (USD)` BETWEEN 101 AND 200 THEN 'High Spender ($101-$200)'
        ELSE 'VIP Spender (>$200)'
    END AS spending_segment,
    COUNT(*) as customer_count,
    ROUND(AVG(Age), 1) as avg_age,
    ROUND(AVG(`Purchase Amount (USD)`), 2) as avg_purchase_amount
FROM shopping_behavior_updated
GROUP BY spending_segment
ORDER BY AVG(`Purchase Amount (USD)`) DESC;

6. How does purchase amount vary across different age brackets?

SELECT 
    CASE 
        WHEN Age < 30 THEN 'Under 30'
        WHEN Age BETWEEN 30 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        WHEN Age BETWEEN 51 AND 60 THEN '51-60'
        ELSE 'Over 60'
    END AS age_bracket,
    ROUND(AVG(`Purchase Amount (USD)`), 2) as avg_purchase_amount,
    MIN(`Purchase Amount (USD)`) as min_purchase,
    MAX(`Purchase Amount (USD)`) as max_purchase,
    COUNT(*) as total_customers
FROM shopping_behavior_updated
GROUP BY age_bracket
ORDER BY avg_purchase_amount DESC;

7. What are the spending patterns and demographic characteristics by gender?

SELECT 
    Gender,
    ROUND(AVG(`Purchase Amount (USD)`), 2) as avg_purchase_amount,
    ROUND(MIN(`Purchase Amount (USD)`), 2) as min_purchase,
    ROUND(MAX(`Purchase Amount (USD)`), 2) as max_purchase,
    ROUND(AVG(Age), 1) as avg_age,
    COUNT(*) as total_customers
FROM shopping_behavior_updated
GROUP BY Gender;

8. Who are the top 10 highest spending individuals and what are their demographics?

SELECT 
    Age,
    Gender,
    `Purchase Amount (USD)` as purchase_amount
FROM shopping_behavior_updated
ORDER BY `Purchase Amount (USD)` DESC
LIMIT 10;

9. How do purchase behaviors differ when analyzing age and gender together?

SELECT 
    Gender,
    CASE 
        WHEN Age < 25 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS age_range,
    COUNT(*) as customer_count,
    ROUND(AVG(`Purchase Amount (USD)`), 2) as avg_purchase_amount,
    SUM(`Purchase Amount (USD)`) as total_revenue
FROM shopping_behavior_updated
GROUP BY Gender, age_range
ORDER BY Gender, age_range;

10. How can we segment customers based on their value, and what percentage falls into each segment?

SELECT 
    CASE 
        WHEN `Purchase Amount (USD)` <= 50 THEN 'Low Value'
        WHEN `Purchase Amount (USD)` <= 100 THEN 'Medium Value'
        WHEN `Purchase Amount (USD)` <= 200 THEN 'High Value'
        ELSE 'Premium Value'
    END AS customer_segment,
    COUNT(*) as segment_size,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM shopping_behavior_updated), 2) as percentage,
    ROUND(AVG(Age), 1) as avg_age,
    ROUND(AVG(`Purchase Amount (USD)`), 2) as avg_purchase_amount
FROM shopping_behavior_updated
GROUP BY customer_segment
ORDER BY avg_purchase_amount DESC;
