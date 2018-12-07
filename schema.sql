USE orders;

INSERT INTO products (product, inventory, price)
VALUES ("Home Alone", 10, 5.99);
INSERT INTO products (product, inventory, price)
VALUES ("Wonder", 20, 14.99);
INSERT INTO products (product, inventory, price)
VALUES ("Transformers", 1, 13.99);
INSERT INTO products (product, inventory, price)
VALUES ("Elf", 15, 6.99);
INSERT INTO products (product, inventory, price)
VALUES ("Shrek", 2, 19.99);
INSERT INTO products (product, inventory, price)
VALUES ("Dispicable Me", 5, 12.99);
INSERT INTO products (product, inventory, price)
VALUES ("Matrix", 10, 9.99);

SELECT * FROM products;

INSERT INTO customers (customer_name, contact_name, location_type, billing_street_1, billing_street_2, billing_city, 
	billing_state, billing_postal_code, billing_country, email, phone_number)
VALUES ("ABC Company", "John Doe", "Business", "123 Main Street", "", "Atlanta", "GA", 12345, "United States", "jdoe@test.com", "404-555-5555");
INSERT INTO customers (customer_name, contact_name, location_type, billing_street_1, billing_street_2, billing_city, 
	billing_state, billing_postal_code, billing_country, email, phone_number)
VALUES ("Movies R Us", "Mary Doe", "Business", "567 First Street", "", "Jacksonville", "FL", 23456, "United States", "mdoe@test.com", "904-555-5555");
INSERT INTO customers (customer_name, contact_name, location_type, billing_street_1, billing_street_2, billing_city, 
	billing_state, billing_postal_code, billing_country, email, phone_number)
VALUES ("Movies Inc", "Bob Smith", "Business", "80 Central Street", "", "Nashville", "TN", 34567, "United States", "bsmith@test.com", "660-555-5555");
INSERT INTO customers (customer_name, contact_name, location_type, billing_street_1, billing_street_2, billing_city, 
	billing_state, billing_postal_code, billing_country, email, phone_number)
VALUES ("See It Today", "Nancy Johnson", "Business", "10 Main Street", "", "Seattle", "WA", 01234, "United States", "njohnson@test.com", "770-555-5555");

SELECT * FROM customers;