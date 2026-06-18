


COPY staging.customers
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;


COPY staging.orders
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;


COPY staging.products
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;


COPY staging.sellers
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;


COPY staging.order_items
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;


COPY staging.payments
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;


COPY staging.reviews
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;


COPY staging.category_translation
FROM 'E:\Projects\retail_sale_analysis\Dataset\product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;


COPY staging.geolocation
FROM 'E:\Projects\retail_sale_analysis\Dataset\olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;


/*
Project: End-to-End Retail Sales Analytics

Author: Manish
Database: PostgreSQL

Purpose:
Load raw Olist e-commerce data into staging layer
for subsequent data quality checks and dimensional modeling.
*/




	