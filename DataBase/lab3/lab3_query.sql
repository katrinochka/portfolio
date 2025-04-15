-- 1) Создать любое простое представление и запросить с помощью него данные.
-- 2) Проверить соответствие данных прямым запросом.
--содержание таблицы orders
/*
SELECT 	* FROM orders
WHERE paid_date IS NOT NULL
ORDER BY order_id;
*/

--создание представления PaidOrders
/*
CREATE OR REPLACE VIEW PaidOrders AS
SELECT 	* 
FROM orders
WHERE paid_date IS NOT NULL;
*/

--удаление представления PaidOrders
--DROP VIEW PaidOrders;

--запрос данных с помощью представления
/*
SELECT * 
FROM PaidOrders
ORDER BY order_id;
*/

-- 3) Изменить созданное представление с помощью команды ALTER VIEW, добавив псевдонимы полям.
--изменение наименования колонки order_id на paid_order_id
--ALTER VIEW PaidOrders RENAME COLUMN order_id to paid_order_id;

--запрос данных с помощью представления
/*
SELECT * 
FROM PaidOrders
ORDER BY paid_order_id;
*/

-- 4) Изменить запрос созданного представления с помощью команды CREATE OR REPLACE VIEW, добавив в него условие.
/*
CREATE OR REPLACE VIEW PaidOrders AS 
SELECT 	order_id as paid_order_id,
		cust_id,
		order_date,
		ship_date,
		paid_date,
		status
FROM orders 
WHERE 	paid_date IS NOT NULL 
		AND 
		status = 'P'; 
--ALTER VIEW PaidOrders RENAME COLUMN order_id to paid_order_id;
*/

-- 5) Вставить данные с помощью представления.
/*
INSERT INTO PaidOrders (paid_order_id, cust_id, order_date, ship_date, paid_date, status)
VALUES
  (21, 3, '2024-04-24', '2024-05-16', '2024-06-16', 'P'),
  (14, 2, '2024-04-19', '2024-05-11', '2024-06-13', 'P'),
  (15, 3, '2024-04-20', '2024-05-12', '2024-06-14', 'P'),
  (16, 4, '2024-04-21', '2024-05-13', '2024-06-15', 'P'),
  (17, 6, '2024-04-22', '2024-05-14', '2024-06-16', 'P');
*/

-- 6) Создать представление с опцией WITH CHECK OPTION, проверить работу.
/*
CREATE VIEW unpaid_orders AS
SELECT *
FROM orders
WHERE status = 'C' 
	AND status IS NOT NULL
WITH CHECK OPTION;
*/

/*
SELECT * 
FROM unpaid_orders
ORDER BY order_id;
*/

/*
INSERT INTO unpaid_orders (order_id, cust_id, order_date, ship_date, paid_date, status)
VALUES
  (20, 5, '2024-06-18', '2024-07-10', '2024-08-12', null);
*/

-- 7) Удалить представление.
--DROP VIEW unpaid_orders;

-- 8) Создать представление на выборку из двух таблиц с помощью редактора.
/*
SELECT * 
FROM view_cust_ord
ORDER BY cust_id, order_id;
*/

-- 9) Создать роль Test_creator без права входа в систему, но с правом создания БД и ролей.
/*
CREATE ROLE Test_creator
WITH
	CREATEDB
  	CREATEROLE;
*/

/*
CREATE ROLE Test_creator
WITH
  CREATEDB
  CREATEROLE;
GRANT CONNECT ON DATABASE sales TO Test_creator;
GRANT USAGE ON SCHEMA public TO Test_creator;
*/

-- 10) Создать пользователя user1 с правом входа в систему. Убедиться, что user1 не может создать БД.
--/*
--CREATE USER user1 WITH PASSWORD 'user1_pass';
--*/

-- 11) Включить пользователя user1 в группу Test_creator.
--/*
--GRANT test_creator TO user1;
--*/
--SET ROLE test_creator;

-- 12) Создать БД под пользователем user1, для проверки создать новое подключение для пользователя user1 с ролью Test_creator.
--/*

--*/

-- 13) Создать роли без права создания таблицы и с правом создания таблицы, последовательно проверить работу ролей.
/*
CREATE ROLE no_create_table_role;
GRANT CONNECT ON DATABASE sales TO no_create_table_role;
*/

/*
CREATE ROLE create_table_role;
GRANT CONNECT ON DATABASE sales TO create_table_role;
GRANT CREATE ON SCHEMA public TO create_table_role;
*/

--CREATE USER user_cust PASSWORD 'user_cust_pass';
--GRANT create_table_role TO user_cust;

--REVOKE create_table_role FROM user_cust;
--GRANT no_create_table_role TO user_cust;
--REVOKE no_create_table_role FROM user_cust;

-- 14) Добавить к роли право на любые действия с таблицей, проверить работу прав.
--GRANT SELECT, INSERT, UPDATE, DELETE on TABLE customers TO user_cust;
--REVOKE SELECT, INSERT, UPDATE, DELETE on TABLE customers FROM user_cust;

-- 15) Удалить право вставки в таблицу, проверить работу прав.
--REVOKE INSERT on TABLE customers FROM user_cust;
