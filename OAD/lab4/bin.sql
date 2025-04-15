-- 1.1 TASK --
-- Создание таблицы Client
/*
CREATE TABLE Client (
    ID SERIAL PRIMARY KEY,
    LastName VARCHAR(255),
    FirstName VARCHAR(255),
    MiddleName VARCHAR(255),
    PassportData VARCHAR(255)
);
*/

-- Создание таблицы Pledge
/*
CREATE TABLE Pledge (
    ID SERIAL PRIMARY KEY,
    ClientID INTEGER REFERENCES Client(ID),
    Item VARCHAR(255),
    ItemValue NUMERIC(10, 2),
    IssueAmount NUMERIC(10, 2),
    Commission NUMERIC(10, 2),
    ReturnDate DATE,
    Status VARCHAR(20)
);
*/

-- Создание таблицы History
/*
CREATE TABLE History (
    ID SERIAL PRIMARY KEY,
    PledgeID INTEGER REFERENCES Pledge(ID),
    OperationDate DATE,
    OperationType VARCHAR(20),
    Amount NUMERIC(10, 2)
);
*/

-- 1.2 TASK --
-- Вставка данных в таблицу Client
/*
INSERT INTO Client (LastName, FirstName, MiddleName, PassportData) VALUES
('Иванов', 'Иван', 'Иванович', '1234 567890'),
('Петров', 'Петр', 'Петрович', '9876 543210'),
('Сидоров', 'Сидор', 'Сидорович', '1011 121314'),
('Кузнецов', 'Кузьма', 'Кузьмич', '2222 333344'),
('Смирнов', 'Сергей', 'Сергеевич', '5555 666677'),
('Васильев', 'Василий', 'Васильевич', '8888 999900'),
('Соколов', 'Софрон', 'Софронович', '1111 222233'),
('Михайлов', 'Михаил', 'Михайлович', '4444 555566'),
('Федоров', 'Федор', 'Федорович', '7777 888899'),
('Попов', 'Павел', 'Павлович', '0000 111122');
*/

-- Вставка данных в таблицу Pledge
/*
INSERT INTO Pledge (ClientID, Item, ItemValue, IssueAmount, Commission, ReturnDate, Status) VALUES
(1, 'Золотые часы', 5000, 4000, 500, '2023-12-31', 'Выдан'),
(2, 'Ноутбук', 15000, 12000, 1000, '2024-01-15', 'Выдан'),
(3, 'Телевизор', 8000, 6000, 400, '2023-11-20', 'Возвращен'),
(1, 'Кольцо с бриллиантом', 12000, 9000, 800, '2024-02-10', 'Выдан'),
(2, 'Смартфон', 3000, 2500, 200, '2023-12-20', 'Выдан'),
(3, 'Фотоаппарат', 7000, 5000, 300, '2023-11-25', 'Возвращен'),
(1, 'Серебряная цепочка', 2000, 1500, 100, '2024-01-05', 'Выдан'),
(2, 'Планшет', 10000, 8000, 500, '2024-02-01', 'Выдан'),
(3, 'Видеокамера', 12000, 9000, 600, '2023-12-10', 'Выдан'),
(1, 'Золотая подвеска', 4000, 3000, 200, '2024-03-15', 'Выдан');
*/

-- Вставка данных в таблицу History
/*
INSERT INTO History (PledgeID, OperationDate, OperationType, Amount) VALUES
(1, '2023-11-10', 'Выдача', 4000),
(2, '2023-12-01', 'Выдача', 12000),
(3, '2023-11-15', 'Выдача', 6000),
(3, '2023-11-20', 'Возврат', 6000),
(1, '2023-11-15', 'Просрочка', 500),
(2, '2023-12-05', 'Просрочка', 1000),
(3, '2023-11-28', 'Просрочка', 400),
(1, '2023-11-20', 'Выдача', 9000),
(2, '2023-12-08', 'Выдача', 8000),
(3, '2023-12-02', 'Выдача', 9000);
*/

