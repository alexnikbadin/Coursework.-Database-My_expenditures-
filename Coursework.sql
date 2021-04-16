/*  Данная база данных позволяет хранить и структурировать доходы
 * и расходы человека. В данной базе представлены таблицы учета доходов, расходов, типов валют, типов расчетов(нал/безнал),
 * бюджета, типов расходов, платежных аккаунтов, сбережений и пожеланий.
 */



DROP DATABASE my_expenditures;
CREATE DATABASE my_expenditures;

USE my_expenditures;

SHOW tables;

/*
DROP TABLE IF EXISTS dates;
CREATE TABLE dates(
id INT PRIMARY KEY AUTO_INCREMENT,
my_dates TIMESTAMP

-- FOREIGN KEY(period_type) REFERENCES periods_types(id)
);*/


DROP TABLE IF EXISTS income;
CREATE TABLE income(
id INT NOT NULL PRIMARY KEY,
amount BIGINT NOT NULL,
income_type INT NOT NULL,
currency_type INT NOT NULL,
payment_type INT NOT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_income_ct FOREIGN KEY(currency_type) REFERENCES currency_types(id),
CONSTRAINT fk_income_pt FOREIGN KEY(payment_type) REFERENCES payment_types(id),
CONSTRAINT fk_income_it FOREIGN KEY(income_type) REFERENCES income_types(id)

);

INSERT INTO income(id, amount, income_type, currency_type, payment_type, created_at)
VALUES (1, 100000, 1, 1, 1, DEFAULT),
	   (2, 100000, 1, 1, 2, DEFAULT),
	   (3, 200, 2, 2, 2, DEFAULT),
	   (4, 000012, 4, 4, 3, DEFAULT),
	   (5, 10000, 3, 1, 2, DEFAULT),
	   (6, 100, 2, 2, 2, DEFAULT),
	   (7, 000008, 4, 4, 3, DEFAULT),
	   (8, 580, 2, 2, 2, DEFAULT);

DROP TABLE IF EXISTS income_types;
CREATE TABLE income_types(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(45) NOT NULL
);

INSERT INTO income_types(id, name) 
VALUES (1, 'salary'),
	   (2, 'profit_from_stocks'),
	   (3, 'bank_deposit'),
	   (4, 'donates');
	  




DROP TABLE IF EXISTS expenditures;
CREATE TABLE expenditures(
id INT NOT NULL PRIMARY KEY,
expenditure_type INT NOT NULL, 
amount BIGINT UNSIGNED DEFAULT NULL,
currency_type INT DEFAULT NULL,
payment_type INT DEFAULT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_expenditures_ct FOREIGN KEY(currency_type) REFERENCES currency_types(id),
CONSTRAINT fk_expenditures_pt FOREIGN KEY(payment_type) REFERENCES payment_types(id),
CONSTRAINT fk_expenditures_et FOREIGN KEY(expenditure_type) REFERENCES expenditure_types(id)
);

INSERT INTO expenditures(id, expenditure_type, amount, currency_type, payment_type)
VALUES (1, 1, 30000, 1, 2),
	   (2, 2, 700, 1, 1),
	   (3, 2, 1250, 1, 5),
	   (4, 4, 5000, 1, 2),
	   (5, 5, 2300, 1, 1),
	   (6, 6, 500, 1, 1),
	   (7, 14, 50, 3, 2),
	   (8, 10, 300, 1, 1),
	   (9, 12, 35000, 1, 2),
	   (10, 6, 1500, 1, 5),
	   (11, 9, 1500, 4, 5),
	   (12, 11, 2000, 2, 1),
	   (13, 2, 4100, 1, 2),
	   (14, 3, 7500, 1, 1),
	   (15, 7, 0001, 4, 3),
	   (16, 2, 1900, 1, 1),
	   (17, 5, 950, 1, 2),
	   (18, 8, 1000, 3, 2),
	   (19, 15, 3000, 1, 2),
	   (20, 1, 10000, 1, 1),
	   (21, 16, 120, 2, 2),
	   (22, 14, 2500, 1, 2),
	   (23, 16, 345, 2, 2);

