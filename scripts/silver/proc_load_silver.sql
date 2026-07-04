
/*
======================================================================
Stored Procedure : Load Silver Layer (Bronze -> Silver)
======================================================================
Script Purpose:
    This stored procedure loads data into the 'silver' schema from external csv files.
    It performs the following actions:
    - Truncates the silver tables before loading the data
    - Uses the BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
    None
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
======================================================================
*/
