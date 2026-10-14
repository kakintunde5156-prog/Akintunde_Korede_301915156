

## 4. Normalization Explanation

The RanGo database design is systematically normalized up to **Third Normal Form (3NF)** to eliminate redundancy and prevent anomalies:

* **First Normal Form (1NF):** Ensures atomicity by eliminating repeating groups and multi-valued attributes, ensuring every table cell contains a single, indivisible value.
* **Second Normal Form (2NF):** Ensures the table is in 1NF and all non-key attributes are fully functionally dependent on the primary key, removing partial dependencies.
* **Third Normal Form (3NF):** Ensures the table is in 2NF and removes transitive dependencies, ensuring non-key attributes depend *only* on the primary key (e.g., separating Categories into its own table rather than repeating category names inside the Products table).

