
CREATE TABLE users (
  id_user INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(15),
  photo VARCHAR(500) DEFAULT 'https://i.ibb.co/rcHvPqv/imagen-2024-07-30-231911755.png'
);


CREATE TABLE category (
  id_category INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(50) NOT NULL
);


CREATE TABLE product (
  id_product INT AUTO_INCREMENT PRIMARY KEY,
  id_category INT,
  name_product VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL,
  color VARCHAR(50) NOT NULL,
  description TEXT,
  FOREIGN KEY (id_category) REFERENCES category(id_category)
);


CREATE TABLE product_image (
  id_image INT AUTO_INCREMENT PRIMARY KEY,
  id_product INT,
  image_url VARCHAR(500),
  FOREIGN KEY (id_product) REFERENCES product(id_product)
);


CREATE TABLE address (
  id_address INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT,
  address_line1 VARCHAR(255) NOT NULL,
  address_line2 VARCHAR(255),
  city VARCHAR(100) NOT NULL,
  state VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20) NOT NULL,
  country VARCHAR(100) NOT NULL,
  FOREIGN KEY (id_user) REFERENCES users(id_user)
);


CREATE TABLE payment_method (
  id_payment_method INT AUTO_INCREMENT PRIMARY KEY,
  method_name VARCHAR(255) NOT NULL
);


CREATE TABLE `order` (
  id_order INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT,
  id_address INT,
  total DECIMAL(10, 2) NOT NULL,
  order_date DATE NOT NULL,
  payment_method_id INT,
  state BOOLEAN DEFAULT false,
  FOREIGN KEY (id_user) REFERENCES users(id_user),
  FOREIGN KEY (id_address) REFERENCES address(id_address),
  FOREIGN KEY (payment_method_id) REFERENCES payment_method(id_payment_method)
);


CREATE TABLE order_detail (
  id_order_detail INT AUTO_INCREMENT PRIMARY KEY,
  id_order INT,
  sub_total DECIMAL(10, 2) NOT NULL,
  amount INT NOT NULL,
  FOREIGN KEY (id_order) REFERENCES `order`(id_order)
);


CREATE TABLE voucher (
  id_voucher INT AUTO_INCREMENT PRIMARY KEY,
  id_order INT,
  voucher_number VARCHAR(255) NOT NULL,
  FOREIGN KEY (id_order) REFERENCES `order`(id_order)
);


CREATE TABLE product_order_detail (
  id_product INT,
  id_order_detail INT,
  PRIMARY KEY (id_product, id_order_detail),
  FOREIGN KEY (id_product) REFERENCES product(id_product),
  FOREIGN KEY (id_order_detail) REFERENCES order_detail(id_order_detail)
);


CREATE TABLE review (
  id_review INT AUTO_INCREMENT PRIMARY KEY,
  id_product INT,
  id_user INT,
  rating INT CHECK(rating >= 1 AND rating <= 5),
  comment TEXT,
  review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_product) REFERENCES product(id_product),
  FOREIGN KEY (id_user) REFERENCES users(id_user)
);


INSERT INTO users (email, password, name, phone) VALUES
('john.doe@example.com', 'hashedpassword1', 'John Doe', '1234567890'),
('jane.smith@example.com', 'hashedpassword2', 'Jane Smith', '0987654321'),
('alice.williams@example.com', 'hashedpassword3', 'Alice Williams', '1231231234'),
('bob.johnson@example.com', 'hashedpassword4', 'Bob Johnson', '4564564567'),
('eve.brown@example.com', 'hashedpassword5', 'Eve Brown', '7897897890');


INSERT INTO category (type) VALUES
('Handbags'),
('Backpacks'),
('Pencil Cases'),
('Wallets'),
('Travel Bags');


INSERT INTO product (id_category, name_product, price, stock, color, description) VALUES
(1, 'Leather Handbag', 49.99, 100, 'Black', 'A stylish black leather handbag perfect for everyday use.'),
(2, 'Canvas Backpack', 39.99, 150, 'Blue', 'A durable blue canvas backpack suitable for all occasions.'),
(3, 'Pencil Case', 9.99, 200, 'Red', 'A compact red pencil case to store all your writing essentials.'),
(4, 'Bifold Wallet', 19.99, 250, 'Brown', 'A classic brown leather bifold wallet with multiple card slots.'),
(5, 'Duffel Bag', 59.99, 80, 'Green', 'A spacious green duffel bag ideal for travel or gym.');


INSERT INTO product_image (id_product, image_url) VALUES
(1, 'https://example.com/images/leather-handbag1.png'),
(1, 'https://example.com/images/leather-handbag2.png'),
(2, 'https://example.com/images/canvas-backpack1.png'),
(3, 'https://example.com/images/pencil-case1.png'),
(4, 'https://example.com/images/bifold-wallet1.png');


INSERT INTO address (id_user, address_line1, address_line2, city, state, postal_code, country) VALUES
(1, '123 Main St', 'Apt 1', 'Springfield', 'Illinois', '62704', 'USA'),
(2, '456 Elm St', 'Suite 200', 'Seattle', 'Washington', '98101', 'USA'),
(3, '789 Oak St', NULL, 'Austin', 'Texas', '73301', 'USA'),
(4, '101 Pine St', 'Floor 3', 'San Francisco', 'California', '94103', 'USA'),
(5, '202 Maple St', NULL, 'Miami', 'Florida', '33101', 'USA');


INSERT INTO payment_method (method_name) VALUES
('Credit Card'),
('Debit Card'),
('PayPal'),
('Bank Transfer'),
('Cryptocurrency');


INSERT INTO `order` (id_user, id_address, total, order_date, payment_method_id, state) VALUES
(1, 1, 99.98, '2024-08-27', 1, true),
(2, 2, 39.99, '2024-08-26', 2, true),
(3, 3, 19.99, '2024-08-25', 3, false),
(4, 4, 59.99, '2024-08-24', 4, true),
(5, 5, 29.98, '2024-08-23', 5, false);


INSERT INTO order_detail (id_order, sub_total, amount) VALUES
(1, 49.99, 2),
(2, 39.99, 1),
(3, 19.99, 1),
(4, 59.99, 1),
(5, 29.98, 1);


INSERT INTO voucher (id_order, voucher_number) VALUES
(1, 'VOUCHER12345'),
(2, 'VOUCHER67890'),
(3, 'VOUCHER11121'),
(4, 'VOUCHER13141'),
(5, 'VOUCHER15161');


INSERT INTO product_order_detail (id_product, id_order_detail) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


INSERT INTO review (id_product, id_user, rating, comment) VALUES
(1, 1, 5, 'Amazing handbag!'),
(2, 2, 4, 'Good quality backpack, worth the price.'),
(3, 3, 3, 'Decent pencil case, but could be better.'),
(4, 4, 5, 'Love this wallet, highly recommended!'),
(5, 5, 4, 'The duffel bag is great for the gym. Sturdy and spacious.');
