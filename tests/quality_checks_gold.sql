/*
======================================================================
Quality Checks
======================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency
    and accuracy of the Gold layer. These checks ensure:
    - Uniqueness of surrogate keys in dimension tables
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model for analytical purposes.

Usage Notes:
    - Run these checks after data loading silver and gold layer.
    - Investigate and resolve any discrepancies found during the checks.
======================================================================
*/

--================================================
-- Create fact table: gold.dim_customers
--=================================================

--Check data integrity, clean and remove invalid values

SELECT DISTINCT
       ci.cst_gndr,
       ca.gen AS gen_details,
       CASE WHEN ci.cst_gndr != 'N/A' THEN ci.cst_gndr   --CRM is the master for gender info
            ELSE COALESCE(ca.gen, 'N/A')
       END AS correct_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON         ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON         ci.cst_key = la.cid

--================================================
-- Create fact table: gold.dim_products
--=================================================

--Check uniqueness of product key
       
select product_key, count(*) 
from gold.dim_products
group by product_key
having count(*) > 1

--================================================
-- Create fact table: gold.fact_sales
--=================================================

  --Foreign key integrity (dimensions)

  Select * 
  from gold.fact_sales f
  LEFT JOIN gold.dim_customers c
  ON c.customer_key = f.customer_key
  LEFT JOIN gold.dim_products p
  ON p.product_key = f.product_key
  where p.product_key IS NULL or c.customer_key IS NULL
