CREATE TABLE user (
  id_user INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(9),
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
  image VARCHAR(500) DEFAULT 'https://gesisarg.com/sistema-gestion/res/archivos/imagen_articulo_por_defecto.jpg',
  color VARCHAR(50) NOT NULL,
  description TEXT,
  FOREIGN KEY (id_category) REFERENCES category(id_category)
);

CREATE TABLE `order` (
  id_order INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT,
  total DECIMAL(10, 2) NOT NULL,
  order_date DATE NOT NULL,
  payment_method VARCHAR(255) NOT NULL,
  state BOOLEAN DEFAULT false,
  FOREIGN KEY (id_user) REFERENCES user(id_user)
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

-- Agregamos registros de prueba
INSERT INTO
  user (email, password, name, phone, photo)
VALUES
  (
    'john.doe@example.com',
    'password123',
    'John Doe',
    '123456789',
    'https://i.ibb.co/rcHvPqv/imagen-2024-07-30-231911755.png'
  ),
  (
    'jane.smith@example.com',
    'password456',
    'Jane Smith',
    '987654321',
    'https://i.ibb.co/rcHvPqv/imagen-2024-07-30-231911755.png'
  ),
  (
    'alice.johnson@example.com',
    'securepassword',
    'Alice Johnson',
    '555123456',
    'https://i.ibb.co/rcHvPqv/imagen-2024-07-30-231911755.png'
  );

INSERT INTO
  category (type)
VALUES
  ('Electronics'),
  ('Clothing'),
  ('Home & Garden'),
  ('Books'),
  ('Sports');

INSERT INTO
  product (
    id_category,
    name_product,
    price,
    stock,
    color,
    description
  )
VALUES
  (
    1,
    'Smartphone XYZ',
    699.99,
    50,
    'Black',
    'Latest model smartphone with 128GB storage and high-resolution camera.'
  ),
  (
    2,
    'Graphic T-Shirt',
    19.99,
    150,
    'Blue',
    'Comfortable cotton t-shirt with a graphic print. Available in multiple sizes.'
  ),
  (
    3,
    'Garden Chair Deluxe',
    89.99,
    20,
    'Green',
    'Durable garden chair with ergonomic design and cushion for extra comfort.'
  ),
  (
    4,
    'Programming Book',
    39.99,
    30,
    'Paperback',
    'Comprehensive guide to modern programming languages and best practices.'
  ),
  (
    5,
    'Yoga Mat',
    29.99,
    75,
    'Purple',
    'Non-slip yoga mat with extra cushioning for comfort during workouts.'
  );

INSERT INTO
  `order` (
    id_user,
    total,
    order_date,
    payment_method,
    state
  )
VALUES
  (1, 719.98, '2024-08-01', 'Credit Card', false),
  -- Order including the Smartphone XYZ
  (2, 19.99, '2024-08-02', 'PayPal', true),
  -- Order including the Graphic T-Shirt
  (3, 119.98, '2024-08-03', 'Debit Card', false);

-- Order including Garden Chair Deluxe and Yoga Mat
INSERT INTO
  order_detail (id_order, sub_total, amount)
VALUES
  (1, 699.99, 1),
  -- Order detail for Smartphone XYZ
  (2, 19.99, 1),
  -- Order detail for Graphic T-Shirt
  (3, 89.99, 1),
  -- Order detail for Garden Chair Deluxe
  (3, 29.99, 1);

-- Order detail for Yoga Mat
INSERT INTO
  voucher (id_order, voucher_number)
VALUES
  (1, 'SAVE20'),
  -- Voucher for order 1 with a 20% discount
  (2, 'WELCOME10'),
  -- Voucher for order 2 with a 10% discount
  (3, 'FREESHIP');

-- Voucher for order 3 offering free shipping
INSERT INTO
  product_order_detail (id_product, id_order_detail)
VALUES
  (1, 1),
  -- Smartphone XYZ in order detail 1
  (2, 2),
  -- Graphic T-Shirt in order detail 2
  (3, 3),
  -- Garden Chair Deluxe in order detail 3
  (5, 4);

-- Yoga Mat in order detail 4