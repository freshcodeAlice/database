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


------

SELECT * FROM "users"
WHERE extract('month' from "birthday") = 11 AND extract('day' from "birthday") = 10;

--Alias---

SELECT "id" AS "Порядковый номер", 
"first_name" AS "Имя", 
"last_name" AS "Фамилия", 
"email" AS "Почта"
FROM "users";


SELECT * FROM "users" AS "u"
WHERE "u"."id" = 99;


--Pagination---


SELECT * FROM "users"
LIMIT 15;

SELECT * FROM "users"
LIMIT 15
OFFSET 15;
/* OFFSET - отступ
*/


SELECT * FROM "users"
LIMIT 15
OFFSET 30;

/* OFFSET = LIMIT*page
*/


-----

SELECT "id", 
"first_name" || "last_name" AS "Full name"
FROM "users";


SELECT "id", 
"first_name" || ' ' || "last_name" AS "Full name"
FROM "users";

SELECT "id", 
concat("first_name", ' ', "last_name") AS "Full name"
FROM "users";


/*

Получить всех юзеров, у которых длина полного имени больше 15 символов

*/

SELECT "id", 
concat("first_name", ' ', "last_name") AS "Full name"
FROM "users"
WHERE char_length(concat("first_name", ' ', "last_name")) > 15;


SELECT * FROM
    (SELECT "id", 
    concat("first_name", ' ', "last_name") AS "Full name"
    FROM "users") AS "FN"
WHERE char_length("FN"."Full name") > 15;

------


SELECT * FROM "users"
WHERE extract('year' from age("birthday")) = 27;


----Агрегатные функции------

/*
avg - среднее арифметическое
sum - сумма всех значений
min - минимальное из значений
max - максимальное из значений
count - количество значений


*/


SELECT max("height") FROM "users";

SELECT min("height") FROM "users";

SELECT count(*) FROM "users";

SELECT avg("weight") FROM "users";

-----

SELECT avg("weight"), "gender"
FROM "users"
GROUP BY "gender";

SELECT max("weight"), "gender"
FROM "users"
WHERE extract('year' from age("birthday")) > 18
GROUP BY "gender";


SELECT count(*), "gender"
FROM "users"
WHERE extract('year' from age("birthday")) > 18
GROUP BY "gender";

/*
Практика:

1. Средний рост всех пользователей
2. Средний рост всех мужчин и женщин отдельно
3. Минимальный и максимальный рост мужчин и женщин
4. Количество юзеров, родившихся после 1998г.
5. Количество людей по определенному имени.
6. Количество людей в возрасте от 20 до 30 лет.


*/



SELECT avg(weight), gender 
FROM users
GROUP BY gender;



--  1. Посчитать количество телефонов, которые были проданы 
--  (то есть количестве телефонов в заказах).
 
 SELECT sum(quntity) FROM orders_to_phones;

--  2. Количество телефонов, которые есть на "складе".
SELECT sum(quntity) FROM phones;

--  3. Средняя цена всех телефонов
SELECT avg(price) FROM phones;

--  4. Средняя цена каждого бренда
SELECT avg(price), brand FROM phones
GROUP BY brand;

--  5. Стоимость всех товаров (цена*количество) 
--  на складе в диапазоне их цен от 1000 до 2000.
SELECT sum(quantity*price)
FROM phones
WHERE price BETWEEN 1000 AND 2000;


--  6. Количество моделей каждого бренда
SELECT count(*), brand FROM phones
GROUP BY brand;


-- проверяем
SELECT * FROM phones
WHERE brand = 'Nokia';

--  7. Количество заказов каждого пользователя, который совершал заказы.
SELECT count(*), user_id
FROM orders
GROUP BY user_id;
 
--  8. Средняя цена телефонов Nokia.
SELECT avg(price)
FROM phones
WHERE brand = 'Nokia';

/*

Фильтрация групп,
Сортировка

*/

SELECT * 
FROM phones
ORDER BY quantity ASC
LIMIT 10;


-- Sorting

/* 
ORDER BY field {ASC|DESC}
*/

-- по высоте, возр.

SELECT * 
FROM users
ORDER BY height ASC;

-- по высоте, если высота одинаковая - то по дате рождения

SELECT * 
FROM users
ORDER BY height ASC, birthday ASC ;

--если и высота, и дата рождения одинаковые, отсортируй еще и по имени, по нисходящей
SELECT * 
FROM users
ORDER BY height ASC, birthday ASC, first_name DESC ;



/*
2. Отсортируйте телефоны по цене, от самого дорогого до самого дешевого.
*/
SELECT * FROM phones
ORDER BY price DESC;

/*
1. Отсортируйте пользователей по возрасту (по количеству полных лет) и по имени, если они одногодки.
*/
SELECT *, extract('year' from age(birthday)) AS "Age"
FROM users
ORDER BY extract('year' from age(birthday)), first_name ASC;

--количестве одногодок

SELECT count(*), "Age" 
FROM
(SELECT *, 
extract('year' from age(birthday)) AS "Age"
FROM users) AS "u_w_age"
GROUP BY "Age"
ORDER BY "Age";

/*
Фильтрация групп
HAVING
*/

SELECT count(*), "Age" 
FROM
(SELECT *, 
extract('year' from age(birthday)) AS "Age"
FROM users) AS "u_w_age"
GROUP BY "Age"
HAVING count(*) >= 10
ORDER BY count(*) DESC;

/*
Извлечь все бренды, у которых количество телефонов > 1000, отсортировать по алфавиту
*/

SELECT sum(quantity), brand
FROM phones
GROUP BY brand
HAVING sum(quantity) > 1000;

/*
text pattern

LIKE
ILIKE

SIMILAR TO

~ -- регулярка
~* -- регулярка с игнором кейза

!~ - not 
!~* - not с игнором кейза

*/

SELECT * FROM users
WHERE first_name ILIKE 'A%'; --'Aba' 'aba'

--'%' = *
--'_' = .


SELECT * FROM users
WHERE first_name SIMILAR TO '%i{2}%';

SELECT * FROM users
WHERE first_name ~ '.*i{2}.*'; --регистрозависимый запрос

SELECT * FROM users
WHERE first_name ~* '.*i{2}.*'; --регистрозависимый запрос


/*
Среди всех сообщений в таблице "сообщения" найти слово "паровоз"
*/

SELECT * FROM "messages"
WHERE body ILIKE '%паровоз%';

