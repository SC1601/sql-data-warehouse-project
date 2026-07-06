



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
-- Create fact table: gold.fact_sales
--=================================================

  --Foreign key integrity (dimensions)

  Select * 
  from gold.fact_sales f
  LEFT JOIN gold.dim_customers c
  ON c.customer_key = f.customer_key
  LEFT JOIN gold.dim_products p
  ON p.product_key = f.product_key
  where p.product_key IS NULL
