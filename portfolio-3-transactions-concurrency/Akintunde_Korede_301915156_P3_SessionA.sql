-- Portfolio 3: Isolation and Concurrency Control
-- Case Study: RanGo E-commerce Platform
-- Session A (Left Terminal)

-- 1. Setup and start transaction
SET application_name = 'p3_session_a';
BEGIN ISOLATION LEVEL READ COMMITTED;
SHOW transaction_isolation;

-- 2. Mark Bob's pending order as 'Processing' but DO NOT commit yet
UPDATE public."order"
SET order_status = 'Processing'
WHERE order_id = 2 AND order_status = 'Pending';

-- =========================================================================
-- STOP HERE: Switch to Session B to run its initial checks and update attempt
-- =========================================================================

-- 3. Check that Session B is locked and waiting
SELECT application_name, wait_event_type 
FROM pg_stat_activity
WHERE application_name = 'p3_session_b';

-- 4. Commit the transaction to release the lock
COMMIT;