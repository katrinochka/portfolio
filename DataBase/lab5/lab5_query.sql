--2а. Пример процедуры из теоретической части лр
/*
CREATE PROCEDURE ins_items (item_id integer, order_id integer, 
							prod_id integer, quantity bigint, total bigint)
LANGUAGE SQL
AS $$
	INSERT INTO items VALUES (item_id, order_id, prod_id, quantity, total);
$$;
*/

--проверка работы
/*
CALL ins_items(14,1,3,5,5);
SELECT * FROM items
*/

--2a. Пример функции из теоретической части лр
/*
CREATE FUNCTION HigherPrice (x real)
RETURNS TABLE (prod_id integer, prname text, prprice numeric)
LANGUAGE SQL
AS $$
	SELECT 	prod_id,
			prname,
			prprice
	FROM products
	WHERE prprice>x
   $$;
*/

--Удаление функции
--DROP FUNCTION HigherPrice;

--проверка работы
--SELECT * FROM HigherPrice(500);

--2b. Функция для поиска информации по названию компании(Поиск покупателя по компании)
--SELECT * FROM customers;

/*
CREATE FUNCTION findCompany(CompanyToFind TEXT)
RETURNS TABLE(
    cust_id INTEGER,
    first_name TEXT,
    last_name TEXT,
    phone TEXT,
    company_name TEXT,
    address TEXT,
    city TEXT,
    index_code INTEGER,
    email TEXT
)
LANGUAGE sql
AS $$
	SELECT *
	FROM customers
	WHERE company_name = CompanyToFind;
   $$;
*/

--проверка работы
--SELECT * FROM findCompany('Компания1');

--2c. Функция для поиска товаров по диапазону цен(Поиск продукта по цене)
--SELECT * FROM products;

/*
CREATE FUNCTION find_products_by_price(min_price NUMERIC, max_price NUMERIC)
RETURNS TABLE(
    prod_id INTEGER,
    prname TEXT,
    prprice NUMERIC,
    instock INTEGER,
    reorder TEXT,
    description TEXT
)
LANGUAGE sql
AS $$
	SELECT *
	FROM products
	WHERE prprice BETWEEN min_price AND max_price;
   $$;
*/

--проверка работы
--SELECT * FROM find_products_by_price(500,700);

--2d. Функция для поиска заказов по дате заказа и/или диапазону дат заказа, 
-- доставки, в зависимости от введенных параметров
--SELECT * FROM orders;

/*
CREATE FUNCTION find_orders_by_dates(
    order_date_from DATE,
    order_date_to DATE,
    ship_date_from DATE,
    ship_date_to DATE
)
RETURNS TABLE(
    order_id INTEGER,
    cust_id INTEGER,
    order_date DATE,
    ship_date DATE,
    paid_date DATE,
    status CHAR
)
LANGUAGE sql
AS $$
	SELECT *
	FROM orders
	WHERE ((order_date_from IS NULL) OR (order_date BETWEEN order_date_from AND order_date_to))
	AND ((ship_date_from IS NULL) OR (ship_date BETWEEN ship_date_from AND ship_date_to));
   $$;
*/

--проверка работы
--SELECT * FROM orders;
--поиск заказов по дате заказа(order_date летом)
--SELECT * FROM find_orders_by_dates('2024-06-01', '2024-08-31', NULL, NULL);
--поиск заказов по дате доставки(ship_date летом)
--SELECT * FROM find_orders_by_dates(NULL, NULL, '2024-06-01', '2024-08-31');
--поиск заказов по дате заказа и доставки(и order_date летом, и ship_date летом)
--SELECT * FROM find_orders_by_dates('2024-06-01', '2024-08-31', '2024-06-01', '2024-08-31');

--2e. Функция по заданию варианта
--Функция для поиска информации о заказе по компании клиента, которые находятся в статусе 'C' 
--SELECT * FROM orders;
--DROP FUNCTION find_orders_by_company_and_status;

/*
CREATE FUNCTION find_orders_by_company_and_status(find_company_name TEXT)
RETURNS TABLE(
    order_id INTEGER,
    cust_id INTEGER,
    order_date DATE,
    ship_date DATE,
    paid_date DATE,
    status CHAR,
    first_name TEXT,
    last_name TEXT,
    company_name TEXT
)
LANGUAGE sql
AS $$
	SELECT 
		o.order_id,
		o.cust_id,
		o.order_date,
		o.ship_date,
		o.paid_date,
		o.status,
		c.first_name,
		c.last_name,
		c.company_name
	FROM orders o
	JOIN customers c ON o.cust_id = c.cust_id
	WHERE c.company_name = find_company_name AND o.status = 'C';
   $$;
*/

--проверка работы
--SELECT * FROM find_orders_by_company_and_status('Компания1');

