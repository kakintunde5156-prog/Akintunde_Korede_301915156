# Portfolio 1: Database Design and Modelling

## Case Study Description
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

## 3. Database Design Details
### Entities
I chose five entities for my e-commerce platform:

| Entity | Information stored |
| :--- | :--- |
| **customer** | A registered buyer on the platform |
| **category** | A classification group for products |
| **product** | A specific item available for purchase |
| **order** | A high-level purchase record placed by a customer |
| **order_item** | An individual line item detailing product quantities and prices within an order |

*Design note:* I kept `product` and `order_item` separate. For example, an order can contain three different products. I record the order summary once in `order` and use `order_item` to list each individual product bought, its quantity, and its unit price at the time of purchase.

### Attributes and Keys
*In the tables below, **unique** means no repeated values. **Required** means the value cannot be `NULL` (missing).*

| Entity | Attributes and proposed PostgreSQL types | Keys and required values |
| :--- | :--- | :--- |
| **customer** | `customer_id BIGINT`, `first_name VARCHAR(50)`, `last_name VARCHAR(50)`, `email VARCHAR(254)`, `created_at TIMESTAMPTZ` | PK: `customer_id`. Unique: `email`. All required. |
| **category** | `category_id BIGINT`, `category_name VARCHAR(50)` | PK: `category_id`. Unique: `category_name`. All required. |
| **product** | `product_id BIGINT`, `category_id BIGINT`, `product_name VARCHAR(100)`, `price DECIMAL(10,2)`, `stock_quantity INT` | PK: `product_id`. FK: `category_id` -> `category.category_id`. All required. |
| **order** | `order_id BIGINT`, `customer_id BIGINT`, `order_date TIMESTAMPTZ`, `total_amount DECIMAL(10,2)`, `order_status VARCHAR(20)` | PK: `order_id`. FK: `customer_id` -> `customer.customer_id`. All required. |
| **order_item** | `order_item_id BIGINT`, `order_id BIGINT`, `product_id BIGINT`, `quantity INT`, `unit_price DECIMAL(10,2)` | PK: `order_item_id`. FKs: `order_id` -> `order.order_id`, `product_id` -> `product.product_id`. All required. |

### Relationships
| Tables linked | Relationship | Meaning |
| :--- | :--- | :--- |
| **category -> product** | One to many | A category can have zero or more products; each product belongs to exactly one category. |
| **customer -> order** | One to many | A customer can place zero or more orders; each order belongs to exactly one customer. |
| **order -> order_item** | One to many | An order contains one or more order items; each order item belongs to exactly one order. |
| **product -> order_item** | One to many | A product can appear in zero or more order items; each order item refers to exactly one product. |

## Entity-Relationship (ER) Diagram
Below is the Entity-Relationship Diagram for the RanGo database:

```mermaid
erDiagram
    CUSTOMERS ||--o{ ORDERS : "Places"
    CATEGORIES ||--|{ PRODUCTS : "Contains"
    PRODUCTS ||--o{ ORDER_ITEMS : "Includes"
    ORDERS ||--|{ ORDER_ITEMS : "Contains"

    CUSTOMERS {
        int customer_id PK
        string first_name
        string last_name
        string email
    }
    CATEGORIES {
        int category_id PK
        string category_name
    }
    PRODUCTS {
        int product_id PK
        int category_id FK
        string product_name
        decimal price
        int stock_quantity
    }
    ORDERS {
        int order_id PK
        int customer_id FK
        timestamp order_date
        decimal total_amount
        string order_status
    }
    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal unit_price
    }
```

## Relational Schema Definition
The conceptual ER model is translated into the following logical relational schema:

1. **Customers Table:** Stores registered user profile details.
   * `customer_id`: INT (Primary Key)
   * `first_name`: VARCHAR(50) (NOT NULL)
   * `last_name`: VARCHAR(50) (NOT NULL)
   * `email`: VARCHAR(100) (UNIQUE, NOT NULL)
   * `created_at`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

2. **Categories Table:** Organizes products into logical groups.
   * `category_id`: INT (Primary Key)
   * `category_name`: VARCHAR(50) (NOT NULL)

3. **Products Table:** Stores the items available for sale in the marketplace.
   * `product_id`: INT (Primary Key)
   * `category_id`: INT (Foreign Key references Categories.category_id)
   * `product_name`: VARCHAR(100) (NOT NULL)
   * `price`: DECIMAL(10,2) (NOT NULL)
   * `stock_quantity`: INT (NOT NULL, CHECK >= 0)

4. **Orders Table:** Tracks high-level orders placed by customers.
   * `order_id`: INT (Primary Key)
   * `customer_id`: INT (Foreign Key references Customers.customer_id)
   * `order_date`: TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)
   * `total_amount`: DECIMAL(10,2) (NOT NULL)
   * `order_status`: VARCHAR(20) (DEFAULT 'Pending')

5. **Order Items Table:** Resolves the many-to-many relationship between orders and products.
   * `order_item_id`: INT (Primary Key)
   * `order_id`: INT (Foreign Key references Orders.order_id)
   * `product_id`: INT (Foreign Key references Products.product_id)
   * `quantity`: INT (NOT NULL, CHECK > 0)
   * `unit_price` : DECIMAL(10,2) (NOT NULL)

## Normalization Explanation
The RanGo database design is systematically normalized up to **Third Normal Form (3NF)** to eliminate redundancy and prevent anomalies:
* **First Normal Form (1NF):** Ensures atomicity by eliminating repeating groups and multi-valued attributes, ensuring every table cell contains a single, indivisible value.
* **Second Normal Form (2NF):** Ensures the table is in 1NF and all non-key attributes are fully functionally dependent on the primary key, removing partial dependencies.
* **Third Normal Form (3NF):** Ensures the table is in 2NF and removes transitive dependencies, ensuring non-key attributes depend *only* on the primary key (e.g., separating Categories into its own table rather than repeating category names inside the Products table).
