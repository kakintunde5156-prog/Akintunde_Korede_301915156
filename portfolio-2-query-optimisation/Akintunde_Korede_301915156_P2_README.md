# Portfolio 2 Query Processing and Optimisation

## Queries and results
The three query files examine our primary schema. They return specific results about customers, pending transactions, and never-ordered products.

## Index comparison
Performance testing was conducted using 100,000 synthetic order records in `p2_benchmark.order_history`, querying pending orders on January 1, 2000. 
We added a B-tree index: `CREATE INDEX order_history_order_date_idx ON p2_benchmark.order_history (order_date);`

| Measurement | Before index | After index |
| :--- | :--- | :--- |
| Scan type | Seq Scan | Index Only Scan |
| Three execution times (ms) | 8.688, 10.215, 6.003 | 0.044, 0.026, 0.036 |
| Median time (ms) | 8.688 | 0.036 |
| Shared buffer hits, third run | 834 | 3 |

## Performance analysis
Before indexing, PostgreSQL used a Seq Scan, examining all 100,000 records to extract the 23 items. This forced a massive block-reading cost, resulting in 834 shared buffer hits and a median execution time of 8.688 ms.

After we introduced the B-Tree index on `order_date`, the plan instantly transitioned to an Index Only Scan. It quickly traversed the index tree, reducing block hits to only 3 shared buffer hits and slashing the median search time down to 0.036 ms. This represents a massive performance boost (over 240x faster). 

While indexes accelerate reads dramatically on larger datasets, they are not free: they introduce storage overhead and consume additional CPU and I/O resources during write operations (like INSERTs or UPDATEs) to keep the index balanced.

## Files
* [Queries file](Akintunde_Korede_301915156_P2_Queries.sql)
* [Optimisation file](Akintunde_Korede_301915156_P2_Optimisation.sql)
* [Before Index Proof](screenshots/Akintunde_Korede_301915156_P2_BeforeIndex.png)
* [After Index Proof](screenshots/Akintunde_Korede_301915156_P2_AfterIndex.png)

## Reference
* [PostgreSQL — Using EXPLAIN](https://www.postgresql.org/docs/16/using-explain.html)