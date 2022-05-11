DROP TABLE users;

CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL CHECK (first_name != ''),
    last_name varchar(64) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL UNIQUE CHECK (email != ''),
    gender varchar(64) NOT NULL,
    is_subscribe boolean NOT NULL,
    birthday date NOT NULL CHECK (birthday < current_date AND birthday > '1900/1/1'),
    height numeric(3,2) NOT NULL CHECK (height > 0.20 AND height < 3.0)
);

INSERT INTO users (first_name, last_name, email, gender, is_subscribe, birthday, height)
VALUES ('First NAme', 'hello', 'test@test.com', 'male', true, '1999-05-10', 1.90),
('world', 'Testovich', 'tes1t@test.com', 'female', true, '1999-05-10', 1.50),
('Test', 'Testovic1h', 'hw@com', 'binary', false, '1999-05-10', 1.90);

--------



DROP TABLE products;

CREATE TABLE products (
    id serial PRIMARY KEY,
    name varchar(64),
    category varchar(128),
    price decimal(16,2),
    quantity int,
    UNIQUE(name, category),
    CHECK (quantity > 0),
    CHECK (price > 0)
);

INSERT INTO products (name, category, price, quantity) VALUES
('samsung s', 'phone', 123.10, 5),
('iphone', 'phone', 2000, 6),
('dell', 'computer', 200.5, 1),
('lenovo', 'computer', 150.2, 3),
('realme 6', 'phone', 150.1, 1);

----

/* Связь 1:m
users - главная,
orders - подчиненная таблица

*/


DROP TABLE orders;

CREATE TABLE orders(
id serial PRIMARY KEY,
created_at timestamp DEFAULT current_timestamp,
customer_id int REFERENCES users(id)
);

INSERT INTO orders (customer_id) VALUES 
(1),
(2),
(2),
(3);

/* 
Связь многие ко многим
m:m

имяТаблицы1_to_имяТаблицы2

*/

DROP TABLE products_to_orders;

CREATE TABLE products_to_orders(
    product_id int REFERENCES products(id),
    order_id int REFERENCES orders(id),
    quantity int,
    PRIMARY KEY(product_id, order_id)
);

INSERT INTO products_to_orders (product_id, order_id, quantity) VALUES
(2, 1, 3),
(3, 1, 1),
(1, 2, 1),
(3, 3, 1),
(5, 4, 2);