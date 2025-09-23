-- p.69~ / 실습6부터~

USE shopdb;

-- 뷰 생성
CREATE VIEW uv_membertbl 
AS SELECT memberName, memberAddress FROM membertbl;

SELECT * FROM uv_memberTBL;

-- 스토어드 프로시저
DELIMITER //
CREATE PROCEDURE myProc()
BEGIN 
	SELECT * FROM membertbl WHERE memberName = '당탕이';
	SELECT * FROM producttbl WHERE productName = '냉장고';
END //
delimiter;

CALL myProc();

-- 인서트
INSERT INTO membertbl VALUES 
('Figure', '연아', '경기도 군포시 당정동');

SELECT * FROM membertbl;

-- 데이터 변경
UPDATE membertbl SET memberAddress = '서울 강남구 역삼동' 
WHERE memberName = '연아';

-- 데이터 삭제
DELETE FROM membertbl WHERE memberName = '연아';

-- 지워진 데이터를 보관할 백업  테이블 생성
CREATE TABLE deletedMemberTBL (
memberID CHAR(8),
memberName CHAR(5),
memberAddress CHAR(20),
deletedDate date
);

-- 트리거 생성 -> 어떤 동작이 일어날 때, 자동으로 실행.
DELIMITER //
CREATE TRIGGER trg_deletedMemberTBL 
	AFTER DELETE
	ON memberTBL
	FOR EACH ROW
BEGIN 
INSERT INTO deletedMemberTBL VALUES 
(OLD.memberID, OLD.memberName, OLD.memberAddress, CURDATE() );
END //
delimiter;

DELETE FROM membertbl WHERE memberName = '당탕이';
SELECT * FROM deletedMemberTBL;

-- 백업과 복원

SELECT * FROM producttbl;

-- shopDB 우클릭 -> 데이터베이스를 sql로 내보내기.

DELETE FROM producttbl;

USE mysql; -- 다른 DB 선택 후, 파일 -> sql 파일 불러오기.

USE shopDB; 
-- shopDB 선택 후 shopDB 전체 쿼리 실행하면 복구완료

SELECT * FROM producttbl;




