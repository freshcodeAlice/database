/* Удаляем таблицы, если они были - в порядке подчиненности, сначала удаляются подчиненные таблицы, потом главные (а иначе главные и не удалятся вовсе, если на них кто-то ссылается*/

DROP TABLE IF EXISTS "orders_to_phones"; 
DROP TABLE IF EXISTS "phones"; 
DROP TABLE IF EXISTS "orders"; 

/* Создаем их все заново, определяем столбцы */
/* Структура такая:
Таблица телефонов содержит товары(телефоны)
Таблица заказов относится к таблице юзеров как 1:m
Таблица заказов_к_телефонам - связующая таблица для телефонов и заказов
(связь m:n)

*/


CREATE TABLE "phones"(
    "id" serial PRIMARY KEY,
    "brand" varchar(64) NOT NULL CHECK ("brand" != ''),
    "model" varchar(64) NOT NULL CHECK ("model" != ''),
    "quantity" int NOT NULL CHECK ("quantity" > 0),
    "price" decimal(16, 2) NOT NULL CHECK ("price" > 0),
    UNIQUE ("brand", "model")
);

CREATE TABLE "orders"(
    "id" serial PRIMARY KEY,
   "user_id" int REFERENCES "users"("id")
);

CREATE TABLE "orders_to_phones"(
    "phone_id" int REFERENCES "phones"("id"),
   "order_id" int REFERENCES "orders"("id"),
   "quantity" int NOT NULL CHECK ("quantity" > 0),
   "status" boolean NOT NULL DEFAULT false,
   PRIMARY KEY("phone_id", "order_id")
);