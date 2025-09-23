CREATE DATABASE shopDB2;

CREATE TABLE memberTB(
	memberID CHAR(8) NOT NULL,
	memberName CHAR(5) NOT NULL,
	memberAddress CHAR(20),
	PRIMARY KEY (memberID)
);

CREATE TABLE productTB(
	productName CHAR(4) NOT null,
	cost INT NOT null,
	MAKEDATE DATE,
	company CHAR(4),
	amount INT NOT NULL,
	PRIMARY KEY (productName)
);

SELECT * FROM membertb;
SELECT * FROM productTB;

INSERT INTO membertb(memberID, memberName, memberAddress)
VALUES
('Dang', '당탕이', '경기 부천시 중동'),
('Jee', '지운이', '서울 은평구 증산동'),
('Sang', '상길이', '경기 성남구 분당구');

INSERT INTO productTB(productName, cost, MAKEDATE, company, amount)
VALUES
('컴퓨터', 10, '2017-01-01', '삼성', 17),
('세탁기', 20, '2018-09-01', 'LG', 3),
('냉장고', 5, '2019-02-01', '대우', 22);

SELECT membername, memberaddress FROM membertb;
SELECT * FROM membertb WHERE membername = '지운이';

CREATE TABLE `my testTB`(
	id int
);

DROP TABLE `my testTB`;
SELECT * FROM `my testTB`;

CREATE TABLE indexTB 
(first_name VARCHAR(14), last_name VARCHAR(16), hire_date DATE);

INSERT INTO indexTB
	SELECT first_name, last_name, hire_date
	FROM employees.employees
	LIMIT 500;
	
SELECT * FROM indexTB;
SELECT * FROM indexTB WHERE first_name = 'mary';
EXPLAIN SELECT * FROM indexTB WHERE first_name = 'mary';

CREATE INDEX idx_indexTB_firstname ON indexTB(first_name);

