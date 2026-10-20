# RanGo Normalisation

## Unnormalised Form (UNF)
A table is unnormalised if it contains repeating groups or multi-valued attributes.
* **Atomic value:** A single, indivisible piece of data.
* **Repeating group:** Multiple values crammed into a single row cell.

| order_id | customer_name | customer_email | product_name | category_name | quantity | unit_price |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 101 | Alice Smith | alice@mail.com | Wireless Mouse <br> USB-C Cable | Electronics <br> Electronics | 1 <br> 2 | 25.00 <br> 10.00 |
| 102 | Bob Jones | bob@mail.com | Cotton T-Shirt | Fashion | 3 | 15.00 |

*Problem:* Order 101 contains multiple products and quantities in one row, causing data duplication and update anomalies.

---

## First Normal Form (1NF)
A table is in First Normal Form when every column contains atomic values and there are no repeating groups.
* **Atomicity:** Ensuring every cell holds a single value.

| order_id | customer_name | customer_email | product_name | category_name | quantity | unit_price |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 101 | Alice Smith | alice@mail.com | Wireless Mouse | Electronics | 1 | 25.00 |
| 101 | Alice Smith | alice@mail.com | USB-C Cable | Electronics | 2 | 10.00 |
| 102 | Bob Jones | bob@mail.com | Cotton T-Shirt | Fashion | 3 | 15.00 |

*What moved and why:* Product details expanded into individual rows, eliminating repeating list cells.

---

## Second Normal Form (2NF)
A table is in Second Normal Form when it is in 1NF and all non-key attributes depend fully on the primary key (no partial dependencies).
* **Functional dependency:** When one attribute uniquely determines another.
* **Partial dependency:** When a non-key attribute depends on only part of a composite primary key.

### Customers Table
| customer_id (PK) | customer_name | customer_email |
| :--- | :--- | :--- |
| 1 | Alice Smith | alice@mail.com |
| 2 | Bob Jones | bob@mail.com |

### Products Table
| product_id (PK) | product_name | category_name | price |
| :--- | :--- | :--- | :--- |
| 50 | Wireless Mouse | Electronics | 25.00 |
| 51 | USB-C Cable | Electronics | 10.00 |
| 52 | Cotton T-Shirt | Fashion | 15.00 |

### Orders Table
| order_id (PK) | customer_id (FK) | order_date |
| :--- | :--- | :--- |
| 101 | 1 | 2026-10-20 |
| 102 | 2 | 2026-10-21 |

*What moved and why:* Customer and product attributes moved to dedicated tables based on single-key dependencies, removing partial dependencies.

---

## Third Normal Form (3NF)
A table is in Third Normal Form when it is in 2NF and has no transitive dependencies.
* **Transitive dependency:** When a non-key column depends on another non-key column rather than directly on the primary key.

### Categories Table
| category_id (PK) | category_name |
| :--- | :--- |
| 1 | Electronics |
| 2 | Fashion |

### Products Table
| product_id (PK) | category_id (FK) | product_name | price |
| :--- | :--- | :--- | :--- |
| 50 | 1 | Wireless Mouse | 25.00 |
| 51 | 1 | USB-C Cable | 10.00 |
| 52 | 2 | Cotton T-Shirt | 15.00 |

### Orders Table
| order_id (PK) | customer_id (FK) | order_status |
| :--- | :--- | :--- |
| 101 | 1 | Pending |
| 102 | 2 | Processing |

### Order_Items Table
| order_item_id (PK) | order_id (FK) | product_id (FK) | quantity | unit_price |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 101 | 50 | 1 | 25.00 |
| 2 | 101 | 51 | 2 | 10.00 |
| 3 | 102 | 52 | 3 | 15.00 |

*What moved and why:* Category names moved to a `Categories` table to eliminate transitive dependencies, and `Order_Items` was introduced to handle the many-to-many relationship between orders and products using foreign keys.
