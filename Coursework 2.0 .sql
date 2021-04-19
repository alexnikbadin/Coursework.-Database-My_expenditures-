/*  Данная база данных позволяет хранить и структурировать доходы
 * и расходы человека. В данной базе представлены таблицы учета доходов, расходов, типов валют, типов расчетов(нал/безнал),
 * бюджета, типов расходов, платежных аккаунтов, сбережений и пожеланий.
 */



DROP DATABASE my_expenditures;
CREATE DATABASE my_expenditures;

USE my_expenditures;

SHOW tables;



DROP TABLE IF EXISTS income;
CREATE TABLE income(
id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
amount FlOAT NOT NULL,
income_type INT NOT NULL,
currency_type INT NOT NULL,
payment_type INT NOT NULL,
source INT NOT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_income_ct FOREIGN KEY(currency_type) REFERENCES currency_types(id),
CONSTRAINT fk_income_pt FOREIGN KEY(payment_type) REFERENCES payment_types(id),
CONSTRAINT fk_income_it FOREIGN KEY(income_type) REFERENCES income_types(id),
CONSTRAINT fk_income_sources FOREIGN KEY(source) REFERENCES sources(id)
);

INSERT INTO income(amount, income_type, currency_type, payment_type, source, created_at)
VALUES (100000, 1, 1, 1, 8, DEFAULT),
	   (100000, 1, 1, 2, 1, DEFAULT),
	   (200, 2, 2, 2, 2, DEFAULT),
	   (0.00012, 4, 4, 3, 7, DEFAULT),
	   (10000, 3, 1, 2, 3, DEFAULT),
	   (100.5, 2, 2, 2, 2, DEFAULT),
	   (0.00008, 4, 4, 3, 7, DEFAULT),
	   (580, 2, 2, 2, 2, DEFAULT);

DROP TABLE IF EXISTS income_types;
CREATE TABLE income_types(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(45) NOT NULL UNIQUE
);

INSERT INTO income_types(name) 
VALUES ('salary'),
	   ('profit_from_stocks'),
	   ('bank_deposit'),
	   ('donates');
	  




DROP TABLE IF EXISTS expenditures;
CREATE TABLE expenditures(
id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
expenditure_type INT NOT NULL, 
amount FLOAT UNSIGNED DEFAULT NULL,
currency_type INT DEFAULT NULL,
payment_type INT DEFAULT NULL,
source INT NOT NULL,
notes TEXT DEFAULT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_expenditures_ct FOREIGN KEY(currency_type) REFERENCES currency_types(id),
CONSTRAINT fk_expenditures_pt FOREIGN KEY(payment_type) REFERENCES payment_types(id),
CONSTRAINT fk_expenditures_et FOREIGN KEY(expenditure_type) REFERENCES expenditure_types(id),
CONSTRAINT fk_expenditures_sources FOREIGN KEY(source) REFERENCES sources(id)
);

INSERT INTO expenditures(expenditure_type, amount, currency_type, payment_type, source, notes)
VALUES (1, 30000, 1, 2, 1, 'regfrgqgirg'),
	   (2, 700, 1, 1, 8, 'sghfsghsghshsh'),
	   (2, 1250, 1, 5, 2, 'sjahfdsahf'),
	   (4, 5000, 1, 2, 1, 'fhjvhcvhbas'),
	   (5, 2300, 1, 1, 8, DEFAULT),
	   (6, 500, 1, 1, 8, 'isuhsj'),
	   (14, 50, 3, 2, 3, 'abghabhb'),
	   (10, 300, 1, 1, 8, 'ashfgdsh'),
	   (12, 35000, 1, 2, 1, DEFAULT),
	   (6, 1500, 1, 5, 3, 'bvvreyqjj'),
	   (9, 1500, 4, 5, 5, 'vsufyeihwfb'),
	   (11, 2000, 2, 1, 2, 'asuhfbdshuafuh'),
	   (2, 4100, 1, 2, 3, 'yasfhbds'),
	   (3, 7500, 1, 1, 2, DEFAULT),
	   (7, 0.001, 4, 3, 7, 'sdahfvjhsdj'),
	   (2, 1900, 1, 1, 8, 'vshhf'),
	   (5, 950, 1, 2, 1, 'vcbhxabv'),
	   (8, 1000, 3, 2, 2, 'sibdihbsv'),
	   (15, 3000, 1, 2, 3, 'qibfhvb'),
	   (1, 10000, 1, 1, 8, 'ishbhbs'),
	   (16, 120, 2, 2, 1, 'iwbihdbs'),
	   (14, 2500, 1, 2, 2, 'iwebfihds'),
	   (16, 345, 2, 2, 6, 'aisbfihbs');
 
	  
