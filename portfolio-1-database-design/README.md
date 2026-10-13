# Portfolio 1: Database Design and Modelling - RanGo E-commerce

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

RanGo Relational Schema Definition

The conceptual ER model is translated into the following logical relational schema, detailing all tables, columns, data types, and constraints:
1. Customers Table

Stores registered user profile details.

    customer_id : INT (Primary Key)

    first_name : VARCHAR(50) (NOT NULL)

    last_name : VARCHAR(50) (NOT NULL)

    email : VARCHAR(100) (UNIQUE, NOT NULL)

    created_at : TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

2. Categories Table

Organizes products into logical groups.

    category_id : INT (Primary Key)

    category_name : VARCHAR(50) (NOT NULL)

3. Products Table

Stores the items available for sale in the marketplace.

    product_id : INT (Primary Key)

    category_id : INT (Foreign Key references Categories.category_id)

    product_name : VARCHAR(100) (NOT NULL)

    price : DECIMAL(10,2) (NOT NULL)

    stock_quantity : INT (NOT NULL, CHECK >= 0)

4. Orders Table

Tracks high-level orders placed by customers.

    order_id : INT (Primary Key)

    customer_id : INT (Foreign Key references Customers.customer_id)

    order_date : TIMESTAMP (DEFAULT CURRENT_TIMESTAMP)

    total_amount : DECIMAL(10,2) (NOT NULL)

    order_status : VARCHAR(20) (DEFAULT 'Pending')

5. Order_Items Table

Resolves the many-to-many relationship between orders and products.

    order_item_id : INT (Primary Key)

    order_id : INT (Foreign Key references Orders.order_id)

    product_id : INT (Foreign Key references Products.product_id)

    quantity : INT (NOT NULL, CHECK > 0)

    unit_price : DECIMAL(10,2) (NOT NULL)
