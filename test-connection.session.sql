DROP TABLE users;

CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL CHECK (first_name != ''),
    last_name varchar(64) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL CHECK (email != ''),
    gender varchar(64) NOT NULL,
    is_subscribe boolean NOT NULL,
    birthday date NOT NULL CHECK (birthday < current_date),
    height numeric(3,2) NOT NULL CHECK (height > 0.20 AND height < 3.0)
);

INSERT INTO users (first_name, last_name, email, gender, is_subscribe, birthday, height)
VALUES ('First NAme', 'hello', 'test@test.com', 'male', true, '1999-05-10', 1.90),
('world', 'Testovich', 'tes1t@test.com', 'female', true, '1999-05-10', 1.50),
('Test', 'Testovich', 'hw@com', 'binary', false, '1999-05-10', 1.90),
('Test', 'Testovich', 'test2@test.com', 'other', false, '1999-05-10', 1.80),
('Test', 'Testovich', 'teertertert', 'other', true, '1200-05-10', 0.3),
('Test', 'Testovich', 'test3@test.com', 'other', true, '1999-05-10', 2.10);

ALTER TABLE users
ADD CONSTRAINT "UNIQUE_CH" UNIQUE(email);