-- 3 TASK --
-- Функция принадлежности для "Стоимость товара (ItemValue)"
/*
CREATE FUNCTION fun_ItemValue(cur_cost numeric) 
RETURNS VARCHAR AS $$ 
BEGIN
	IF cur_cost < 4000 THEN
		RETURN 'low';
	ELSIF cur_cost BETWEEN 4000 AND 10000 THEN
		RETURN 'medium';
	ELSE
		RETURN 'high';
	END IF;
END;
$$ LANGUAGE plpgsql;
*/

-- Функция принадлежности для "Сумма выдачи (IssueAmount)"
/*
CREATE OR REPLACE FUNCTION fun_IssueAmount(cur_amount numeric) 
RETURNS VARCHAR AS $$ 
BEGIN
	IF cur_amount < 2500 THEN
		RETURN 'small';
	ELSIF cur_amount BETWEEN 2500 AND 7500 THEN
		RETURN 'medium';
	ELSE
		RETURN 'large';
	END IF;
END;
$$ LANGUAGE plpgsql;
*/

-- Функция принадлежности для "Срок возврата (ReturnDate)"
/*
CREATE FUNCTION fun_ReturnDate(cur_date date) 
RETURNS VARCHAR AS $$ 
BEGIN
	IF cur_date - CURRENT_DATE <= 30 THEN
		RETURN 'short';
	ELSIF cur_date - CURRENT_DATE BETWEEN 31 AND 90 THEN
		RETURN 'medium';
	ELSE
		RETURN 'long';
	END IF;
END;
$$ LANGUAGE plpgsql;
*/

-- 4 TASK --
--Пример 1: “Найти клиентов, которые заложили товар с высокой стоимостью”:
/*
SELECT 
    c.LastName,
    c.FirstName,
    c.MiddleName,
	p.itemvalue,
	p.Item
FROM 
    Client c
	JOIN Pledge p 
		ON c.ID = p.ClientID
WHERE 
    fun_ItemValue(p.itemvalue) = 'high';
*/
	
--Пример 2: “Найти залоги с малой суммой выдачи и коротким сроком возврата”:
/*
SELECT 
    p.Item,
    p.IssueAmount,
    p.ReturnDate
FROM 
    Pledge p
WHERE 
    fun_IssueAmount(p.IssueAmount) = 'small' AND fun_ReturnDate(p.ReturnDate) = 'short';
*/

--Пример 3: “Найти клиентов, которые заложили товар с высокой стоимостью и получили большую сумму выдачи”:
/*
SELECT 
    c.LastName,
    c.FirstName,
    c.MiddleName
FROM 
    Client c
JOIN 
    Pledge p ON c.ID = p.ClientID
WHERE 
    fun_ItemValue(p.itemvalue) = 'high' AND fun_IssueAmount(p.IssueAmount) = 'large';
*/
	
--Пример 4: “Найти залоги с высокой стоимостью, но с низкой суммой выдачи”:
/*
SELECT 
    p.Item,
    p.itemvalue,
    p.IssueAmount
FROM 
    Pledge p
WHERE 
    fun_ItemValue(p.itemvalue) = 'high' AND fun_IssueAmount(p.IssueAmount) = 'small';
*/
	
--Пример 5: “Найти клиентов, которые заложили товар с низкой стоимостью, но получили большую сумму выдачи”:
/*
SELECT 
    c.LastName,
    c.FirstName,
    c.MiddleName
FROM 
    Client c
JOIN 
    Pledge p ON c.ID = p.ClientID
WHERE 
    fun_ItemValue(p.itemvalue) = 'low' AND fun_IssueAmount(p.IssueAmount) = 'large';
*/

