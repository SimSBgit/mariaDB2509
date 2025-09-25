
SHOW DATABASES;

USE employees;

SELECT * FROM  employees;

-- 아래 두 코드의 실행 결과는 같다.
SELECT * FROM titles;
SELECT * FROM employees.titles;

-- 원하는 필드 불러오기
SELECT first_name FROM employees;
SELECT first_name, last_name, gender FROM employees;

-- 테이블과 테이블 필드 조회하기
SHOW TABLE STATUS;

DESCRIBE employees;
DESC employees;

SELECT first_name, gender FROM employees;

-- alias = as
SELECT first_name AS 이름, last_name AS 성, gender AS 성별 FROM employees;

-- 6장 이후 실습에 사용할 DB 만들기

DROP DATABASE if EXISTS sqlDB;
CREATE DATABASE sqlDB;

USE sqlDB;

CREATE TABLE userTbl
(	userID		CHAR(8) NOT NULL PRIMARY KEY,
	NAME			VARCHAR(10) NOT NULL,
	birthYear 	INT NOT NULL,
	addr			CHAR(2) NOT NULL,
	mobile1		CHAR(3),
	mobile2		CHAR(8),
	height		SMALLINT,
	mDate			DATE
);

CREATE TABLE buyTbl
(	num			INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	userID		CHAR(8) NOT NULL,
	prodName		CHAR(6) NOT NULL,
	groupName	CHAR(4),
	price			INT NOT NULL,
	amount		SMALLINT NOT NULL,
	FOREIGN KEY (userID) REFERENCES userTbl(userID)
);

INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-5-5');
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , N'서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;

-- where

USE sqlDB;

SELECT * FROM usertbl WHERE NAME = '김경호';
SELECT userID, NAME FROM usertbl WHERE birthYear >= 1970 AND height >= 182;
SELECT userID NAME FROM usertbl WHERE birthYear >=1970 OR height >= 182;

-- between / and / or
SELECT NAME, height FROM usertbl WHERE height >= 180 AND height <= 183;
SELECT NAME, height FROM usertbl WHERE height BETWEEN 180 AND 183;
SELECT NAME, addr FROM usertbl 
WHERE addr='경남' OR addr='전남' OR addr='경북';

-- in / like
SELECT NAME, addr FROM usertbl WHERE addr IN ('경남', '전남', '경북');
SELECT NAME, height FROM usertbl WHERE NAME LIKE '김%';
SELECT NAME, height FROM usertbl WHERE NAME LIKE '_종신';

-- 서브쿼리 / any / all
SELECT NAME, height FROM usertbl WHERE height > 177;

SELECT NAME, height FROM usertbl 
WHERE height > (SELECT height FROM usertbl WHERE NAME = '김경호');

SELECT NAME, height FROM usertbl  -- >> 170보다 큰 사람
WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');

SELECT NAME, height FROM usertbl  -- >> 173보다 큰 사람
WHERE height >= ALL (SELECT height FROM usertbl WHERE addr = '경남');

SELECT NAME, height FROM usertbl  -- >> in과 같은 결과
WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');

SELECT NAME, height FROM usertbl  -- >> any와  같은 결과
WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남');

-- order by = 순서 정렬 / 성능 저하 발생 여지 있음. 꼭 필요할 때만 사용.
SELECT NAME, mDate FROM usertbl ORDER BY mDate;
SELECT NAME, mdate FROM usertbl ORDER BY mDate DESC;
SELECT NAME, height FROM usertbl ORDER BY height DESC, NAME ASC;

-- distinct
SELECT addr FROM usertbl;
SELECT addr FROM usertbl ORDER BY addr;
SELECT DISTINCT addr FROM usertbl ORDER BY addr;

-- limit
USE employees;

SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC;

-- 아래 두 코드의  문법은 같은 결과를 출력
SELECT emp_no, hire_date FROM employees ORDER BY hire_date ASC LIMIT 0, 5;
SELECT emp_no, hire_date FROM employees 
ORDER BY hire_date ASC LIMIT 5 OFFSET 2;

-- create table ... (select ...); -> 테이블 복사
USE sqlDB;
CREATE TABLE buytbl2 (SELECT * FROM buyTbl);
SELECT * FROM buytbl2;

SELECT * FROM buytbl;

CREATE TABLE buytbl3 (SELECT userID, prodName FROM buyTbl);
SELECT * FROM buyTbl3;

-- group by
USE sqlDB;

SELECT * FROM buytbl;
SELECT * FROM usertbl;

SELECT userid, amount FROM buytbl ORDER BY userid;

SELECT userid '사용자 아이디', SUM(amount) '총 구매 개수'  
FROM buytbl GROUP BY userid;

SELECT userid '사용자 아이디', SUM(amount*price) '총 구매액'  
FROM buytbl GROUP BY userid;

SELECT AVG(amount) '평균 구매 개수' FROM buytbl;
SELECT userid, AVG(amount) '평균 구매 개수' FROM buytbl GROUP BY userid;

-- 가장 큰 키, 가장 작은 키의 이름과 키 나열.
SELECT NAME, MAX(height), MIN(height) FROM usertbl GROUP BY NAME; -- X

SELECT NAME, height FROM usertbl												-- O
WHERE height = (SELECT MAX(height) FROM usertbl)
	OR height = (SELECT MIN(height) FROM usertbl);
	
SELECT COUNT(mobile1) FROM usertbl;
SELECT COUNT(DISTINCT mobile2) FROM usertbl;

SELECT userid '사용자', SUM(price*amount) '총 구매액'
FROM buytbl GROUP BY userid HAVING SUM(price*amount) > 1000
ORDER BY SUM(price*amount);

