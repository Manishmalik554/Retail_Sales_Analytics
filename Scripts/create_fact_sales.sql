/*
=========================================================
Aggregate payment information to one row per order
to preserve the grain of the fact table.
=========================================================
*/

CREATE TEMP TABLE payment_summary AS
SELECT
    order_id,
    SUM(payment_value) AS payment_value,
    MAX(payment_installments) AS payment_installments,
    CASE
        WHEN COUNT(DISTINCT payment_type)=1
        THEN MAX(payment_type)
        ELSE 'Multiple'
    END AS payment_type
FROM staging.payments
GROUP BY order_id;

Select Count(*) from payment_summary;

Select * from payment_summary limit 10;

/*
=========================================================
Join Orders, Order Items and Payment Summary
to validate the final dataset before creating
the fact table.
=========================================================
*/

SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    DATE(o.order_purchase_timestamp) AS order_date,
    o.order_status,
    ps.payment_type,
    ps.payment_installments,
    ps.payment_value,
    oi.price,
    oi.freight_value
FROM staging.order_items oi
INNER JOIN staging.orders o
    ON oi.order_id = o.order_id
LEFT JOIN payment_summary ps
    ON oi.order_id = ps.order_id;


--Validating revenue so there are no duplicates introduced in the fact tables.
SELECT
    ROUND(SUM(price),2) AS total_sales,
    ROUND(SUM(freight_value),2) AS total_freight
FROM (SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    DATE(o.order_purchase_timestamp) AS order_date,
    o.order_status,
    ps.payment_type,
    ps.payment_installments,
    ps.payment_value,
    oi.price,
    oi.freight_value
FROM staging.order_items oi
INNER JOIN staging.orders o
    ON oi.order_id = o.order_id
LEFT JOIN payment_summary ps
    ON oi.order_id = ps.order_id
) AS fact_preview;


SELECT
SUM(price),
SUM(freight_value)
FROM staging.order_items;

------------------------------------------------------------------

Select count(*), sum(price) as Total_Sale, sum(freight_value) as Freight_Value from staging.order_items;



/*
=========================================================
Create the central fact table of the Retail Sales
Data Warehouse.

=========================================================
*/

CREATE TABLE warehouse.fact_sales AS
SELECT
    oi.order_id,
    oi.order_item_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    DATE(o.order_purchase_timestamp) AS order_date,
    o.order_status,
    ps.payment_type,
    ps.payment_installments,
    ps.payment_value,
    oi.price,
    oi.freight_value
FROM staging.order_items oi
INNER JOIN staging.orders o
    ON oi.order_id = o.order_id
LEFT JOIN payment_summary ps
    ON oi.order_id = ps.order_id;


ALTER TABLE warehouse.fact_sales
ADD CONSTRAINT pk_fact_sales
PRIMARY KEY (order_id, order_item_id);

ALTER TABLE warehouse.fact_sales
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES warehouse.dim_customer(customer_id);

ALTER TABLE warehouse.fact_sales
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id)
REFERENCES warehouse.dim_product(product_id);

ALTER TABLE warehouse.fact_sales
ADD CONSTRAINT fk_seller
FOREIGN KEY (seller_id)
REFERENCES warehouse.dim_seller(seller_id);

ALTER TABLE warehouse.fact_sales
ADD CONSTRAINT fk_date
FOREIGN KEY (order_date)
REFERENCES warehouse.dim_date(order_date);

CREATE INDEX idx_fact_sales_customer
ON warehouse.fact_sales(customer_id);

CREATE INDEX idx_fact_sales_product
ON warehouse.fact_sales(product_id);

CREATE INDEX idx_fact_sales_seller
ON warehouse.fact_sales(seller_id);

CREATE INDEX idx_fact_sales_date
ON warehouse.fact_sales(order_date);


select * from warehouse.dim_customer
