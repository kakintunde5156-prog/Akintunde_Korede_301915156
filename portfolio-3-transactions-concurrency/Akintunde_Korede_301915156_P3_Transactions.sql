-- Portfolio 3: Transactions and Concurrency
-- Case Study: RanGo E-commerce Platform

-- 1. Check the starting data for existing orders
SELECT o.order_id, c.email, o.order_status, o.total_amount
FROM public."order" o
JOIN public.customer c USING (customer_id)
ORDER BY o.order_id;


-- 2. Save a valid status update with COMMIT
BEGIN;

-- Update the order status only if it is currently 'Processing'
UPDATE public."order"
SET order_status = 'Completed'
WHERE customer_id = (SELECT customer_id FROM public.customer WHERE email = 'alice@example.com')
  AND order_status = 'Processing';

COMMIT;

-- Attempt to repeat the same update to demonstrate the WHERE condition prevents overwriting
UPDATE public."order"
SET order_status = 'Completed'
WHERE customer_id = (SELECT customer_id FROM public.customer WHERE email = 'alice@example.com')
  AND order_status = 'Processing';


-- 3. Undo changes after a deliberate error using ROLLBACK
BEGIN;

-- Insert a new valid order for Bob
INSERT INTO public."order" (customer_id, total_amount, order_status)
VALUES (
    (SELECT customer_id FROM public.customer WHERE email = 'bob@example.com'),
    50.00, 'Pending'
);

-- Deliberately cause an error by inserting a negative quantity (violating check constraint)
INSERT INTO public.order_item (order_id, product_id, quantity, unit_price)
VALUES (
    (SELECT order_id FROM public."order" ORDER BY order_id DESC LIMIT 1),
    (SELECT product_id FROM public.product LIMIT 1),
    -5, 10.00
);

-- Undo the entire transaction due to the constraint error above
ROLLBACK;


-- 4. Final checks to prove COMMIT remained and ROLLBACK was completely undone
-- Check Alice's saved order status
SELECT o.order_id, o.order_status 
FROM public."order" o
JOIN public.customer c USING (customer_id)
WHERE c.email = 'alice@example.com';

-- Check Bob's order count (verifying the rolled back order was not added)
SELECT count(*) AS bobs_orders 
FROM public."order" o
JOIN public.customer c USING (customer_id)
WHERE c.email = 'bob@example.com';