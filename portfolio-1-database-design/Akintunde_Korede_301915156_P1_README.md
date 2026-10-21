## Design and implementation files

| File | Contents |
| :--- | :--- |
| [Design](portfolio-1-database-design/Akintunde_Korede_301915156_P1_Entities_Attributes_Keys_and_Relationships.md) | Entities, attributes, keys and relationships for RanGo. |
| [ER diagram](portfolio-1-database-design/Akintunde_Korede_301915156_P1_ERDiagram.md) | The five e-commerce tables and their relationships. |
| [Normalisation](portfolio-1-database-design/Akintunde_Korede_301915156_P1_Normalization.md) | Example tables showing 1NF, 2NF and 3NF. |
| [Schema](portfolio-1-database-design/Akintunde_Korede_301915156_P1_Schema.sql) | PostgreSQL table definitions, keys and constraints. |
| [Sample records](portfolio-1-database-design/Akintunde_Korede_301915156_P1_SampleData.sql) | Fictional customers, categories, products, orders, and order items. |
| [Constraint tests](portfolio-1-database-design/Akintunde_Korede_301915156_P1_ConstraintTests.sql) | Invalid inserts and the final count query. |
| [Screenshots](portfolio-1-database-design/screenshots/) | Saved commands and execution results. |

## Implementation

The database runs on PostgreSQL in GitHub Codespaces. Its name is `rango_portfolio`. It contains category, customer, product, order, and order_item tables.

Customer emails and category names are unique. Product stock and order item quantities cannot be negative. Foreign keys ensure referential integrity between orders, products, and categories.

## Test results

Five invalid inserts were rejected: a missing required name, a duplicate email address, a product linked to a missing category, negative product stock, and a zero order quantity.

The final row counts are 2 categories, 2 customers, 3 products, 2 orders, and 3 order items. The failed inserts added no rows.

Reference: [PostgreSQL constraints](https://www.postgresql.org/docs/16/ddl-constraints.html).