DROP TABLE IF EXISTS expenditure_types;
CREATE TABLE expenditure_types(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(45) NOT NULL
);
INSERT INTO expenditure_types (id, name)
VALUES (1, 'housing'),
	   (2, 'food'),
	   (3, 'car'),
	   (4, 'fuel'),
	   (5, 'medicine'),
	   (6, 'connections'),
	   (7, 'entertainment'),
	   (8, 'clothes'),
	   (9, 'gifts'),
	   (10, 'taxi'),
	   (11, 'pets'),
	   (12, 'travels'),
	   (14, 'cafe'),
	   (15, 'sport'),
	   (16, 'stocks_loses'),
	   (17, 'others');
	   
	   


DROP TABLE IF EXISTS currency_types;
CREATE TABLE currency_types(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(10) NOT NULL
-- FOREIGN KEY (id) REFERENCES income (currency_type),
-- FOREIGN KEY (id) REFERENCES expenditures (currency_type)
);
INSERT INTO currency_types (id, name)
VALUES (1, 'RUR'), (2, 'USD'), (3, 'EUR'), (4, 'BTC');


DROP TABLE IF EXISTS payment_types;
CREATE TABLE payment_types(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(45) NOT NULL
-- FOREIGN KEY (id) REFERENCES income (payment_type),
-- FOREIGN KEY (id) REFERENCES expenditures (payment_type)
);

INSERT INTO payment_types(id, name)
VALUES (1, 'cash'), 
	   (2, 'debet_card'), 
	   (3, 'crypto_currency'),
	   (4, 'payment_systems'),
	   (5, 'credit_card');
			


DROP TABLE IF EXISTS budget;
CREATE TABLE budget(
id INT NOT NULL PRIMARY KEY,
income_plan INT UNSIGNED NOT NULL,
expenditure_plan INT UNSIGNED NOT NULL,
currency_type INT DEFAULT NULL,
CONSTRAINT fk_budget_ct FOREIGN KEY(currency_type) REFERENCES currency_types(id)
);

INSERT INTO budget(id, income_plan, expenditure_plan, currency_type)
VALUES (1, 200000, 150000, 1),
       (2, 1000, 800, 2),
       (3, 500, 600, 3),
       (4, 0001, 00005, 4);
      
      

DROP TABLE IF EXISTS payment_accounts;
CREATE TABLE payment_accounts(
id INT NOT NULL PRIMARY KEY,
name VARCHAR(45) NOT NULL,
currency_type INT NOT NULL,
payment_type INT NOT NULL,
CONSTRAINT fk_pa_ct FOREIGN KEY (currency_type) REFERENCES currency_types (id),
CONSTRAINT fk_pa_pt FOREIGN KEY (payment_type) REFERENCES payment_types (id)
);

INSERT INTO payment_accounts (id, name, currency_type, payment_type)
VALUES (1, 'Visa', 1, 2),
       (2, 'Maestro', 2, 2),
       (3, 'Master_card', 3, 2),
       (4, 'Visa', 1, 5),
       (5, 'Qiwi', 1, 3),
       (6, 'PayPall', 2, 3),
       (7, 'BTC_wallet', 4, 4);

      
DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications(
id INT NOT NULL PRIMARY KEY,
notes TEXT DEFAULT NULL,
CONSTRAINT fk_notes_exp FOREIGN KEY (id) REFERENCES expenditures (id)
-- CONSTRAINT fk_notes_income FOREIGN KEY (id) REFERENCES income (id)
);
DESCRIBE notifications;
INSERT INTO notifications (id, notes)
VALUES (1, 'regfrgqgirg'),
	   (2, 'sghfsghsghshsh'),
	   (3, 'shshshshsdhs'),
	   (4, 'xbvxvxvcxvxv'),
	   (5, 'reqyryeytergrad'),
	   (6, 'bsdhbfdbzs'),
	   (7, 'dsbvbvbdbbsddf'),
	   (8, 'eqreyre'),
	   (9, 'vxbvbvxc'),
	   (10, 'bvcxbvcbxvc'),
	   (11, 'vxvcbxcvbxcd'),
	   (12, 'trytr'),
	   (13, 'ouiuil'),
	   (14, 'xcbxjkbkcx'),
	   (15, 'xbxfbdaf'),
	   (16, 'qweqwe'),
	   (17, 'zxczxcsdwe'),
	   (18, 'klkknkvbn');
	   


