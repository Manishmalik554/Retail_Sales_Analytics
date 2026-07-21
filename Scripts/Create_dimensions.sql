CREATE TABLE warehouse.dim_customer as 
select distinct 
	customer_id, 
	customer_unique_id, 
	customer_city, 
	customer_state
from staging.customers;

Select count(*) from warehouse.dim_customer;


CREATE TABLE warehouse.dim_seller AS
SELECT DISTINCT
    seller_id,
    seller_city,
    seller_state
FROM staging.sellers;

SELECT COUNT(*) FROM warehouse.dim_seller;


CREATE TABLE warehouse.dim_product AS
SELECT
    p.product_id,
    COALESCE(
        ct.product_category_name_english,
        p.product_category_name
    ) AS product_category,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM staging.products p
LEFT JOIN staging.category_translation ct
ON p.product_category_name = ct.product_category_name;

SELECT COUNT(*) FROM warehouse.dim_product;

CREATE TABLE warehouse.dim_date AS
SELECT DISTINCT
    DATE(order_purchase_timestamp) AS order_date,

    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,

    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,

    TO_CHAR(order_purchase_timestamp,'Month') AS month_name,

    EXTRACT(QUARTER FROM order_purchase_timestamp) AS quarter,

    EXTRACT(WEEK FROM order_purchase_timestamp) AS week,

    EXTRACT(DOW FROM order_purchase_timestamp) AS day_of_week,

    TO_CHAR(order_purchase_timestamp,'Day') AS day_name

FROM staging.orders
WHERE order_purchase_timestamp IS NOT NULL;


CREATE TABLE warehouse.dim_payment AS
SELECT DISTINCT
    payment_type
FROM staging.payments;

SELECT *
FROM warehouse.dim_payment;


ALTER TABLE warehouse.dim_payment
ADD CONSTRAINT pk_dim_payment
PRIMARY KEY(payment_type);

ALTER TABLE warehouse.dim_customer
ADD CONSTRAINT pk_dim_customer
PRIMARY KEY (customer_id);

ALTER TABLE warehouse.dim_product
ADD CONSTRAINT pk_dim_product
PRIMARY KEY (product_id);

ALTER TABLE warehouse.dim_seller
ADD CONSTRAINT pk_dim_seller
PRIMARY KEY (seller_id);

ALTER TABLE warehouse.dim_date
ADD CONSTRAINT pk_dim_date
PRIMARY KEY (order_date);
