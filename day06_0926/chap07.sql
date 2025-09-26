USE sqldb;

-- 변수의 사용
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수 이름==> ';

SELECT @myVar1;
SELECT @myVar2 + @myVar3;

SELECT @myVar4 , NAME FROM usertbl WHERE height > 180;

SET @myVar1 = 3;
PREPARE myQuery
	FROM 'SELECT name, height FROM userTBL ORDER BY height LIMIT ?';
EXECUTE myQuery USING @myVar1;

-- cast() / convert() = 데이터 형식 변환
SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl;
-- 반올림
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl;
SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매 개수' FROM buytbl;

-- concat( + cast( as ) + 구분자 $ / % @ ) 
SELECT CAST('2022$12$12' AS DATE);
SELECT CAST('2022/12/12' AS DATE);
SELECT CAST('2022%12%12' AS DATE);
SELECT CAST('2022@12@12' AS DATE);

SELECT num, CONCAT(CAST(price AS CHAR(10)), 'X', CAST(amount AS CHAR(4)), '=')
AS '단가X수량', price * amount AS '구매액' FROM buytbl;

SELECT * FROM buytbl;

-- 암시적인 형 변환
SELECT '100' + '200';
SELECT CONCAT('100', '200');
SELECT CONCAT(100, '200');
SELECT 1 > '2mega';
SELECT 3 > '2MEGA';
SELECT 0 = 'mege2';

-- mariaDB 내장 함수

-- 1. 제어 흐름 함수

-- if 
SELECT if (100 > 200, '참이다', '거짓이다');

-- if Null
SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요');

-- null IF
SELECT NULLIF(100, 100), NULLIF(200, 100);

-- case ~ when ~ else ~ end
SELECT case 10
	when 1 then '일'
	when 5 then '오'
	when 10 then '십'
	ELSE '모름'
END;

-- 2. 문자열 함수

-- ASCII / CHAR
SELECT ASCII('A'), CHAR(65);

-- big_length / char_length / length
SELECT bit_length('abc'), char_length('abc'), LENGTH('abc');
SELECT bit_length('가나다'), char_length('가나다'), LENGTH('가나다');

-- concat(문자열1, 문자열2, ~) / concat(구분자, 문자열1, ~)
SELECT CONCAT_WS('/', '2022', '01', '22');

-- ELT / Field / Find_in_set / Instr / Locate = Position
SELECT ELT(2, '하나', '둘', '셋'), FIELD('둘', '하나', '둘', '셋'), 
FIND_IN_SET('둘', '하나,둘,셋'), INSTR('하나둘셋', '둘'), 
LOCATE('둘', '하나둘셋');

-- format(숫자, 소수점 자릿수)
SELECT FORMAT(123456.123456, 5);

