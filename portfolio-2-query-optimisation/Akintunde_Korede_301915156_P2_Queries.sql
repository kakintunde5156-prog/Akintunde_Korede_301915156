-- Q1: Find all pending orders with customer names
SELECT c.first_name || ' ' || c.last_name AS customer_name, o.order_id, o.order_date, o.total_amount
FROM public."order" o
JOIN public.customer c USING (customer_id)
WHERE o.order_status = 'Pending'
ORDER BY o.order_date;

-- Q2: Find products that have never been ordered
SELECT p.product_name, p.price, p.stock_quantity
FROM public.product p
WHERE NOT EXISTS (
    SELECT 1 FROM public.order_item oi
    WHERE oi.product_id = p.product_id
)
ORDER BY p.product_name;

-- Q3: Count all orders for each customer, including those with zero orders
SELECT c.first_name || ' ' || c.last_name AS customer_name, count(o.order_id) AS total_orders
FROM public.customer c
LEFT JOIN public."order" o USING (customer_id)
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_orders DESC, customer_name;