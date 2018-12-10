-- Used for development. 
DROP DATABASE order_db;

CREATE DATABASE order_db;

USE order_db;


-- CREATE TABLES

-- More user information required, outside scope of this project
-- For this project, user is already logged in. Table has been created for id and ability to pull orders by user.
CREATE TABLE users (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL
	);

CREATE TABLE customers (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	company_name VARCHAR(100),
	contact_name VARCHAR(100) NOT NULL,
	email VARCHAR(254) NOT NULL,
	location_type VARCHAR(20) NOT NULL,
	billing_street_1 VARCHAR(100) NOT NULL,
	billing_street_2 VARCHAR(100),
	billing_city VARCHAR(60) NOT NULL,
	billing_state VARCHAR(50) NOT NULL,
	billing_postal_code VARCHAR(10) NOT NULL,
	billing_country VARCHAR(55) NOT NULL,
	phone_number VARCHAR(25) NOT NULL
	);

-- Other functions may result in products table changes and/or addition of new tables, considered outside scope of this project
	-- More details on products may be required (e.g. if there is a page where customers can view products)
	-- Method of showing customer whether product is in stock (inventory value would need to consider orders placed by other customers that have not shipped)
	-- Associated tables needed for replenishment of product inventory such as vendors and product orders
-- Option: part number could be used as id
CREATE TABLE products (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	part_number INT NOT NULL,
	product_desc VARCHAR(254),
	inventory INT NOT NULL,
	unit_cost DECIMAL(10, 2) NOT NULL
	);

-- Top portion of order form will populate from customer table (initial address info is billing address).
-- User is able to edit this address on the order screen. It will be saved as shipping address in the orders table.
-- The billing address information in the customer table will remain unchanged.
-- If addresses are rarely changed for shipping, this will result in a lot of duplicate information stored.
-- May consider a shipping address table and allowing User to choose existing or add a new shipping address.
CREATE TABLE orders (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	shipping_street_1 VARCHAR(100) NOT NULL,
	shipping_street_2 VARCHAR(100),
	shipping_city VARCHAR(60) NOT NULL,
	shipping_state VARCHAR(50) NOT NULL,
	shipping_postal_code VARCHAR(10) NOT NULL,
	shipping_country VARCHAR(55) NOT NULL,
	order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	user_id INT NOT NULL,
	customer_id INT NOT NULL,
	FOREIGN KEY(user_id) REFERENCES users(id),
	FOREIGN KEY(customer_id) REFERENCES customers(id)
	ON DELETE CASCADE
	);

-- When each product is input in the order form, a query will run to obtain product id and populate the unit cost.
-- The product id will be stored in the background to be used as product_id in the details table. 
-- The unit cost may be edited on the order screen and will be inserted into the details table as order_unit_cost.
CREATE TABLE details (
	id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	order_quantity INT NOT NULL,
	order_unit_cost DECIMAL(10, 2) NOT NULL,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	FOREIGN KEY(order_id) REFERENCES orders(id),
	FOREIGN KEY(product_id) REFERENCES products(id)
	);

-- /CREATE TABLES



-- ORDER PROCESS

-- User is already logged in and id stored in background

-- USER SEARCHES FOR CUSTOMER
-- Query to run when customer presses Search button.
-- "Doe" to be replaced with input from search box.
-- Selected returned fields will appear in drop down. Selecting a customer from drop down will populate top portion of order screen.
-- Phone number not returned as it does not appear on order screen.
SELECT id, company_name, contact_name, email, location_type, billing_street_1, billing_street_2, billing_city, billing_state, billing_country, billing_postal_code FROM customers WHERE company_name LIKE '%Doe%' || contact_name LIKE '%Doe%' || billing_street_1 LIKE '%Doe%'
	|| billing_street_2 LIKE '%Doe%' || billing_city LIKE '%Doe%' || billing_state LIKE '%Doe%' || billing_postal_code LIKE '%Doe%' || phone_number LIKE '%Doe%';

-- USER INPUTS PRODUCTS TO ORDER
-- Query to run when each part is input. Replace "100" with part number from order screen.
-- Each product's id returned to be stored in background. Unit cost returned will populate on order screen.
-- Code to calculate/populate extended cost, subtotal, tax, shipping & handling, and total.
SELECT id, unit_cost FROM products WHERE part_number = "100";

