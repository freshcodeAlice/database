/*  ALTER  */

DROP TABLE tasks;

CREATE TABLE user_tasks(
    id serial PRIMARY KEY,
    user_id int REFERENCES users,
    body text NOT NULL,
    is_done boolean DEFAULT false,
    deadline timestamp NOT NULL DEFAULT current_timestamp
);

INSERT INTO user_tasks (user_id, body, is_done)
VALUES (14, 'test', false), 
(17, 'hello', true), 
(21, 'need review', false),
(28, 'bye', true);


-- Добавлять столбцы

ALTER TABLE user_tasks
ADD COLUMN created_at timestamp NOT NULL DEFAULT current_timestamp;

ALTER TABLE user_tasks
ADD COLUMN test int;


-- • Удалять столбцы

ALTER TABLE user_tasks
DROP COLUMN test;

-- • Добавлять ограничения

ALTER TABLE user_tasks
ADD CONSTRAINT check_created_time CHECK (created_at <= current_timestamp);

-- add not-null constraint

ALTER TABLE user_tasks
ALTER COLUMN is_done SET NOT NULL;


-- • Удалять ограничения

ALTER TABLE user_tasks
DROP CONSTRAINT check_created_time;

--delete not-null constraint

ALTER TABLE user_tasks
ALTER COLUMN is_done DROP NOT NULL;




-- • Изменять значения по умолчанию
-- добавить, изменение, удаление default

ALTER TABLE user_tasks
ALTER COLUMN is_done
DROP DEFAULT;

ALTER TABLE user_tasks
ALTER COLUMN is_done
SET DEFAULT true;


-- • Изменять типы столбцов

ALTER TABLE user_tasks
ALTER COLUMN body TYPE varchar(512);

-- • Переименовывать столбцы

ALTER TABLE user_tasks
RENAME COLUMN is_done TO status;

-- • Переименовывать таблицы

ALTER TABLE user_tasks RENAME TO tasks;



/*     --------    */

/* Status: 'new', 'processing', 'done', 'overdue' */

/* CREATE TYPE type_name AS ENUM (value1, value2, value3); */

CREATE TYPE tasks_status AS ENUM ('new', 'processing', 'done', 'overdue');

ALTER TABLE tasks
ALTER COLUMN status
TYPE tasks_status;

ALTER TABLE tasks
ALTER COLUMN status
TYPE tasks_status USING (
    CASE status
    WHEN false THEN 'new'
    WHEN true THEN 'done'
    ELSE 'processing'
END
)::tasks_status;