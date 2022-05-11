DROP TABLE users;

CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL CHECK (first_name != ''),
    last_name varchar(64) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL CHECK (email != ''),
    gender varchar(64) NOT NULL,
    is_subscribe boolean NOT NULL,
    birthday date NOT NULL CHECK (birthday < current_date AND birthday > '1900/1/1'),
    height numeric(3,2) NOT NULL CHECK (height > 0.20 AND height < 3.0),
    CONSTRAINT "UNIQUE_FULL_NAME" CHECK (first_name !='' OR last_name != '')
    UNIQUE(first_name, last_name)
);

INSERT INTO users (first_name, last_name, email, gender, is_subscribe, birthday, height)
VALUES ('First NAme', 'hello', 'test@test.com', 'male', true, '1999-05-10', 1.90),
('world', 'Testovich', 'tes1t@test.com', 'female', true, '1999-05-10', 1.50),
('Test', 'Testovic1h', 'hw@com', 'binary', false, '1999-05-10', 1.90),
('Test', 'Test4ovi1ch', 'test2@test.com', 'other', false, '1999-05-10', 1.80),
('Test', 'Test2ovich', 'teertertert', 'other', true, '1900-05-10', 0.3),
('Test', 'Tes23tovich', 'test3@test.com', 'other', true, '1999-05-10', 2.10);

ALTER TABLE users
ADD CONSTRAINT "UNIQUE_CH" UNIQUE(email);

ALTER TABLE users
DROP CONSTRAINT "UNIQUE_CH";

/*

Создайте таблицу юзеров

1. Пары имя-фамилия не должны повторяться
2. Полное имя - не пустая строка
3. Все юзеры имеют ID
4. Пользователь не должен родиться раньше 1900 года
---
5. Добавить вес пользователя

*/
