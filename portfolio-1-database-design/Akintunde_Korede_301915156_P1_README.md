# Portfolio 1: Database Design and Modelling

## 1. Case Study Description
* **Organisation Name / Scenario:** RanGo (Online E-commerce Platform)
* **Nature of Business:** A digital e-commerce marketplace enabling customers to browse product inventories, manage shopping carts, place online orders, process payments, and track shipments.
* **Database Users:** Customers (browse and buy), Warehouse Staff (update stock and fulfillment status), and System Administrators (manage users and system configuration).
* **Major Data Stored:** Customers, Categories, Products, Orders, Order Items, Payments, and Deliveries.
* **Key Operations:** Registering customer accounts, updating product stock quantities, placing orders, executing transactions, and retrieving order history.  

## Entity Definitions and Business Rules

### 1. Entity Definitions
* **Customer:** A registered user who buys items on RanGo.
* **Category:** A group used to organize products (e.g., Electronics).
* **Product:** An item available for sale.
* **Order:** A purchase record created by a customer.
* **Order_Item:** A bridge table that connects orders to specific products and tracks quantities.

### 2. Business Rules
* **Rule 1 (Customers & Orders):** One customer can place many orders, but each order belongs to only one customer.
* **Rule 2 (Categories & Products):** One category can have many products, but each product belongs to only one category.
* **Rule 3 (Orders & Products):** An order can contain many products, and a product can appear in many orders (managed through the `Order Items` table).
* **Rule 4 (Data Constraints):** 
  * Every table must have a unique ID (Primary Key).
  * Customer email addresses must be unique (no duplicate accounts).
  * Product stock and order quantities cannot be negative.

### Identify entities, attributes, keys and relationships
Entity,Information stored
customer,A registered buyer on the platform
category,A classification group for products
product,A specific item available for purchase
order,A high-level purchase record placed by a customer
order_item,An individual line item detailing product quantities and prices within an order
