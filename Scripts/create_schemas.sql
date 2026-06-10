create schema staging;
create schema warehouse;
create schema analytics;

select schema_name from information_schema.schemata;

/*
Project: End-to-End Retail Sales Analytics

Author: Manish
Database: PostgreSQL

Purpose:
To create the stages for subsequent table creation and data loading and analysing
into different phases.
*/

