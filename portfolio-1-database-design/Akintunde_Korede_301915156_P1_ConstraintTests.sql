-- ConstraintTests.sql
-- Tests schema constraints by running deliberately invalid statements.
-- Each statement should fail and throw an error. Run these statements individually.

-- Test 1: Required field violation (Missing last_name)
-- Expected error: NOT NULL constraint failed for column "last_name"
INSERT INTO public.customer (first_name, email) 
VALUES ('Charlie', 'charlie@example.com');


-- Test 2: Unique value violation (Duplicate email address)
-- Expected error: Unique constraint violation on email "alice@example.com"
INSERT INTO public.customer (first_name, last_name, email) 
VALUES ('Alicia', 'Smith', 'alice@example.com');


-- Test 3: Foreign key violation (Non-existent category_id)
-- Expected error: Insert or update on table "product" violates foreign key constraint
INSERT INTO public.product (category_id, product_name, price, stock_quantity) 
VALUES (9999, 'Smart Watch', 199.99, 10);


-- Test 4: Check constraint violation on product stock (Negative stock)
-- Expected error: Check constraint violation for stock_quantity >= 0
INSERT INTO public.product (category_id, product_name, price, stock_quantity) 
VALUES (
    (SELECT category_id FROM public.category WHERE category_name = 'Electronics'), 
    'Broken Widget', 5.00, -5
);


-- Test 5: Check constraint violation on order item quantity (Zero or negative quantity)
-- Expected error: Check constraint violation for quantity > 0
INSERT INTO public.order_item (order_id, product_id, quantity, unit_price) 
VALUES (
    (SELECT order_id FROM public."order" LIMIT 1),
    (SELECT product_id FROM public.product LIMIT 1),
    0, 25.00
);


-- =========================================================================
-- Final Verification Query
-- =========================================================================
-- Run this query after the tests fail to confirm that no invalid data was added.
-- Expected row counts: 
-- category: 2, customer: 2, product: 3, order: 2, order_item: 3

SELECT 
    (SELECT COUNT(*) FROM public.category) AS category_count,
    (SELECT COUNT(*) FROM public.customer) AS customer_count,
    (SELECT COUNT(*) FROM public.product) AS product_count,
    (SELECT COUNT(*) FROM public."order") AS order_count,
    (SELECT COUNT(*) FROM public.order_item) AS order_item_count;