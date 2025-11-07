--Whole table.
select*
from sales;

--Revenue per transaction
SELECT transaction_id,
        transaction_qty*Unit_price AS Revenue
FROM sales;

--Total number of sales
SELECT COUNT(transaction_id) AS Number_of_transactions
FROM sales;

--Number of different shops
SELECT COUNT(distinct store_id) AS number_of_shops
FROM sales;

--Name of different store location
SELECT Distinct store_location,
                store_id
FROm sales;

--Revenue by store location
SELECT store_location,
        SUM(transaction_qty*unit_price) AS revenue
FROM sales
GROUP BY store_location;

--Time store opens 
SELECT MIN(transaction_time) AS opening_time
FROM sales;

--Time store closes
SELECT MAX(transaction_time) AS closing_time
FROM sales;

--Time buckets
SELECT 
    product_category,
    store_location,
    transaction_date,
    transaction_time,
    CASE 
        WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
        WHEN transaction_time BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
        WHEN transaction_time BETWEEN '16:00:00' AND '19:59:59' THEN 'Evening'
        ELSE 'Night'
    END AS time_buckets,
    SUM(transaction_qty * unit_price) AS revenue
FROM sales
WHERE transaction_date > '2023-05-01'
GROUP BY 
    product_category,
    store_location,
    transaction_date,
    transaction_time,
    time_buckets
ORDER BY revenue DESC;
