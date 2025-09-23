USE exdb;

SHOW TABLES;

SELECT * FROM customers;
SELECT * FROM customers WHERE Country = 'Germany' AND city = 'Berlin';
SELECT * FROM customers WHERE City = 'Berlin' OR city = 'stuttgart';
SELECT * FROM customers WHERE Country = 'Germany' OR Country = 'Spain';
SELECT * FROM customers WHERE NOT Country = 'Germany';
SELECT * FROM customers WHERE Country = 'Germany' AND (city = 'berlin' OR city = 'stuttgart');
SELECT * FROM customers WHERE not country = 'germany' AND NOT country = 'usa';

SELECT * FROM customers ORDER BY country;
SELECT * FROM customers ORDER BY country DESC;
SELECT * FROM customers ORDER BY country, customername;
SELECT * FROM customers ORDER BY country ASC, customername DESC;

CREATE TABLE testnull(
num INT,
NAME VARCHAR(10)
);

SELECT * FROM testnull;

INSERT INTO testnull VALUES(1, '길동');
INSERT INTO testnull(num) VALUES(2);
INSERT INTO testnull VALUES(3, '정조');
INSERT INTO testnull VALUES(4, '세종');

SELECT * FROM testnull WHERE NAME IS NULL;
SELECT * FROM testnull WHERE NAME IS not NULL;




