BEGIN;

-- Create category table
CREATE TABLE public.category (
category_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
category_name VARCHAR(50) NOT NULL UNIQUE
);

-- Create customer table
CREATE TABLE public.customer (
customer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(254) NOT NULL UNIQUE,
created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Create product table
CREATE TABLE public.product (
product_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
category_id BIGINT NOT NULL REFERENCES public.category(category_id),
product_name VARCHAR(100) NOT NULL,
price DECIMAL(10,2) NOT NULL,
stock_quantity INT NOT NULL CHECK (stock_quantity >= 0)
);

-- Create order table (using quotes as order is a reserved SQL keyword)
CREATE TABLE public."order" (
order_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
customer_id BIGINT NOT NULL REFERENCES public.customer(customer_id),
order_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
total_amount DECIMAL(10,2) NOT NULL,
order_status VARCHAR(20) NOT NULL DEFAULT 'Pending'
);

-- Create order_item table
CREATE TABLE public.order_item (
order_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
order_id BIGINT NOT NULL REFERENCES public."order"(order_id),
product_id BIGINT NOT NULL REFERENCES public.product(product_id),
quantity INT NOT NULL CHECK (quantity > 0),
unit_price DECIMAL(10,2) NOT NULL
);

COMMIT;