-- 5 TASK --
/*
CREATE OR REPLACE FUNCTION fun_IssueAmount_mod(cur_amount numeric) 
RETURNS VARCHAR AS $$ 
BEGIN
	IF cur_amount < 2500 THEN
		RETURN 'small';
	ELSIF cur_amount BETWEEN 2500 AND 5000 THEN
		RETURN 'medium_low';
	ELSIF cur_amount BETWEEN 5000 AND 10000 THEN
		RETURN 'medium_high';
	ELSE
		RETURN 'large';
	END IF;
END;
$$ LANGUAGE plpgsql;
*/

/*
SELECT 
    c.LastName,
    c.FirstName,
    c.MiddleName,
    p.Item,
    p.itemvalue,
    p.IssueAmount
FROM 
    Client c
JOIN 
    Pledge p ON c.ID = p.ClientID
WHERE 
    fun_ItemValue(p.itemvalue) = 'high' 
    AND fun_IssueAmount_mod(p.IssueAmount) IN ('medium_high', 'medium_low');
*/
	
-- 6 TASK --
--Пример 1: “Найти клиентов, у которых уровень соответствия высокой стоимости товара и большой суммы выдачи выше 0.8”:
/*
SELECT 
    c.LastName,
    c.FirstName,
    c.MiddleName,
    p.Item,
    p.itemvalue,
    p.IssueAmount,
    p.IssueAmount / 12000 AS CI
FROM 
    Client c
JOIN 
    Pledge p ON c.ID = p.ClientID
WHERE 
    fun_ItemValue(p.itemvalue) = 'high'
    AND (p.IssueAmount / 12000) > 0.8;
*/

--Пример 2: “Найти клиентов, у которых уровень соответствия низкой стоимости товара и маленькой суммы выдачи выше 0.7”:
/*
SELECT 
    c.LastName,
    c.FirstName,
    c.MiddleName,
    p.Item,
    p.itemvalue,
    p.IssueAmount,
    p.IssueAmount / 12000 AS CI
FROM 
    Client c
JOIN 
    Pledge p ON c.ID = p.ClientID
WHERE 
    fun_ItemValue(p.itemvalue) = 'low'
    AND p.IssueAmount / 12000 > 0.7;
*/

--Пример 3: “Найти залоги с высокой стоимостью и коротким сроком возврата, где уровень соответствия выше 0.6”:
/*
SELECT 
    p.Item,
    p.itemvalue,
    p.ReturnDate,
    p.IssueAmount,
    p.IssueAmount / 12000 AS CI
FROM 
    Pledge p
WHERE 
    fun_ItemValue(p.itemvalue) = 'high'
    AND fun_ReturnDate(p.ReturnDate) = 'short'
    AND p.IssueAmount / 12000 > 0.6;
*/

--Пример 4: “Найти залоги с высокой стоимостью, но с “не очень большой” суммой выдачи, где уровень соответствия выше 0.5”:
/*
SELECT
    p.Item,
    p.itemvalue,
    p.IssueAmount,
    p.IssueAmount / 12000 AS CI
FROM
    Pledge p
WHERE
    fun_ItemValue(p.itemvalue) = 'high'
    AND fun_IssueAmount_mod(p.IssueAmount) IN ('medium_high', 'medium_low')
    AND p.IssueAmount / 12000 > 0.5;
*/

--Пример 5: “Найти залоги, которые соответствуют средней стоимости товара и средней сумме выдачи, где уровень соответствия выше 0.4”:
/*
SELECT 
    p.Item,
    p.itemvalue,
    p.IssueAmount,
    p.IssueAmount / 12000 AS CI
FROM 
    Pledge p
WHERE 
    fun_ItemValue(p.itemvalue) = 'medium'
    AND fun_IssueAmount(p.IssueAmount) = 'medium'
    AND p.IssueAmount / 12000 > 0.4;
*/

/*
SELECT *
FROM client
*/

/*
SELECT *
FROM history
*/

/*
SELECT *
FROM pledge
*/

