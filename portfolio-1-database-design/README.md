# Portfolio 1: Database Design and Modelling - RanGo E-commerce

## 1. Case Study Description
[
CASE STUDY DESCRIPTION & REQUIREMENTS ANALYSIS
Case Study: E-commerce Platform
Organization Name: Rango
Nature of Business: A digital e-commerce marketplace enabling customers to browse product inventories, manage shopping carts, place online orders, process payments, and track shipments.
Database Users: Customers (browse and buy), Warehouse Staff (update stock and fulfillment status), and System Administrators (manage users and system configuration).   
Major Data Stored: Customers, Categories, Products, Orders, Order Items, Payments, and Deliveries
Key Operations: Registering customer accounts, updating product stock quantities, placing orders, executing transactions, and retrieving order history.   
]


## 2. Entity-Relationship (ER) Diagram
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




