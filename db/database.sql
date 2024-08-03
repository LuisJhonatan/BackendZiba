CREATE DATABASE ZIBA;

USE ZIBA;

CREATE TABLE user(
  id_user INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(9),
  photo VARCHAR(500) DEFAULT "https://i.ibb.co/rcHvPqv/imagen-2024-07-30-231911755.png"
);

CREATE TABLE category(
  id_category INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(50) NOT NULL
);

CREATE TABLE product(
  id_product INT AUTO_INCREMENT PRIMARY KEY,
  id_category INT,
  name_product VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  stock INT NOT NULL,
  color VARCHAR(50) NOT NULL,
  description TEXT,
  FOREING KEY(id_category) REFERENCES category(id_category)
);

CREATE TABLE order(
  id_order INT AUTO_INCREMENT PRIMARY KEY,
  id_user INT,
  total DECIMAL(10, 2) NOT NULL,
  order_date DATE NOT NULL,
  payment_method VARCHAR(255) NOT NULL,
  state BOOLEAN DEFAULT false,
  FOREING KEY (id_user) REFERENCES user(id_user)
);

CREATE TABLE order_detail(
  id_order_detail INT AUTO_INCREMENT PRIMARY KEY,
  id_order INT,
  sub_total DECIMAL(10, 2) NOT NULL,
  amount INT NOT NULL,
  FOREING KEY (id_order) REFERENCES order(id_order)
);

CREATE TABLE voucher(
  id_voucher INT AUTO_INCREMENT PRIMARY KEY,
  id_order INT,
  voucher number VARCHAR(255) NOT NULL,
  FOREING KEY(id_order) REFERENCES order(id_order)
);

CREATE TABLE product_order_detail(
  id_product INT,
  id_order_detail INT,
  FOREING KEY (id_product) REFERENCES product(id_product),
  FOREING KEY (id_order_detail) REFERENCES order_detail(id_order_detail)
);