/*
======================================================================
Quality Checks
======================================================================
Script Purpose:
    This script performs various quality checks for  data consistency, accuracy,
    and standardization across the 'silver' schemas. It includes checks for:
    - Null or duplicate primary keys
    - Unwanted spaces in string fields
    - Data standardization and consistency
    - Invalid data ranges and orders
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading silver layer.
    - Investigate and resolve any discrepancies found during the checks.
======================================================================
*/

-- =====================================================================
-- Checking 'silver.crm_cust_info'
-- =====================================================================

--Check for Nulls or Duplicates in primary key
--Expectation: No Result

select 
cst_id,
COUNT(*)
from silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

select
*
from (
		select 
		* ,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) as Flag_last
		from bronze.crm_cust_info
		WHERE cst_id IS NOT NULL
	  )t
where Flag_last = 1;

--Check for Unwanted Spaces
--Expectation: No Result

select cst_firstname
from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname);

select cst_lastname
from silver.crm_cust_info
where cst_lastname != TRIM(cst_lastname);

select cst_marital_status
from silver.crm_cust_info
where cst_marital_status != TRIM(cst_marital_status);

select cst_gndr
from silver.crm_cust_info
where cst_gndr != TRIM(cst_gndr);

--Data Standardization and Consistency
--Expectation: No Result
select DISTINCT(cst_gndr)
from silver.crm_cust_info;

select DISTINCT(cst_marital_status)
from silver.crm_cust_info;

-- =====================================================================
-- Checking 'silver.crm_prd_info'
-- =====================================================================

--Check for Nulls or Duplicates in primary key
--Expectation: No Result
select 
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id IS NULL

--Check for Unwanted Spaces
--Expectation: No Result

select prd_nm
from silver.crm_prd_info
where prd_nm != TRIM(prd_nm);

--Check for NULLS or Negative numbers
--Expectation: No Result

select prd_cost
from silver.crm_prd_info
where prd_cost < 0 OR prd_cost IS NULL

--Data Standardization and Consistency
--Expectation: No Result
select DISTINCT(prd_line)
from silver.crm_prd_info;

--Check for Invalid Date Orders
select *
from silver.crm_prd_info
where prd_end_dt < prd_start_dt;   

select prd_key
from silver.crm_prd_info;

-- =====================================================================
-- Checking 'silver.crm_sales_details'
-- =====================================================================

--Testing data consistency between related fields.
select sls_prd_key
from bronze.crm_sales_details
where sls_prd_key 
NOT IN (select prd_key from silver.crm_prd_info);

--Check for Invalid Dates
--Expectation: No Result

select 
NULLIF(sls_order_dt, CAST(0 AS DATE)) AS sls_order_dt
from silver.crm_sales_details
where sls_order_dt <= 0 
OR LEN(NULLIF(sls_order_dt, 0)) != 8 --Checking the length to confirm if it can be converted into date or to identify any issues (if there) before conversion
OR sls_order_dt > 20500101 OR  sls_order_dt < 19000101 --Checking for outliers by validating the boundaries of date range

select 
*
from silver.crm_sales_details
where  sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt 

--Check for Nulls or zeroes or negative values in Sales, Quantity and Price
SELECT DISTINCT
       sls_sales 
      ,sls_quantity
      ,sls_price
from silver.crm_sales_details
where sls_sales <> sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales,sls_quantity,sls_price ;

 