DROP TABLE IF EXISTS saving;
CREATE TABLE saving(
id INT NOT NULL PRIMARY KEY,
amount INT UNSIGNED NOT NULL, 
currency_type INT DEFAULT NULL,
payment_type INT DEFAULT NULL,
CONSTRAINT fk_saving_ct FOREIGN KEY (currency_type) REFERENCES currency_types (id),
CONSTRAINT fk_saving_pt FOREIGN KEY (payment_type) REFERENCES payment_types (id)
);

INSERT INTO saving(id, amount, currency_type, payment_type)
VALUES (1, 2000, 1, 1),
	   (2, 100, 2, 2),
	   (3, 1500, 1, 2),
	   (4, 3200, 1, 2),
	   (5, 1500, 1, 1),
	   (6, 220, 2, 2),
	   (7, 890, 1, 1),
	   (8, 3500, 2, 2),
	   (9, 000001, 4, 4),
	   (10, 80, 2, 2);
	  

DROP TABLE IF EXISTS wishes;
CREATE TABLE wishes(
id INT NOT NULL PRIMARY KEY,
amount INT UNSIGNED NOT NULL,
name VARCHAR(45) NOT NULL,
CONSTRAINT fk_wishes_saving FOREIGN KEY (id) REFERENCES saving (id)
);

INSERT INTO wishes (id, amount, name)
VALUES (1, 100000, 'new_phone'),
       (2, 150000, 'travel'),
       (3, 40000, 'clothes'),
       (4, 100000, 'education'),
       (5, 50000, 'gift_for_mom'),
       (6, 3000000, 'car'),
       (7, 30000, 'birthday_party');
      
      
SELECT e.amount, et.name FROM expenditures e  -- сколько денег потрачено на жилье
JOIN expenditure_types et ON et.id = 1 AND expenditure_type = 1;



SELECT amount, 
	 (SELECT name FROM income_types WHERE id = 1) AS from_ -- сколько денег получено из зарплаты
FROM income i2 WHERE income_type = 1;



SELECT SUM(e.amount) AS total_sum, et.name, ct.name FROM expenditures e -- сколько денег потрачено на еду в рублях
JOIN expenditure_types et ON et.id = 2 AND e.expenditure_type = 2
JOIN currency_types ct ON ct.id = 1 AND e.currency_type = 1;






-- Представление
CREATE OR REPLACE VIEW view_income_exp
AS 
SELECT SUM(i.amount) AS income, SUM(e.amount) AS expenditures, pt.name FROM income i 
	 JOIN expenditures e ON i.payment_type = 2 AND e.payment_type = 2
	 JOIN payment_types pt ON pt.id = 2 GROUP BY pt.name;
	
SELECT * FROM view_income_exp;  -- доходы и расходы по дебетовой карте





-- Представление
CREATE OR REPLACE VIEW view_notes
AS 
SELECT e.id, n.notes FROM expenditures e
	 LEFT JOIN notifications n ON e.id = n.id ORDER BY e.id;
	
SELECT * FROM view_notes; -- смотрим заметки по расходам (по расходам с id 19 - 23 заметок нет)





-- Триггер
DROP TRIGGER IF EXISTS wrong_datas;

DELIMITER //

CREATE TRIGGER wrong_datas BEFORE UPDATE ON expenditures

FOR EACH ROW 

BEGIN 
	
	IF NEW.currency_type > 4 OR NEW.payment_type > 5 THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Warning! Wrong datas!'; -- делаем триггер на предупреждение о вводе неверных данных
	END IF ;

END //

DELIMITER ;

UPDATE expenditures

SET id = LAST_INSERT_ID() , expenditure_type = 2, amount = 1500, 
currency_type = 5, payment_type = 6, created_at = NOW();





-- Процедура
DROP PROCEDURE IF EXISTS expenditure_not_cash;

DELIMITER //

CREATE PROCEDURE expenditure_not_cash()

BEGIN 
	SELECT e.amount AS expenditures, pt.name AS source
	FROM expenditures e
		JOIN payment_types pt ON e.payment_type = pt.id AND pt.id != 1;
	
END //

DELIMITER ;

CALL expenditure_not_cash; -- получаем перечень всех расходов, не связанных с наличными





SHOW tables;

SELECT * FROM expenditures e ;
SELECT * FROM currency_types ct ;
SELECT * FROM expenditure_types;
SELECT * FROM income i ;
SELECT * FROM payment_types;
SELECT * FROM budget b ;
SELECT * FROM saving;
SELECT * FROM notifications n ;

