-- 보여줘 DB목록
SHOW DATABASES;

USE employees;

SHOW TABLES;

-- 전체  table
SELECT * FROM employees;

SELECT first_name FROM employees;

SELECT first_name, last_name FROM employees;

SELECT first_name, last_name, gender FROM employees;

-- 상세

DESCRIBE employees;

SELECT first_name AS 이름, gender 성별, hire_date '회사 입사일'
FROM employees;

DROP DATABASE IF EXISTS sqlDB;

CREATE TABLE userTbl
( userID CHAR(8) NOT NULL,
  name VARCHAR(10) NOT NULL,
  birthYear INT NOT NULL,
  addr CHAR(2) NOT NULL,
  mobile1 CHAR(3),
  mobile2 CHAR(8),
  height SMALLINT,
  mDate DATE
);

CREATE TABLE buyTbl
( num INT AUTO_INCREMENT NOT NULL,
  userID CHAR(8) NOT NULL,
  prodName CHAR(6) NOT NULL,
  groupName CHAR(4) ,
  price INT NOT NULL,
  amount SMALLINT NOT NULL
);

INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '010', '22222222', 173, '2008-09-16');
INSERT INTO userTbl VALUES('KKH', '김경호', 2008, '스울', '101', '33333333', 190, '2015-03-19');
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buyTbl VALUES(NULL, 'LSG', '모니터', '전자', 200, 1);
INSERT INTO buyTbl VALUES(NULL, 'KKH', '청바지', '의류', 50, 3);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

ALTER TABLE userTbl DROP PRIMARY KEY;

DESCRIBE userTbl;

SELECT * FROM information_schema.KEY_COLUMN_USAGE WHERE TABLE_NAME = 'userTbl';

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'buyTbl'
  AND REFERENCED_TABLE_NAME = 'userTbl';
  
ALTER TABLE buyTbl DROP FOREIGN KEY buytbl_ibfk_1;