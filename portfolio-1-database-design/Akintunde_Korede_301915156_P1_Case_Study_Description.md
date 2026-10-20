# Portfolio 1: Database Design and Modelling

## Case Study Description
* **Organisation Name / Scenario:** RanGo (Online E-commerce Platform)
* **Nature of Business:** A digital e-commerce marketplace enabling customers to browse product inventories, manage shopping carts, place online orders, process payments, and track shipments.
* **Database Users:** Customers (browse and buy), Warehouse Staff (update stock and fulfillment status), and System Administrators (manage users and system configuration).
* **Major Data Stored:** Customers, Categories, Products, Orders, Order Items, Payments, and Deliveries.
* **Key Operations:** Registering customer accounts, updating product stock quantities, placing orders, executing transactions, and retrieving order history.  






## Normalization Explanation
The RanGo database design is systematically normalized up to **Third Normal Form (3NF)** to eliminate redundancy and prevent anomalies:
* **First Normal Form (1NF):** Ensures atomicity by eliminating repeating groups and multi-valued attributes, ensuring every table cell contains a single, indivisible value.
* **Second Normal Form (2NF):** Ensures the table is in 1NF and all non-key attributes are fully functionally dependent on the primary key, removing partial dependencies.
* **Third Normal Form (3NF):** Ensures the table is in 2NF and removes transitive dependencies, ensuring non-key attributes depend *only* on the primary key (e.g., separating Categories into its own table rather than repeating category names inside the Products table).
