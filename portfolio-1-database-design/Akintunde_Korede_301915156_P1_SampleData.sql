-- SampleData.sql
-- Inserts valid sample records into the RanGo database

BEGIN;

-- 1. Insert categories
INSERT INTO public.category (category_name) VALUES 
('Electronics'), 
('Fashion');

-- 2. Insert customers with example.com emails
INSERT INTO public.customer (first_name, last_name, email) VALUES 
('Alice', 'Smith', 'alice@example.com'),
('Bob', 'Jones', 'bob@example.com');

-- 3. Insert products linked to categories using lookups
INSERT INTO public.product (category_id, product_name, price, stock_quantity) VALUES 
(
    (SELECT category_id FROM public.category WHERE category_name = 'Electronics'), 
    'Wireless Mouse', 25.00, 50
),
(
    (SELECT category_id FROM public.category WHERE category_name = 'Electronics'), 
    'USB-C Cable', 10.00, 100
),
(
    (SELECT category_id FROM public.category WHERE category_name = 'Fashion'), 
    'Cotton T-Shirt', 15.00, 30
);

-- 4. Insert orders linked to customers using lookups
INSERT INTO public."order" (customer_id, total_amount, order_status) VALUES 
(
    (SELECT customer_id FROM public.customer WHERE email = 'alice@example.com'), 
    45.00, 'Processing'
),
(
    (SELECT customer_id FROM public.customer WHERE email = 'bob@example.com'), 
    15.00, 'Pending'
);

-- 5. Insert order items linked to orders and products using lookups
INSERT INTO public.order_item (order_id, product_id, quantity, unit_price) VALUES 
(
    (SELECT o.order_id FROM public."order" o JOIN public.customer c ON o.customer_id = c.customer_id WHERE c.email = 'alice@example.com' LIMIT 1),
    (SELECT product_id FROM public.product WHERE product_name = 'Wireless Mouse'),
    1, 25.00
),
(
    (SELECT o.order_id FROM public."order" o JOIN public.customer c ON o.customer_id = c.customer_id WHERE c.email = 'alice@example.com' LIMIT 1),
    (SELECT product_id FROM public.product WHERE product_name = 'USB-C Cable'),
    2, 10.00
),
(
    (SELECT o.order_id FROM public."order" o JOIN public.customer c ON o.customer_id = c.customer_id WHERE c.email = 'bob@example.com' LIMIT 1),
    (SELECT product_id FROM public.product WHERE product_name = 'Cotton T-Shirt'),
    1, 15.00
);

COMMIT;