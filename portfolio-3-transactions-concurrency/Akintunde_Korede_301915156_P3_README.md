# Portfolio 3 Transactions and Concurrency

## Commit and rollback
A status update for an existing order (order_id 1) is safely committed. A repeated update attempt affects zero rows because the UPDATE relies on a strict WHERE condition (`order_status = 'Processing'`). In the next transaction, a valid order insert for Bob is rolled back alongside an intentional check-constraint violation (negative quantity), leaving the database exactly as it was before the transaction started.

## Isolation and concurrency control
Two PostgreSQL sessions use READ COMMITTED isolation. Session A updates Bob's order to 'Processing' without committing. Session B reads the order and still sees 'Pending', then tries to run the same update. Session B is forced to wait, with `wait_event_type` showing as `Lock`. Once Session A commits, Session B wakes up, but updates 0 rows because the `WHERE order_status = 'Pending'` condition is no longer true. Session B rolls back, leaving the order securely updated exactly once.

## Conclusion
COMMIT successfully saves valid transactions while ROLLBACK completely undoes them upon encountering constraint errors. The READ COMMITTED isolation level effectively hides A's uncommitted records from B. When both attempt to update the same row, PostgreSQL's row-level locking forces concurrency control by making B wait. Applying strict WHERE clauses in the update statements prevents lost updates and double-processing once the lock is released.

## Files
* [Commit/Rollback Script](Akintunde_Korede_301915156_P3_Transactions.sql)
* [Session A Script](Akintunde_Korede_301915156_P3_SessionA.sql)
* [Session B Script](Akintunde_Korede_301915156_P3_SessionB.sql)
* [Commit/Rollback Proof](screenshots/Akintunde_Korede_301915156_P3_CommitRollback.png)
* [Sessions Waiting Proof](screenshots/Akintunde_Korede_301915156_P3_SessionsWaiting.png)
* [Concurrency Result Proof](screenshots/Akintunde_Korede_301915156_P3_ConcurrencyResult.png)

## References
* [PostgreSQL transactions](https://www.postgresql.org/docs/16/tutorial-transactions.html)
* [Transaction isolation](https://www.postgresql.org/docs/16/transaction-iso.html)