/*
CREATE FUNCTION find_customers_of_companies(company1 text, company2 text)
RETURNS TABLE (
    cust_id INTEGER,
    first_name text,
	last_name text,
    phone text,
    company_name text
)
LANGUAGE sql
AS $$
	SELECT 
		cust_id INTEGER,
		first_name text,
		last_name text,
		phone text,
		company_name text
	FROM customers
	WHERE company_name = company1 OR company_name = company2;	
$$;
*/

--SELECT * FROM find_customers_of_companies('Компания1', 'Компания3');
--SELECT * FROM customers

--3. Создать триггер INSERT
--Когда в таблицу orders вставляется новая запись, запускается триггер. Триггер выполняет запрос, 
--чтобы найти суммарное количество заказанных товаров (quantity) для данного заказа (order_id) и 
--товара (prod_id) из таблицы items. Триггер обновляет поле instock в таблице products, 
--вычитая из него суммарное количество заказанных товаров.

/*
CREATE FUNCTION update_instock_function()
	RETURNS TRIGGER 
	LANGUAGE plpgsql AS 
	$$
	BEGIN
	  UPDATE products
	  SET instock = instock - (
		SELECT quantity 
		FROM items 
		WHERE order_id = NEW.order_id AND prod_id = NEW.prod_id
	  )
	  WHERE prod_id = (
		SELECT prod_id 
		FROM items 
		WHERE order_id = NEW.order_id AND prod_id = NEW.prod_id
	  );
	  RETURN NEW;
	END;
	$$;
	
CREATE TRIGGER update_instock_on_items_insert
AFTER INSERT ON items
FOR EACH ROW
EXECUTE PROCEDURE update_instock_function();
*/

--проверка работы
--SELECT * FROM products;
--SELECT * FROM items;
--INSERT INTO items VALUES (12,2,6,2,300);

--4. Создать триггер DELETE(пункт 6)
/*
CREATE FUNCTION increase_instock_function()
	RETURNS TRIGGER 
	LANGUAGE plpgsql AS 
	$$
	BEGIN
	  UPDATE products
	  SET instock = instock + (
		SELECT quantity 
		FROM items 
		WHERE order_id = OLD.order_id AND prod_id = OLD.prod_id
	  )
	  WHERE prod_id = (
		SELECT prod_id 
		FROM items 
		WHERE order_id = OLD.order_id AND prod_id = OLD.prod_id
	  );
	  RETURN NEW;
	END;
	$$;
	
CREATE TRIGGER increase_instock_on_items_delete
BEFORE DELETE ON items
FOR EACH ROW
EXECUTE PROCEDURE increase_instock_function();
*/

--проверка работы
--SELECT * FROM products;
--SELECT * FROM items;
--DELETE FROM items WHERE item_id = 12;

--5. Создать триггер UPDATE.
/*
CREATE FUNCTION update_ship_date_on_paid()
	RETURNS TRIGGER 
	LANGUAGE plpgsql AS 
	$$
		BEGIN
  			IF NEW.paid_date IS NOT NULL AND OLD.paid_date IS NULL THEN
    		UPDATE orders
    		SET ship_date = NEW.paid_date
    		WHERE order_id = NEW.order_id;
  			END IF;
  			RETURN NEW;
		END;
	$$;

CREATE TRIGGER update_ship_date_on_paid
AFTER UPDATE ON orders
FOR EACH ROW
WHEN (NEW.paid_date IS NOT NULL AND OLD.paid_date IS NULL)
EXECUTE PROCEDURE update_ship_date_on_paid();
*/

--проверка работы
--SELECT * FROM orders;
--UPDATE orders SET paid_date = '2024-05-27' WHERE order_id = 3;

--6. Создать триггер, который при удалении записи из таблицы Products сначала удаляет 
--все связанные с ней записи из таблицы Items, а затем удаляет саму запись из таблицы Products.
/*
CREATE OR REPLACE FUNCTION delete_product_cascade()
	RETURNS TRIGGER 
	LANGUAGE plpgsql AS $$
	BEGIN
    	-- Удаляем связанные записи из таблицы Items
  		DELETE FROM Items WHERE prod_id = OLD.prod_id;
  		RETURN OLD;
	END;
	$$;

CREATE TRIGGER delete_product_cascade
BEFORE DELETE ON Products
FOR EACH ROW
EXECUTE PROCEDURE delete_product_cascade();
*/

--проверка работы
--SELECT * FROM products;
--SELECT * FROM items;
--DELETE FROM products WHERE prod_id = 9;

--7. Создать триггер DDL, который предотвратит удаление или изменение таблиц в базе данных.
/*
CREATE FUNCTION prevent_ddl_changes()
	RETURNS event_trigger 
	LANGUAGE plpgsql AS $$
	BEGIN
  		RAISE EXCEPTION 'Удаление или изменение таблиц запрещено.';
  		RETURN ;
	END;
	$$;

CREATE EVENT TRIGGER prevent_ddl_changes
ON ddl_command_start
EXECUTE PROCEDURE prevent_ddl_changes();
*/

--проверка работы
--DROP TABLE customers;


