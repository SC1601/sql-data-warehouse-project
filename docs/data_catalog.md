
# Data Dictionery for Gold Layer

## Overview

<sub>The gold layer is the business level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.</sub>

---

**1. gold.dim_customers**

- <sub>**Purpose:** </sub> <sub>Stores customer details enriched with demographic and geographical data </sub>
- <sub> **Columns:** </sub>

| <sub> Column Name </sub> | <sub> Data Type </sub> | <sub> Description </sub> 
| --- | --- | ---
| <sub> customer_key </sub> | <sub> INT </sub> | <sub> Surrogate key uniquely identifying each customer record in the dimension table </sub>
| <sub> customer_id </sub> | <sub> INT </sub>| <sub> Unique numerical identifier assigned to each customer </sub>
| <sub> customer_number </sub> | <sub> NVARCHAR(50) </sub>| <sub> Alphanumeric identifier representing the customer, used for tracking and referencing </sub>
| <sub> first_name </sub> | <sub> NVARCHAR(50) </sub>| <sub> The customer's first name, as recorded in the system </sub>
| <sub> last_name </sub> | <sub> NVARCHAR(50) </sub>| <sub> The customer's last name or family name </sub>
| <sub> country </sub>| <sub> NVARCHAR(50) </sub>| <sub> The country of residence for the customer (e.g., 'Australia') </sub>
| <sub> marital_status </sub>| <sub> NVARCHAR(50) </sub> | <sub> The marital status of the customer (e.g., 'Single', 'Married') </sub>
| <sub> gender </sub> | <sub> NVARCHAR(50) </sub>| <sub> The gender of the customer (e.g., 'Male', 'Female', 'N/A') </sub>
| <sub> birthdate </sub> | <sub> DATE </sub>| <sub> The date of birth of the customer formatted as YYYY-MM-DD (e.g., 1971-10-06) </sub>
| <sub> create_date </sub> | <sub> DATE </sub>| <sub> The date when the customer record was created in the system </sub>


**2. gold.dim_products**

- <sub> **Purpose:**  Provides information about the products and their attributes </sub>
- <sub> **Columns:** </sub>

| <sub> Column Name </sub> | <sub> Data Type </sub> | <sub> Description </sub>
| --- | --- | ---
| <sub> product_key </sub>| <sub> INT </sub> | <sub> Surrogate key uniquely identifying each product record in the product dimension table </sub>
| <sub> product_id </sub> | <sub> INT </sub>| <sub> A unique identifier assigned to the product for internal tracking and referencing </sub>
| <sub> product_number </sub> | <sub> NVARCHAR(50) </sub>| <sub> A structured alphanumeric code representing the product, often used for categorization and inventory </sub>
| <sub> product_name </sub> | <sub> NVARCHAR(50) </sub>| <sub> Descriptive name of the product, including key details such as type, color and size. </sub>
| <sub> category_id </sub> | <sub> NVARCHAR(50) </sub>| <sub> A unique identifier for the product's category, linking to is high-level classification. </sub>
| <sub> category </sub> | <sub> NVARCHAR(50) </sub>| <sub> The broader classification of the produdct (e.g., 'Bikes', 'Components') to group related items. </sub>
| <sub> subcategory </sub>| <sub> NVARCHAR(50) </sub>| <sub> A more detailed classification of the product within the category, such as product type. (e.g., 'Australia') </sub>
| <sub>  maintenance </sub>| <sub> NVARCHAR(50) </sub> | <sub> Indicates whether the product requires maintenance (e.g., 'Yes', 'No') </sub>
| <sub> cost </sub> | <sub> INT </sub>| <sub> The cost or base price of the product, measured in monetary units </sub>
| <sub> product_line </sub> | <sub> NVARCHAR(50) </sub>| <sub> The specific product line or series to which the product belongs (e.g., 'Road', 'Mountain') </sub>
| <sub> start_date </sub> | <sub> DATE </sub>| <sub> The date when the product became available for sale or use, stored in </sub>

**3. gold.fact_sales**

- <sub> **Purpose:** Stores transactional sales data for analytical purposes </sub>
- <sub> **Columns:** </sub>

| <sub> Column Name </sub> | <sub> Data Type </sub> | <sub> Description </sub>  
| --- | --- | ---
| <sub> order_number </sub> | <sub> NVARCHAR(50) </sub> | <sub> A unique alphanumeric identifier for each sales order (e.g., 'SO54496') </sub>
| <sub> product_key </sub> | <sub> INT </sub>| <sub> Surrogate key linking the order to the product dimension table. </sub>
| <sub> customer_key </sub> | <sub> INT </sub>| <sub> Surrogate key linking the order to the customer dimension table. </sub>
| <sub> order_date </sub> | <sub> DATE </sub>| <sub> The date when the order was placed. </sub>
| <sub> shipping_date </sub> | <sub> DATE </sub>| <sub> The date when the order was shipped to the customer. </sub>
| <sub> due_date </sub> | <sub> DATE </sub>| <sub> The date when the order payment was due. </sub>
| <sub> sales_amount </sub>| <sub> INT </sub>| <sub> The total monetary value of the sale for the line item, in whole currency units (e.g., 25) </sub>
| <sub>  quantity </sub>| <sub> INT </sub> | <sub> The number of units of the product ordered for the line item (e.g., 1) </sub>
| <sub> price </sub> | <sub> INT </sub>| <sub> The price per unit of the product for the line item, in whole currency units (e.g., 25) </sub>
