SELECT COUNT(*) FROM staging.customers;
SELECT COUNT(*) FROM staging.orders;
SELECT COUNT(*) FROM staging.order_items;
SELECT COUNT(*) FROM staging.products;
SELECT COUNT(*) FROM staging.sellers;
SELECT COUNT(*) FROM staging.payments;
SELECT COUNT(*) FROM staging.reviews;
SELECT COUNT(*) FROM staging.geolocation;
SELECT COUNT(*) FROM staging.category_translation;


-- Duplicate Detection
Select customer_id, count(*) 
from staging.customers 
group by customer_id
having count(*) > 1;

select order_id, count(*)
from staging.orders
group by order_id
having count(*) >1;

SELECT product_id, COUNT(*)
FROM staging.products
GROUP BY product_id
HAVING COUNT(*) > 1;


-- Missing Value Analysis

Select count(*) as total_products, 
count(product_category_name) as products
from staging.products;

SELECT
COUNT(*) AS total_orders,
COUNT(order_approved_at) AS approved_orders,
COUNT(order_delivered_customer_date) AS delivered_orders
FROM staging.orders;


-- Referential Integrity Checks

Select Count(*) from staging.orders o
Left Join staging.customers c
on o.customer_id = c.customer_id
where c.customer_id is null; -- orders without customers

Select count(*) from staging.order_items o
left join staging.products p
on o.product_id = p.product_id
where o.product_id is null; -- orders without products

select count(*) from staging.order_items o
Left Join staging.sellers s
on o.seller_id = s.seller_id
where s.seller_id is null; -- Order items without sellers


-- Date Consistency Checks

Select * 
from staging.orders
where order_approved_at < order_purchase_timestamp;

SELECT *
FROM staging.orders
WHERE order_delivered_carrier_date < order_purchase_timestamp; --166 Rows

SELECT *
FROM staging.orders
WHERE order_delivered_customer_date < order_delivered_carrier_date; --23 Rows


SELECT *
FROM staging.orders
WHERE order_delivered_customer_date < order_approved_at; -- 61 Rows


SELECT *
FROM staging.orders
WHERE order_estimated_delivery_date < order_purchase_timestamp;

SELECT
MIN(order_delivered_customer_date - order_purchase_timestamp) AS min_days,
MAX(order_delivered_customer_date - order_purchase_timestamp) AS max_days,
AVG(order_delivered_customer_date - order_purchase_timestamp) AS avg_days
FROM staging.orders
WHERE order_delivered_customer_date IS NOT NULL; --understanding of shipping performance


-- Business validation

Select order_status, 
count(*) as total_orders
from staging.orders 
Group by order_status
Order by total_orders desc;


-- Revenue Sanity Check

Select 
Round(sum(price), 2) as total_product_revenue, 
round(sum(freight_value), 2) as total_shipping_revenue
from staging.order_items;



/*
=========================================================
Project : End-to-End Retail Sales Analytics
Author  : Manish
Database: PostgreSQL

File    : 04_data_validation.sql

Purpose :
Validate the integrity and completeness of raw data
loaded into the staging layer before transformation
into the dimensional warehouse model.

Validation Checks:
1. Record count verification
2. NULL value analysis
3. Duplicate key detection
4. Missing customer/product/seller references
5. Date consistency checks
6. Business rule validation
7. Revenue Sanity Check 

Outcome:
Ensure source data quality before ETL processing
and fact/dimension table creation.

Data Quality Findings:

- 166 orders (0.17%) showed carrier pickup timestamps earlier than purchase timestamps.
- 23 orders (0.02%) showed delivery timestamps earlier than carrier pickup timestamps.
- 61 orders (0.06%) showed delivery timestamps earlier than order approval timestamps.

Due to the negligible percentage of affected records (<0.2%), records were retained and documented for transparency.

=========================================================
*/