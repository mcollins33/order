DROP DATABASE orders;

CREATE DATABASE orders;

USE orders;

CREATE TABLE users (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
	);

CREATE TABLE customers (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	company_name VARCHAR(100) NOT NULL,
	contact_name VARCHAR(100) NOT NULL,
	billing_street_1 VARCHAR(100) NOT NULL,
	billing_street_2 VARCHAR(100),
	billing_city VARCHAR(60) NOT NULL,
	billing_state VARCHAR(50) NOT NULL DEFAULT 'AZ',
	billing_postal_code INT(5) ZEROFILL NOT NULL,
	billing_country VARCHAR(55) NOT NULL DEFAULT 'United States',
	location_type VARCHAR(20),
	email VARCHAR(254) NOT NULL,
	phone_number VARCHAR(15) NOT NULL
	);

CREATE TABLE products (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	part_number INT NOT NULL,
	product VARCHAR(254),
	inventory INT NOT NULL,
	price DECIMAL(10, 2) NOT NULL
	);

CREATE TABLE orders (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	shipping_street_1 VARCHAR(100) NOT NULL,
	shipping_street_2 VARCHAR(100),
	shipping_city VARCHAR(60) NOT NULL,
	shipping_state VARCHAR(50) NOT NULL,
	shipping_postal_code INT(5) ZEROFILL NOT NULL,
	shipping_country VARCHAR(55) NOT NULL,
	order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	user_id INT NOT NULL,
	customer_id INT NOT NULL,
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(customer_id) REFERENCES customers(id)
	);

CREATE TABLE details (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	order_quantity INT NOT NULL,
	order_price DECIMAL(10, 2) NOT NULL,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	FOREIGN KEY(order_id) REFERENCES orders(id),
	FOREIGN KEY(product_id) REFERENCES products(id)
	);

INSERT INTO users (first_name, last_name)
VALUES ("Sally", "Watson")
	,("Greg", "Brown")
	,("Josh", "Miller");

SELECT * FROM users;

INSERT INTO products (part_number, product, inventory, price)
VALUES (100,"Home Alone", 10, 5.99)
	,(200,"Wonder", 20, 14.99)
	,(300,"Transformers", 1, 13.99)
	,(400,"Elf", 15, 6.99)
	,(500,"Shrek", 2, 19.99)
	,(600,"Dispicable Me", 5, 12.99)
	,(700,"Matrix", 10, 9.99);

SELECT * FROM products;

INSERT INTO customers (company_name, contact_name, location_type, billing_street_1, billing_street_2, billing_city, 
	billing_state, billing_postal_code, billing_country, email, phone_number)
VALUES ("ABC Company", "John Doe", "Business", "123 Main Street", "", "Atlanta", "GA", 12345, "United States", "jdoe@test.com", "404-555-5555")
,("Movies R Us", "Mary Doe", "Business", "567 First Street", "", "Jacksonville", "FL", 23456, "United States", "mdoe@test.com", "904-555-5555")
,("Movies Inc", "Bob Smith", "Business", "80 Central Street", "", "Nashville", "TN", 34567, "United States", "bsmith@test.com", "660-555-5555")
,("See It Today", "Nancy Johnson", "Business", "10 Main Street", "", "Seattle", "WA", 01234, "United States", "njohnson@test.com", "770-555-5555");

SELECT * FROM customers;

SELECT id, company_name, contact_name, email, location_type, billing_street_1, billing_street_2, billing_city, billing_state, billing_country, billing_postal_code FROM customers WHERE company_name LIKE '%Doe%' || contact_name LIKE '%Doe%' || billing_street_1 LIKE '%Doe%'
	|| billing_street_2 LIKE '%Doe%' || billing_city LIKE '%Doe%' || billing_state LIKE '%Doe%' || billing_postal_code LIKE '%Doe%' || phone_number LIKE '%Doe%';

INSERT INTO orders (user_id, customer_id, shipping_street_1, shipping_street_2, shipping_city, 
	shipping_state, shipping_postal_code, shipping_country)
VALUES (1, 1, "124 Main Street", "", "Atlanta", "GA", 12345, "United States")
	, (1, 2, "567 First Street", "", "Jacksonville", "FL", 23456, "United States")
    , (1, 2, "567 First Street", "", "Jacksonville", "FL", 23456, "United States")
	, (1, 3, "80 Central Street", "", "Nashville", "TN", 34567, "United States");

SELECT * FROM orders;

SELECT id, inventory, price FROM products WHERE part_number = 100;

INSERT INTO details (order_id, product_id, order_quantity, order_price)
VALUES (1, 1, 1, 5.99)
	, (1, 2, 1, 14.99)
    , (2, 2, 1, 14.99)
    , (2, 3, 1, 13.99)
    , (3, 4, 1, 6.99)
    , (3, 5, 1, 19.99)
    , (4, 6, 1, 12.99)
    , (4, 7, 1, 9.99);

SELECT * FROM details;
    
UPDATE orders SET order_date='2017-12-08 00:00:00' WHERE id=2;

SELECT company_name, part_number, order_date, Sum(order_quantity), Sum(order_price)
FROM customers, orders, details, products
WHERE customers.id = 2 && customers.id = orders.customer_id && orders.order_date LIKE "%2018%" &&orders.id = details.order_id && details.product_id = products.id
GROUP BY part_number;