DROP TABLE IF EXISTS expenditure_types;
CREATE TABLE expenditure_types(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(45) NOT NULL UNIQUE
);
INSERT INTO expenditure_types (name)
VALUES ('housing'),
	   ('food'),
	   ('car'),
	   ('fuel'),
	   ('medicine'),
	   ('connections'),
	   ('entertainment'),
	   ('clothes'),
	   ('gifts'),
	   ('taxi'),
	   ('pets'),
	   ('travels'),
	   ('cafe'),
	   ('sport'),
	   ('stocks_loses'),
	   ('others');
	   
	   


DROP TABLE IF EXISTS currency_types;
CREATE TABLE currency_types(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(10) NOT NULL UNIQUE
-- FOREIGN KEY (id) REFERENCES income (currency_type),
-- FOREIGN KEY (id) REFERENCES expenditures (currency_type)
);
INSERT INTO currency_types (name)
VALUES ('RUR'), ('USD'), ('EUR'), ('BTC');


DROP TABLE IF EXISTS payment_types;
CREATE TABLE payment_types(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(45) NOT NULL UNIQUE 
-- FOREIGN KEY (id) REFERENCES income (payment_type),
-- FOREIGN KEY (id) REFERENCES expenditures (payment_type)
);

INSERT INTO payment_types(name)
VALUES ('cash'), 
	   ('debet_card'), 
	   ('crypto_currency'),
	   ('payment_systems'),
	   ('credit_card');
			


DROP TABLE IF EXISTS budget;
CREATE TABLE budget(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
income_plan float UNSIGNED NOT NULL,
expenditure_plan float UNSIGNED NOT NULL,
currency_type INT DEFAULT NULL,
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT fk_budget_ct FOREIGN KEY(currency_type) REFERENCES currency_types(id)
);

INSERT INTO budget(income_plan, expenditure_plan, currency_type)
VALUES (200000, 150000, 1),
       (1000, 800, 2),
       (500, 600, 3),
       (0.001, 0.0005, 4);
      
      

DROP TABLE IF EXISTS sources;
CREATE TABLE sources(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(45) NOT NULL UNIQUE,
currency_type INT NOT NULL,
payment_type INT NOT NULL,
CONSTRAINT fk_pa_ct FOREIGN KEY (currency_type) REFERENCES currency_types (id),
CONSTRAINT fk_pa_pt FOREIGN KEY (payment_type) REFERENCES payment_types (id)
);

INSERT INTO sources (name, currency_type, payment_type)
VALUES ('Visa', 1, 2),
       ('Maestro', 2, 2),
       ('Master_card', 3, 2),
       ('Visa_usd', 1, 5),
       ('Qiwi', 1, 3),
       ('PayPall', 2, 3),
       ('BTC_wallet', 4, 4),
       ('from_cash', 1, 1);



DROP TABLE IF EXISTS saving;
CREATE TABLE saving(
id INT NOT NULL PRIMARY KEY,
amount float UNSIGNED NOT NULL, 
currency_type INT DEFAULT NULL,
payment_type INT DEFAULT NULL,
source int NOT NULL,
CONSTRAINT fk_saving_ct FOREIGN KEY (currency_type) REFERENCES currency_types (id),
CONSTRAINT fk_saving_pt FOREIGN KEY (payment_type) REFERENCES payment_types (id),
CONSTRAINT fk_saving_source FOREIGN KEY (source) REFERENCES sources (id)
);

