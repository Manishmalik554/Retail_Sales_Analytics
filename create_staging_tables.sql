create table staging.customers(
customer_id varchar(50), 
customer_unique_id varchar(50), 
customer_zip_code_prefix integer, 
customer_city varchar(100), 
customer_state varchar(10)
);

create table staging.orders(
order_id varchar(50), 
customer_id varchar(50), 
order_status varchar(30), 
order_purchase_timestamp timestamp, 
order_approved_at timestamp, 
order_delivered_carrier_date TIMESTAMP,
order_delivered_customer_date TIMESTAMP,
order_estimated_delivery_date TIMESTAMP
);


CREATE TABLE staging.order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2)
);

CREATE TABLE staging.products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);


CREATE TABLE staging.sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INTEGER,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

CREATE TABLE staging.payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(50),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2)
);

CREATE TABLE staging.reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE staging.geolocation (
    geolocation_zip_code_prefix INTEGER,
    geolocation_lat NUMERIC(12,8),
    geolocation_lng NUMERIC(12,8),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

CREATE TABLE staging.category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);



/*
Project: End-to-End Retail Sales Analytics

Author: Manish
Database: PostgreSQL

Purpose:
Create Olist e-commerce data tables to import data in staging layer
for subsequent data quality checks and dimensional modeling.
*/
