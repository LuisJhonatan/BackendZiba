
CREATE TABLE users (
  id_user INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(15),
  photo VARCHAR(500) DEFAULT 'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg'
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
  rating DECIMAL(10, 2) DEFAULT 0.0,
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

INSERT INTO users (email, password, name, phone, photo) VALUES
('user1@example.com', 'password1', 'User One', '1234567890', NULL),
('user2@example.com', 'password2', 'User Two', '2345678901', NULL),
('user3@example.com', 'password3', 'User Three', '3456789012', NULL),
('user4@example.com', 'password4', 'User Four', '4567890123', NULL),
('user5@example.com', 'password5', 'User Five', '5678901234', NULL);

INSERT INTO category (type) VALUES
('Bags'),
('Shoes'),
('Accessories'),
('Clothing'),
('Electronics');

INSERT INTO product (id_category, name_product, price, stock, color, description, rating) VALUES
(1, 'Leather Bag', 120.50, 10, 'Black', 'A stylish black leather bag.', 4.5),
(2, 'Running Shoes', 85.00, 20, 'Blue', 'Comfortable running shoes.', 4.2),
(3, 'Wristwatch', 150.00, 15, 'Silver', 'Elegant silver wristwatch.', 4.8),
(4, 'Denim Jacket', 60.00, 30, 'Blue', 'Classic denim jacket.', 4.3),
(5, 'Smartphone', 999.99, 5, 'Black', 'Latest model smartphone.', 4.7),
(1, 'Tote Bag', 75.00, 25, 'Brown', 'Spacious tote bag for daily use.', 4.5),
(1, 'Backpack', 55.00, 15, 'Black', 'Durable backpack for travel.', 4.0),
(2, 'Sneakers', 65.00, 18, 'White', 'Stylish white sneakers for everyday wear.', 4.3),
(2, 'Heels', 120.00, 10, 'Red', 'Elegant red heels for formal occasions.', 4.8),
(3, 'Sunglasses', 45.00, 30, 'Black', 'Trendy sunglasses for summer.', 4.2);

-- Leather Bag (2 images)
INSERT INTO product_image (id_product, image_url) VALUES
(1, 'https://example.com/images/leather_bag_1.jpg'),
(1, 'https://example.com/images/leather_bag_2.jpg');

-- Running Shoes (2 images)
INSERT INTO product_image (id_product, image_url) VALUES
(2, 'https://example.com/images/running_shoes_1.jpg'),
(2, 'https://example.com/images/running_shoes_2.jpg');

-- Wristwatch (2 images)
INSERT INTO product_image (id_product, image_url) VALUES
(3, 'https://example.com/images/wristwatch_1.jpg'),
(3, 'https://example.com/images/wristwatch_2.jpg');

-- Denim Jacket (no images)

-- Smartphone (1 image)
INSERT INTO product_image (id_product, image_url) VALUES
(5, 'https://example.com/images/smartphone_1.jpg');

-- Tote Bag (2 imágenes)
INSERT INTO product_image (id_product, image_url) VALUES
(6, 'https://i.postimg.cc/bNGbY5cP/cartera1.png'),
(6, 'https://i.postimg.cc/ZK1NWL4d/cartera2.jpg');

-- Backpack (2 imágenes)
INSERT INTO product_image (id_product, image_url) VALUES
(7, 'https://i.postimg.cc/CMrkgg2J/cartera3.jpg'),
(7, 'https://i.postimg.cc/v84LDTfC/mochila1.png');

-- Sneakers (2 imágenes)
INSERT INTO product_image (id_product, image_url) VALUES
(8, 'https://i.postimg.cc/hj5jHSGd/mochila2.png'),
(8, 'https://i.postimg.cc/JtwhzPZ7/mochila3.png');

-- Heels (1 imagen)
INSERT INTO product_image (id_product, image_url) VALUES
(9, 'https://i.postimg.cc/L5gXSrq0/mochila4.png');

-- Sunglasses (1 imagen)
INSERT INTO product_image (id_product, image_url) VALUES
(10, 'https://i.postimg.cc/CMrkgg2J/cartera3.jpg');

INSERT INTO address (id_user, address_line1, address_line2, city, state, postal_code, country) VALUES
(1, '123 Main St', '', 'New York', 'NY', '10001', 'USA'),
(2, '456 Park Ave', 'Apt 23B', 'Los Angeles', 'CA', '90001', 'USA'),
(3, '789 Broadway', '', 'San Francisco', 'CA', '94103', 'USA'),
(4, '1011 Ocean Dr', '', 'Miami', 'FL', '33101', 'USA'),
(5, '1213 Sunset Blvd', 'Apt 9', 'Austin', 'TX', '73301', 'USA');

INSERT INTO payment_method (method_name) VALUES
('Credit Card'),
('PayPal'),
('Bank Transfer'),
('Cash'),
('Cryptocurrency');

INSERT INTO `order` (id_user, id_address, total, order_date, payment_method_id, state) VALUES
(1, 1, 120.50, '2024-09-01', 1, false),
(2, 2, 85.00, '2024-09-02', 2, true),
(3, 3, 150.00, '2024-09-03', 3, false),
(4, 4, 60.00, '2024-09-04', 4, true),
(5, 5, 999.99, '2024-09-05', 5, true);

INSERT INTO order_detail (id_order, sub_total, amount) VALUES
(1, 120.50, 1),
(2, 85.00, 1),
(3, 150.00, 1),
(4, 60.00, 1),
(5, 999.99, 1);

INSERT INTO voucher (id_order, voucher_number) VALUES
(1, 'VOUCHER001'),
(2, 'VOUCHER002'),
(3, 'VOUCHER003'),
(4, 'VOUCHER004'),
(5, 'VOUCHER005');

INSERT INTO product_order_detail (id_product, id_order_detail) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO review (id_product, id_user, rating, comment) VALUES
(1, 1, 5, 'Great product!'),
(2, 2, 4, 'Comfortable and stylish.'),
(3, 3, 5, 'Excellent quality!'),
(4, 4, 3, 'Good, but could be better.'),
(5, 5, 5, 'Absolutely worth it!');
