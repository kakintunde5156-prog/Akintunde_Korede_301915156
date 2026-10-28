-- Portfolio 2: Query Processing and Optimisation
-- Case Study: RanGo E-commerce Platform

-- =========================================================================
-- 1. Schema Setup & Synthetic Data Generation
-- =========================================================================
-- Create a separate schema for benchmarking so original tables stay unchanged.
CREATE SCHEMA p2_benchmark;

-- Create 100,000 example order records for the speed test.
CREATE TABLE p2_benchmark.order_history AS
SELECT g AS order_id, c.customer_id,
       TIMESTAMPTZ '2000-01-01 00:00:00+00' + g * INTERVAL '1 hour' AS order_date,
       15.00::DECIMAL(10,2) AS total_amount,
       'Pending' AS order_status
FROM generate_series(1, 100000) AS g
CROSS JOIN public.customer c
WHERE c.email = 'alice@example.com';

-- Update statistics so PostgreSQL can choose the best search method.
ANALYZE p2_benchmark.order_history;

-- Verify the table was created with exactly 100,000 rows.
SELECT count(*) AS test_rows FROM p2_benchmark.order_history;


-- =========================================================================
-- 2. Count Query
-- =========================================================================
-- Verify how many orders fall on a single specific day (Expected: 23).
SELECT count(*) AS orders_on_day FROM p2_benchmark.order_history
WHERE order_date >= TIMESTAMPTZ '2000-01-01 00:00:00+00'
  AND order_date < TIMESTAMPTZ '2000-01-02 00:00:00+00';


-- =========================================================================
-- 3. Measure Before Adding the Index (Seq Scan Results)
-- =========================================================================
-- Timing 1 (Warm-up): Discarded timing
-- Run 1 (Akintunde_Korede_301915156_P2_BeforeIndex.png) Timing: Execution Time = 8.688 ms, Buffers = shared hit 834
-- Run 2 (Akintunde_Korede_301915156_P2_BeforeIndex.png) Timing: Execution Time = 10.215 ms, Buffers = shared hit 834
-- Run 3 (Akintunde_Korede_301915156_P2_BeforeIndex.png) Timing: Execution Time = 6.003 ms, Buffers = shared hit 834
-- Median before-index execution time: 8.688 ms

EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) AS orders_on_day FROM p2_benchmark.order_history
WHERE order_date >= TIMESTAMPTZ '2000-01-01 00:00:00+00'
  AND order_date < TIMESTAMPTZ '2000-01-02 00:00:00+00';


-- =========================================================================
-- 4. Add the Index
-- =========================================================================
-- Create a B-Tree index on the column used in the date filter.
CREATE INDEX order_history_order_date_idx
ON p2_benchmark.order_history (order_date);


-- =========================================================================
-- 5. Measure After Adding the Index (Index Only Scan Results)
-- =========================================================================
-- Timing 1 (Warm-up): Discarded timing
-- Run 1 (Akintunde_Korede_301915156_P2_AfterIndex.png) Timing: Execution Time = 0.044 ms, Buffers = shared hit 3 (planning hit 6)
-- Run 2 (Akintunde_Korede_301915156_P2_AfterIndex.png) Timing: Execution Time = 0.026 ms, Buffers = shared hit 3 (planning hit 6)
-- Run 3 (Akintunde_Korede_301915156_P2_AfterIndex.png) Timing: Execution Time = 0.036 ms, Buffers = shared hit 3 (planning hit 6)
-- Median after-index execution time: 0.036 ms

EXPLAIN (ANALYZE, BUFFERS)
SELECT count(*) AS orders_on_day FROM p2_benchmark.order_history
WHERE order_date >= TIMESTAMPTZ '2000-01-01 00:00:00+00'
  AND order_date < TIMESTAMPTZ '2000-01-02 00:00:00+00';