-- rollup
SELECT num, groupName, SUM(price*amount) '비용'
FROM buytbl GROUP BY groupName, num WITH ROLLUP;

SELECT groupname, SUM(price*amount) '비용'
FROM buytbl GROUP BY groupname WITH ROLLUP;

-- insert
CREATE TABLE testTbl1 (id INT, userName CHAR(3), age int);
INSERT INTO testTbl1 VALUES (1, '홍길동', 25);

SELECT * FROM testtbl1;

INSERT INTO testtbl1(id, username) VALUES (2, '설현');
-- 열 순서를 다르게 하고 싶을 땐, 값도 바꾼 열 순서에 맞게 입력.
INSERT INTO testtbl1(username, age, id) VALUES ('초아', 26, 3);

-- 자동으로 증가하는 auto_increment
CREATE TABLE testTbl2
	(id INT AUTO_INCREMENT PRIMARY KEY,
	userName CHAR(3),
	age INT);

INSERT INTO testTbl2 (id, userName, age)
VALUES
(NULL, '지민', 25),
(NULL, '유나', 22),
(NULL, '유경', 21);

SELECT * FROM testTbl2;
DELETE from testtbl2;

-- 인서트 이후에 자동 삽입된 id의 
-- 첫 번째와 마지막 값을 확인하는 방법에 대한 예시.
SELECT LAST_INSERT_ID();
-- 아래 코드는 마지막id가 원하는 값이 나오긴 하지만 
-- 실무에서 사용하지 않는다고 함.
SELECT MAX(id) FROM testtbl2;
-- 마지막 id는 원하는 값이 나오지 않고 있음.
SELECT LAST_INSERT_ID() AS first_id, ROW_COUNT() AS inserted_rows;

ALTER TABLE testTbl2 AUTO_INCREMENT=100;
INSERT INTO testTbl2 VALUES (NULL, '찬미', 23);
SELECT * FROM testTbl2;

-- 1000에서 시작해서 3씩 증가하는 id를 가진 테이블
CREATE TABLE testTbl3
	(id INT AUTO_INCREMENT PRIMARY KEY,
	userName CHAR(3),
	age INT);

ALTER TABLE testTbl3 AUTO_INCREMENT=1000;
SET @@auto_increment_increment=3;

INSERT INTO testTbl3 (id, userName, age)
VALUES
(NULL, '나연', 20),
(NULL, '정연', 18),
(NULL, '모모', 19);

SELECT * FROM testTbl3;

USE sqldb;

-- 다른 테이블로부터 대량의 데이터 샘플 가져오기.
CREATE TABLE testTbl4
	(id INT,
	Fname VARCHAR(50),
	Lname VARCHAR(50)
	);

INSERT INTO testTbl4
	SELECT emp_no, first_name, last_name
		FROM employees.employees;

CREATE TABLE testTbl5
	(SELECT emp_no, first_name, last_name FROM employees.employees);

-- update
UPDATE testtbl4
	SET Lname = '없음'
	WHERE Fname = 'Kyoichi';

UPDATE testtbl3 SET age = age * 1.5;

DELETE FROM testtbl4 WHERE fname = 'Aamer';
SELECT * FROM testtbl4;

DELETE FROM testtbl4 WHERE fname = 'Mary' LIMIT 5;

CREATE TABLE bigtbl1 (SELECT * FROM employees.employees);
CREATE TABLE bigtbl2 (SELECT * FROM employees.employees);
CREATE TABLE bigtbl3 (SELECT * FROM employees.employees);

-- delete가 가장 안좋음.
DELETE FROM bigtbl1;
DROP TABLE bigtbl2;
TRUNCATE TABLE bigtbl3;

CREATE TABLE memberTbl (SELECT userID, NAME, addr FROM usertbl LIMIT 3);
ALTER TABLE memberTbl
	ADD CONSTRAINT pk_memberTbl PRIMARY KEY (userID);
SELECT * FROM memberTbl;

-- insert <<ignore>> into
INSERT INTO memberTbl VALUES('BBK', '비비코', '미국');
INSERT INTO memberTbl VALUES('SJH', '서장훈', '서울');
INSERT INTO memberTbl VALUES('HJY', '현주엽', '경기');

INSERT IGNORE INTO memberTbl VALUES('BBK', '비비코', '미국');
INSERT IGNORE INTO memberTbl VALUES('SJH', '서장훈', '서울');
INSERT IGNORE INTO memberTbl VALUES('HJY', '현주엽', '경기');

SELECT * FROM membertbl;

-- duplicate 인서트시  데이터 중복시 중복된 데이터 수정.
INSERT INTO memberTbl VALUES('BBK', '비비코', '미국')
	ON DUPLICATE KEY UPDATE NAME='비비코', addr='미국';
INSERT INTO memberTbl VALUES('DJM', '동짜몽', '일본')
	ON DUPLICATE KEY UPDATE NAME='동짜몽', addr='일본';

-- with / 비재귀적 CTE
SELECT userid AS '사용자', SUM(price*amount) AS '총 구매액'
	FROM buytbl GROUP BY userid;

WITH abc(userid, total)
AS
(SELECT userid, SUM(price*amount)
FROM buytbl GROUP BY userid)
SELECT * FROM abc ORDER BY total DESC;

SELECT * FROM usertbl;

SELECT addr, MAX(height) FROM usertbl GROUP BY addr;

-- with 구문 사용 문법
WITH cte_userTBL(addr, maxHeight)
AS
(SELECT addr, MAX(height) FROM usertbl GROUP BY addr)
SELECT AVG(maxHeight) AS '최고키의 평균' FROM cte_userTBL;