INSERT INTO saving(id, amount, currency_type, payment_type, source)
VALUES (1, 2000, 1, 1, 8),
	   (2, 100, 2, 2, 3),
	   (3, 1500, 1, 2, 3),
	   (4, 3200, 1, 2, 1),
	   (5, 1500, 1, 1, 8),
	   (6, 220, 2, 2, 2),
	   (7, 890, 1, 1, 8),
	   (8, 3500, 2, 2, 2),
	   (9, 0.00001, 4, 4, 7),
	   (10, 80, 2, 2, 2);
	  

DROP TABLE IF EXISTS wishes;
CREATE TABLE wishes(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
amount float UNSIGNED NOT NULL,
name VARCHAR(45) NOT NULL,
source int NOT NULL,
CONSTRAINT fk_wishes_saving FOREIGN KEY (id) REFERENCES saving (id),
CONSTRAINT fk_wishes_source FOREIGN KEY (source) REFERENCES sources (id)
);

INSERT INTO wishes (amount, name, source)
VALUES (100000, 'new_phone', 1),
       (150000, 'travel', 1),
       (40000, 'clothes', 8),
       (100000, 'education', 2),
       (50000, 'gift_for_mom', 8),
       (3000000, 'car', 1),
       (30000, 'birthday_party', 8);
      
      
SELECT e.amount, et.name, e.notes FROM expenditures e  -- сколько денег потрачено на жилье
JOIN expenditure_types et WHERE et.name = 'housing' AND e.expenditure_type = 1;



SELECT amount,
	 (SELECT name FROM income_types it WHERE name = 'salary') AS from_
FROM income i WHERE income_type = (SELECT id FROM income_types WHERE name = 'salary'); -- сколько денег получено из зарплаты





SELECT SUM(e.amount) AS total_sum, et.name, ct.name 
FROM expenditures e                                            -- сколько денег потрачено на еду в рублях
	JOIN expenditure_types et ON et.id = e.expenditure_type 
	JOIN currency_types ct ON ct.id = e.currency_type
WHERE et.name = 'food' AND ct.name = 'RUR';






-- Представление
CREATE OR REPLACE VIEW view_income_debet
AS 
SELECT pt.name, SUM(i.amount) AS income
FROM payment_types pt
	 JOIN income i ON i.payment_type = pt.id
WHERE pt.name = 'debet_card' ;
	
SELECT * FROM view_income_debet;  -- доходы по дебетовой карте 




-- Представление
CREATE OR REPLACE VIEW view_Visa_rur
AS 
SELECT e.amount, s.name, ct.name AS currency FROM expenditures e -- расходы по карте Visa в рублях
	 JOIN sources s ON e.source = s.id 
	 JOIN currency_types ct
WHERE s.name = 'Visa' AND ct.name = 'RUR';

SELECT * FROM view_Visa_rur;





-- Триггер
DROP TRIGGER IF EXISTS using_source;

DELIMITER //

CREATE TRIGGER using_source BEFORE UPDATE ON my_expenditures.sources

FOR EACH ROW 

BEGIN     -- делаем триггер на предупреждение о вводе существующего источника
	
	IF NEW.name = OLD.name THEN 
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Warning! You are already using this source '; 
END IF ;

END //

DELIMITER ;

UPDATE sources 

SET id = LAST_INSERT_ID(), name = 'Visa', 
currency_type = 1, payment_type = 1;





-- Процедура
DROP PROCEDURE IF EXISTS payment_type_expenditures;

DELIMITER //

CREATE PROCEDURE payment_type_expenditures(IN name VARCHAR(45))

BEGIN 
	SELECT e.amount AS expenditures, pt.name AS source
	FROM expenditures e
		JOIN payment_types pt ON e.payment_type = pt.id 
WHERE pt.name = name;
	
END //

DELIMITER ;

CALL payment_type_expenditures('cash'); -- процедура получения расходов по имени платежного типа





SHOW tables;

SELECT * FROM expenditures e ;
SELECT * FROM currency_types ct ;
SELECT * FROM expenditure_types;
SELECT * FROM income i ;
SELECT * FROM payment_types;
SELECT * FROM budget b ;
SELECT * FROM saving;
SELECT * FROM sources s;
DESCRIBE payment_typeS;