-- USER SAVES ORDER

-- STEP ONE
-- User id currently stored in background, other information pulled from top portion of order screen.
INSERT INTO orders (user_id, customer_id, shipping_street_1, shipping_street_2, shipping_city, 
	shipping_state, shipping_postal_code, shipping_country)
VALUES (1, 1, "124 Main Street", "", "Atlanta", "GA", 12345, "United States")

-- STEP TWO
-- Order id returned from step one, product id currently stored in background, remaining information
-- pulled from order screen.
INSERT INTO details (order_id, product_id, order_quantity, order_unit_cost)
VALUES (1, 1, 1, 5.99)
	, (1, 2, 1, 14.99);

-- /ORDER PROCESS



-- PULL TOTAL COUNT OF PARTS AND COST FOR A PARTICULAR CUSTOMER IN 2018

-- Assumes customer id is known, otherwise query similar to search box must be performed first.
-- Replace 2 with desired customer id. Replace 2018 with desired year.
SELECT company_name, part_number, order_date, Sum(order_quantity), Sum(order_unit_cost)
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id
INNER JOIN details ON orders.id = details.order_id
INNER JOIN products ON details.product_id = products.id
WHERE customers.id = 2 && orders.order_date LIKE "%2018%"
GROUP BY part_number;

-- /PULL TOTAL COUNT OF PARTS AND COST FOR A PARTICULAR CUSTOMER IN 2018



-- TEST DATA

-- Create User test data
INSERT INTO users (first_name, last_name)
VALUES ("Sally", "Watson")
	,("Greg", "Brown")
	,("Josh", "Miller");

-- Create Product test data
INSERT INTO products (part_number, product_desc, inventory, unit_cost)
VALUES (100,"Home Alone", 10, 5.99)
	,(200,"Wonder", 20, 14.99)
	,(300,"Transformers", 1, 13.99)
	,(400,"Elf", 15, 6.99)
	,(500,"Shrek", 2, 19.99)
	,(600,"Dispicable Me", 5, 12.99)
	,(700,"Matrix", 10, 9.99);

-- Create Customer test data
INSERT INTO customers (company_name, contact_name, location_type, billing_street_1, billing_street_2, billing_city, 
	billing_state, billing_postal_code, billing_country, email, phone_number)
VALUES ("ABC Company", "John Doe", "Business", "123 Main Street", "", "Atlanta", "GA", 12345, "United States", "jdoe@test.com", "404-555-5555")
,("Movies R Us", "Mary Doe", "Business", "567 First Street", "", "Jacksonville", "FL", 23456, "United States", "mdoe@test.com", "904-555-5555")
,("Movies Inc", "Bob Smith", "Business", "80 Central Street", "", "Nashville", "TN", 34567, "United States", "bsmith@test.com", "660-555-5555")
,("See It Today", "Nancy Johnson", "Business", "10 Main Street", "", "Seattle", "WA", 01234, "United States", "njohnson@test.com", "770-555-5555");

-- Create Order test data
INSERT INTO orders (user_id, customer_id, shipping_street_1, shipping_street_2, shipping_city, 
	shipping_state, shipping_postal_code, shipping_country)
VALUES (1, 1, "124 Main Street", "", "Atlanta", "GA", 12345, "United States")
	, (1, 2, "567 First Street", "", "Jacksonville", "FL", 23456, "United States")
    , (1, 2, "567 First Street", "", "Jacksonville", "FL", 23456, "United States")
	, (1, 3, "80 Central Street", "", "Nashville", "TN", 34567, "United States")
	, (1, 2, "567 First Street", "", "Jacksonville", "FL", 23456, "United States");

-- Create Order Details
INSERT INTO details (order_id, product_id, order_quantity, order_unit_cost)
VALUES (1, 1, 1, 5.99)
	, (1, 2, 1, 14.99)
    , (2, 2, 1, 14.99)
    , (2, 3, 1, 13.99)
    , (3, 4, 1, 6.99)
    , (3, 5, 1, 19.99)
    , (4, 6, 1, 12.99)
    , (4, 7, 1, 9.99)
    , (5, 3, 1, 12.99)
    , (5, 4, 1, 9.99);

-- For test purposes, the year of the second order is changed.
UPDATE orders SET order_date='2017-12-08 00:00:00' WHERE id=2;