/*
Create - INSERT - DML
Read - SELECT - DQL
Update - UPDATE - DML
Delete - DELETE - DML
*/

SELECT "id", "first_name", "last_name" FROM "users";

SELECT *
FROM "users"
WHERE "gender" = 'male';

/*

1. Получить всех юзеров, у которых четный id
2. Получить всех юзеров, у которых высота больше 1.5
3. Получить всех юзеров женского пола
4. Для тех, кто уже всё сделал -
Получить всех подписанных (subscribed) юзеров мужского пола выше 1.90

*/

SELECT * 
FROM "users"
WHERE "id" % 2 = 0;

SELECT * 
FROM "users"
WHERE "height" > 1.5;

SELECT * 
FROM "users"
WHERE "is_subscribe" = true AND "gender" = 'male' AND "height" > 1.8;

-----

SELECT * 
FROM "users"
WHERE "first_name" IN ('John', 'Jane', 'William');

 /* SELECT * 
FROM "users"
WHERE "first_name" = 'John' 
OR "firt_name" = 'Jane'
OR "first_name" = 'William';
*/

------


SELECT *
FROM "users"
WHERE "height" > 1.5 AND "height" < 1.9;

SELECT *
FROM "users"
WHERE "height" BETWEEN 1.5 AND 1.9;

-----

/*
Получить пользователей с id между 105 и 170
*/

SELECT *
FROM "users"
WHERE "id" BETWEEN 1000 AND 2000;

-------

SELECT *
FROM "users"
WHERE "first_name" LIKE 'K%';

SELECT *
FROM "users"
WHERE "first_name" LIKE '___';

/*
% - любое количество любых символов
_ - 1 любой символ

*/

ALTER TABLE "users"
ADD COLUMN "weight" int CHECK ("weight" != 0);

UPDATE "users"
SET "weight" = 60;

UPDATE "users"
SET "weight" = 65
WHERE "id" = 25;

UPDATE "users"
SET "weight" = 80
WHERE "height" > 1.8;

/*
Пример:
Таблица Employees
- id
- name
- salary
- work_hours


UPDATE "Employees"
SET "salary" = "salary" * 1,2
WHERE work_hours > 150;

*/


-----

DELETE FROM "users"
WHERE "id" = 5;

DELETE FROM "users"
WHERE "height" = 1.95;

SELECT * FROM "users";


------

UPDATE "users"
SET "weight" = 85
WHERE "id" = 12
RETURNING *;

DELETE FROM "users"
WHERE "id" = 6
RETURNING "id", "first_name", "last_name";

INSERT INTO users (first_name, last_name, email, gender, is_subscribe, birthday, height)
VALUES ('First Name', 'helrrrlo', 'rewer@tewerwert.com', 'male', true, '1999-05-10', 1.90)
RETURNING id;

--------


/*
1. Получить всех юзеров женского пола, имя которых начинается на "А".
2. Получить всех пользователей, которые родились в сентябре.
3. Получить всех, кому от 20 до 40 лет.
4. Получить всех совершеннолетних юзеров

*/


--4--

SELECT * FROM "users"
WHERE age("birthday") > make_interval(18);

SELECT * FROM "users"
WHERE extract('year' from "birthday") > 18;

--age(дата)
--make_interval(18)

--2--

SELECT * FROM "users"
WHERE extract('month' from "birthday") = 9;


--3--

SELECT * FROM "users"
WHERE age("birthday") > make_interval(20)
AND age("birthday") < make_interval(40);