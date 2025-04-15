--a. Запрос, выбирающий все данные из таблицы
/*
SELECT * FROM customers;
*/

--b. Запрос, выбирающий данные из некоторых столбцов таблицы
/*
SELECT 	first_name, 
		last_name, 
		phone 
FROM customers;
*/

--c. Запрос с использованием сортировки данных
/*
SELECT * 
FROM products 
ORDER BY prprice DESC;
*/

--d. Запрос с использованием ограничения на выборку данных
/*
SELECT * 
FROM orders 
LIMIT 5;
*/

--e. Запрос с использованием операторов сравнения
/*
SELECT * 
FROM customers 
WHERE city = 'Город1';
*/

--f. Запрос с использованием оператора BETWEEN
/*
SELECT * 
FROM products 
WHERE prprice BETWEEN 100 AND 500;
*/

--g. Запрос с использованием оператора IN, содержащий подзапрос
/*
SELECT * 
FROM customers 
WHERE cust_id IN (
					SELECT cust_id 
					FROM orders
					WHERE status = 'C')
ORDER BY cust_id;
*/
-- вспомогательные запросы
/*
SELECT * 
FROM orders
WHERE status = 'C' 
*/

--h. Запрос с использованием оператора LIKE и строковых функций
/*
SELECT cust_id, first_name, last_name, email 
FROM customers 
WHERE email LIKE '%mail.ru'
ORDER BY cust_id;
*/

--i. Запрос с использованием предиката IS NULL
/*
SELECT * 
FROM customers 
WHERE address IS NULL
ORDER BY cust_id;
*/

--j. Запрос с использованием агрегатных функций
/*
SELECT COUNT(*) AS all_customers 
FROM customers
*/

--k. Запрос с использованием агрегатных функций и предложения HAVING
/*
SELECT 	cust_id, 
		COUNT(*) AS total_orders 
FROM orders 
GROUP BY cust_id 
		HAVING COUNT(*) > 2
ORDER BY cust_id;
*/
-- вспомогательные запросы
/*
SELECT 	* 
FROM orders;
*/

--l. Запрос, выбирающий данные из нескольких таблиц с использованием соединения по предикату
/*
SELECT 	c.first_name, 
		c.phone,
		o.order_date 
FROM customers c 
		JOIN orders o 
		ON c.cust_id = o.cust_id
ORDER BY c.cust_id;
*/

--m. Запрос с использованием ключевого слова DISTINCT
/*
SELECT DISTINCT city 
FROM customers
ORDER BY city;
*/
-- вспомогательные запросы
/*
SELECT * 
FROM customers;
*/

--n. Запрос с использованием оператора EXISTS
/*
SELECT cust_id, first_name, last_name  
FROM customers 
WHERE EXISTS (
			SELECT * 
			FROM orders 
			WHERE customers.cust_id = orders.cust_id)
ORDER BY cust_id;
*/
--SELECT * FROM customers ORDER BY cust_id
-- вспомогательные запросы
/*
SELECT * 
FROM orders 
ORDER BY cust_id;
*/

--o. Запрос с использованием функции CASE
/*
SELECT prname, 
       prprice,
	   CASE
           WHEN prprice > 500 THEN 'Дорого'
           ELSE 'Дешево'
       END AS price_category
FROM products
ORDER BY prname;
*/

--По вариантам(3)
--1. Из таблицы ORDERS выбрать заказы со сроком даты заказа более ранним, 
--   чем <любая дата>. Список отсортировать по номеру
--   заказа в обратном порядке.
/*
SELECT * 
FROM orders 
WHERE order_date < '2024-05-05'
ORDER BY order_id DESC;
*/

--2. Получить информацию о покупателях, которые не сделали ни
--   одного заказа. Список отсортировать по фамилии.
/*
SELECT 	c.cust_id, 
		c.first_name, 
		c.last_name,
		c.phone
FROM customers c
		LEFT JOIN orders o 
		ON c.cust_id = o.cust_id
WHERE o.cust_id IS NULL
ORDER BY c.last_name;
*/
-- вспомогательные запросы
/*
SELECT 	*
FROM orders 
ORDER BY cust_id;
*/
/*
SELECT 	*
FROM customers c
		LEFT JOIN orders o 
		ON c.cust_id = o.cust_id
ORDER BY c.cust_id;
*/
/*
SELECT	cust_id,
		COUNT(*) AS l
FROM orders
GROUP BY cust_id
	HAVING COUNT(*)>0
*/

--SELECT COUNT(*) AS ALL 
--FROM customers