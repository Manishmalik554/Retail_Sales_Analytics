SELECT COUNT(*) FROM staging.customers;
SELECT COUNT(*) FROM staging.orders;
SELECT COUNT(*) FROM staging.order_items;
SELECT COUNT(*) FROM staging.products;
SELECT COUNT(*) FROM staging.sellers;
SELECT COUNT(*) FROM staging.payments;
SELECT COUNT(*) FROM staging.reviews;
SELECT COUNT(*) FROM staging.geolocation;
SELECT COUNT(*) FROM staging.category_translation;


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
5. Orphan records
6. Date consistency checks
7. Business rule validation

Outcome:
Ensure source data quality before ETL processing
and fact/dimension table creation.

=========================================================
*/