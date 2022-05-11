DROP TABLE users;

/* CHECK (условие) */

CREATE TABLE users(
    first_name varchar(64) NOT NULL CHECK (first_name != ''),
    last_name varchar(64) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL UNIQUE CHECK (email != ''),
    gender varchar(64) NOT NULL,
    isSubscribe boolean NOT NULL,
    birthday date NOT NULL CHECK (birthday < current_date),
    height numeric(3,2) NOT NULL CHECK (height > 0.20 AND height < 3.0)
);

INSERT INTO users 
VALUES ('Test', 'hello', 'test@test.com', 'male', true, '1999-05-10', 1.90),
('world', 'Testovich', 'test1@test.com', 'female', true, '1999-05-10', 1.50),
('Test', 'Testovich', 'hw@com', 'binary', false, '1999-05-10', 1.90),
('Test', 'Testovich', 'test2@test.com', 'other', false, '1999-05-10', 1.80),
('Test', 'Testovich', 'teertertert', 'other', true, '1200-05-10', 0.3),
('Test', 'Testovich', 'test3@test.com', 'other', true, '1999-05-10', 2.10);