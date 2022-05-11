DROP TABLE users;

CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL CONSTRAINT "FN_CH_NOT_EMPTY" CHECK (first_name != ''),
    last_name varchar(64) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL UNIQUE CHECK (email != ''),
    gender varchar(64) NOT NULL,
    is_subscribe boolean NOT NULL,
    birthday date NOT NULL CHECK (birthday < current_date),
    height numeric(3,2) NOT NULL CHECK (height > 0.20 AND height < 3.0)
);

INSERT INTO users (first_name, last_name, email, gender, is_subscribe, birthday, height)
VALUES ('', 'hello', 'test@test.com', 'male', true, '1999-05-10', 1.90),
('world', 'Testovich', 'tes1t@test.com', 'female', true, '1999-05-10', 1.50),
('Test', 'Testovich', 'hw@com', 'binary', false, '1999-05-10', 1.90),
('Test', 'Testovich', 'test2@test.com', 'other', false, '1999-05-10', 1.80),
('Test', 'Testovich', 'teertertert', 'other', true, '1200-05-10', 0.3),
('Test', 'Testovich', 'test3@test.com', 'other', true, '1999-05-10', 2.10);



DROP TABLE messages;

CREATE TABLE messages(
id serial CONSTAINT "PK_ID" PRIMARY KEY,
body varchar(5000) NOT NULL,
author varchar(64) NOT NULL,
create_at timestamp DEFAULT current_timestamp,
is_read boolean NOT NULL DEFAULT false
);

/* определяем порядок передачи значений*/

INSERT INTO messages (author, body)
 VALUES 
('Test Testovich', 'message'),
('Test Testovich', 'message'),
('Test Testovich', 'message');


-----

DROP TABLE A;

CREATE TABLE A(
    b int,
    c int,
 PRIMARY KEY (b,c)
);

INSERT INTO A VALUES
(1, 1),
(1, 2),
(1, 1);