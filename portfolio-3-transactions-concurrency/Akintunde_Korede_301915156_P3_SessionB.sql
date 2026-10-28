-- Portfolio 3: Isolation and Concurrency Control
-- Case Study: RanGo E-commerce Platform
-- Session B (Right Terminal)

-- 1. Setup and start transaction
SET application_name = 'p3_session_b';
BEGIN ISOLATION LEVEL READ COMMITTED;
SHOW transaction_isolation;

-- 2. Check the status of Bob's order (Expect 'Pending' since A has not committed)
SELECT order_status 
FROM public."order" 
WHERE order_id = 2;

-- 3. Attempt to update the same order
-- (Expect this to pause and wait because of Session A's row-level lock)
UPDATE public."order"
SET order_status = 'Processing'
WHERE order_id = 2 AND order_status = 'Pending';

-- =========================================================================
-- WAIT HERE: Switch back to Session A to check the lock and COMMIT
-- =========================================================================

-- 4. Rollback after Session A commits and this update returns 0 rows
ROLLBACK;

-- 5. Final check of the order status (Expect 'Processing')
SELECT order_id, order_status 
FROM public."order" 
WHERE order_id = 2;